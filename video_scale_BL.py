"""
Program to measure scale / body length from video files manually
videoScaleBL.py
N. Mizumoto
"""


# ---------------------------------------------------------------------------------------------
# packages
# ---------------------------------------------------------------------------------------------
import PySimpleGUI as sg
import cv2
import sys
import numpy as np
import glob
import tqdm
from keyboard import press
import os
import math
import pandas as pd


# ---------------------------------------------------------------------------------------------
# Main part of video analysis
# ---------------------------------------------------------------------------------------------
def ImageAnalysis(idir, odir, img_scale, measure_scale, shape, num_ind, frame_interval):

    # Loading data
    path = glob.glob(idir + os.sep + "*.mp4")
    file_nums = list(range((len(path))))

    # Dataframe
    df_column = ["name", "width", "height", "length", "fps", "frame", "scale"]
    for i in range(num_ind):
        df_column.append("bodyLength" + str(i))
    df = pd.DataFrame(np.arange(len(path)*(7+num_ind)). reshape(len(path), 7+num_ind),
                      columns=df_column)

    # ------------------ main ------------------
    for i in file_nums:
        cv2.namedWindow(winname='window')

        # ----- file info -----
        v = path[i]
        file_name = os.path.basename(v)
        name = file_name.split('.')[0]
        video = cv2.VideoCapture(v)
        width = video.get(cv2.CAP_PROP_FRAME_WIDTH)
        height = video.get(cv2.CAP_PROP_FRAME_HEIGHT)
        count = video.get(cv2.CAP_PROP_FRAME_COUNT)
        fps = video.get(cv2.CAP_PROP_FPS)
        print("name:{}, width:{}, height:{}, count:{}, fps:{}".format(name, width, height, count, fps))
        # ----------

        # region ----- 1. Extract frame -----
        def frame_check(event, x, y, flags, param):
            if event == cv2.EVENT_LBUTTONDOWN:
                press('l')
            if event == cv2.EVENT_RBUTTONDOWN:
                press('r')

        frame_id = 0
        while True:
            video.set(cv2.CAP_PROP_POS_FRAMES, frame_id)
            ret, frame = video.read()
            frame = cv2.resize(frame, dsize=None, fx=img_scale, fy=img_scale)
            frame_copy = frame.copy()
            cv2.putText(frame_copy,
                        'frame number: ' + str(frame_id),
                        (10, 50), cv2.FONT_HERSHEY_PLAIN, 2, (0, 0, 255), 2, cv2.LINE_AA)
            cv2.putText(frame_copy,
                        'Use this frame? Yes -> L click, No -> R click',
                        (10, 100), cv2.FONT_HERSHEY_PLAIN, 2, (0, 0, 255), 2, cv2.LINE_AA)
            cv2.imshow('window', frame_copy)
            cv2.setMouseCallback('window', frame_check)
            k = cv2.waitKey(0)
            if k == ord("l"):
                img = frame.copy()
                break
            elif k == ord("r"):
                frame_id   = frame_id + 3000
                if frame_id > count:
                    print("End of frames. Maybe reduce frame_interval to sample more frames.")
                    frame_id = 0
            elif k == 27:
                break

        if k == 27:
            break
        # endregion ----------

        # region ----- 2. Scale -----
        if measure_scale == "True":
            sx0, sy0 = 0, 0
            sx1, sy1 = 0, 0
            def line_scale(event, x, y, flags, param):
                nonlocal sx0, sy0, sx1, sy1, scale, drawing, end
                if event == cv2.EVENT_LBUTTONDOWN:
                    drawing = True
                    sx0, sy0 = x, y
                elif event == cv2.EVENT_MOUSEMOVE:
                    if drawing:
                        cv2.line(img_copy, (sx0, sy0), (x, y), (0, 0, 255), 1)
                elif event == cv2.EVENT_LBUTTONUP:
                    sx1, sy1 = x, y
                    cv2.line(img_copy, (sx0, sy0), (sx1, sy1), (0, 0, 255), 1)
                    drawing = False
                if event == cv2.EVENT_RBUTTONDOWN:
                    end = 1
                press('enter')

            def circle_scale(event, x, y, flags, param):
                nonlocal sx0, sy0, sx1, sy1, scale, drawing, end, img_output
                if event == cv2.EVENT_LBUTTONDOWN:
                    drawing = True
                    sx0, sy0 = x, y
                elif event == cv2.EVENT_MOUSEMOVE:
                    if drawing:
                        cv2.circle(img_copy, center=(int((x - sx0) / 2) + sx0, int((y - sy0) / 2) + sy0),
                                   radius=int(math.sqrt((sx0 - x) ** 2 + (sy0 - y) ** 2) / 2),
                                   color=(0, 0, 255), thickness=1)
                elif event == cv2.EVENT_LBUTTONUP:
                    scale = math.sqrt((sx0 - x) ** 2 + (sy0 - y) ** 2)
                    cv2.circle(img_copy, center=(int((x - sx0) / 2) + sx0, int((y - sy0) / 2) + sy0),
                               radius=int(scale / 2),
                               color=(0, 0, 255), thickness=1)
                    cv2.circle(img_output, center=(int((x - sx0) / 2) + sx0, int((y - sy0) / 2) + sy0),
                               radius=int(scale / 2),
                               color=(0, 0, 255), thickness=1)

                    drawing = False
                if event == cv2.EVENT_RBUTTONDOWN:
                    end = 1
                press('enter')

            img = frame
            img_copy = img.copy()
            img_output = img.copy()
            end = 0
            drawing = False
            while True:
                cv2.imshow('window', img_copy)
                if drawing:
                    img_copy = img.copy()
                cv2.putText(img_copy, 'Circle scaling. L DOWN -> L UP. R click to finish', (10, 50), cv2.FONT_HERSHEY_PLAIN, 2,
                            (0, 0, 255),
                            2, cv2.LINE_AA)
                cv2.setMouseCallback('window', circle_scale)
                if cv2.waitKey(0) & end == 1:
                    break
        else:
            scale = width
        # endregion

        drawing = False
        img_output = img.copy()
        # region ----- 3. Body length -----
        def obtainBodyLength(event, x, y, flags, param):
            nonlocal sx0, sy0, bl, drawing, end, img_output
            if event == cv2.EVENT_LBUTTONDOWN:
                drawing = True
                sx0, sy0 = x, y
            elif event == cv2.EVENT_MOUSEMOVE:
                if drawing:
                    cv2.line(img_copy, (sx0, sy0), (x, y), (0, 0, 255), 1)
            elif event == cv2.EVENT_LBUTTONUP:
                cv2.line(img_copy, (sx0, sy0), (x, y), (0, 0, 255), 1)
                cv2.line(img_output, (sx0, sy0), (x, y), (0, 0, 255), 1)
                bl = math.sqrt((x-sx0)**2 + (y-sy0)**2)
                drawing = False
            if event == cv2.EVENT_RBUTTONDOWN:
                end = 1
            press('enter')

        body_length = [0] * num_ind
        for ii in range(num_ind):
            bl, end = 0, 0
            img_copy = img.copy()
            while True:
                cv2.imshow('window', img_copy)
                if drawing:
                    img_copy = img.copy()
                cv2.putText(img_copy, 'Body Length. L DOWN -> L UP. R click to finish', (10, 50), cv2.FONT_HERSHEY_PLAIN,
                            2,
                            (0, 0, 255),
                            2, cv2.LINE_AA)
                cv2.setMouseCallback('window', obtainBodyLength)
                if cv2.waitKey(0) & end == 1:
                    break
            img = img_copy
            body_length[ii] = bl/img_scale
        # endregion

        # region ----- 4. Output -----#
        df.iloc[i:(i+1), 0:7] = [name, width, height, count, fps, frame_id, scale,]
        for ii in range(num_ind):
            df.iloc[i:(i+1), 7+ii] = body_length[ii]
        cv2.putText(img_output, name, (10, 50), cv2.FONT_HERSHEY_PLAIN, 2, (0, 0, 255), 2, cv2.LINE_AA)
        cv2.imwrite(odir + "/" + name + ".jpg", img_output)

    cv2.destroyAllWindows()

    print(df)

    with open(odir + '/res.pickle', mode='wb') as f:
        pickle.dump(df, f)

    df.to_csv(odir + '/res.csv')


# ---------------------------------------------------------------------------------------------
# GUI
# ---------------------------------------------------------------------------------------------
sg.theme('Dark')
frame1 = sg.Frame('', [
    [sg.Text("In"),
     sg.InputText('Input folder', key='-INPUTTEXT-', enable_events=True, ),
     sg.FolderBrowse(button_text='select', size=(8, 1), key="-INFOLDERNAME-")
     ],
    [sg.Text("Out"),
     sg.InputText('Output folder', key='-INPUTTEXT-', enable_events=True, ),
     sg.FolderBrowse(button_text='select', size=(8, 1), key="-OUTFOLDERNAME-"),
     sg.Text("(* will be created if not specified)")
     ],
     [sg.Text("Scale (default = 0.5)"),
     sg.In(key='-scale-')],
     [sg.Text("crop select shape"),
     sg.Combo(['circle', 'square'], default_value="circle", size=(4, 1), key="-shape")
     ],
     [sg.Text("measure_scale"),
     sg.Combo(['True', 'False'], default_value="True", size=(4, 1), key="-measure_scale")
     ],     
     [sg.Text("Num of individual (default = 2)"),
     sg.In(key='-NUMIND-')],
     [sg.Text("Sample frame interval (default = 3000)"),
     sg.In(key='-FRAMEINTERVAL-')]
], size=(800, 300))

frame2 = sg.Frame('', [
    [sg.Submit(button_text='Start', size=(10, 3), key='button_start')]], size=(100, 140))

layout = [[frame1, frame2]]

window = sg.Window('files', layout, resizable=True)


while True:
    event, values = window.read()

    if event is None:
        print('exit')
        break

    if len(values["-INFOLDERNAME-"]) == 0:
            print("no input!")
    else:
        if event == 'button_start':
            idir = values["-INFOLDERNAME-"]
            if len(values["-OUTFOLDERNAME-"]) == 0:
                odir = idir + "/ouput/"
                if not os.path.exists(odir):
                    os.makedirs(odir)
            else:
                odir = values["-OUTFOLDERNAME-"]

            if len(values["-scale-"]) == 0:
                img_scale = 0.5
            else:
                img_scale = float(values["-scale-"])

            if len(values["-NUMIND-"]) == 0:
                num_ind = 2
            else:
                num_ind = int(values["-NUMIND-"])

            if len(values["-FRAMEINTERVAL-"]) == 0:
                frame_interval = 3000
            else:
                frame_interval = int(values["-FRAMEINTERVAL-"])

            shape = values["-shape"]    
            measure_scale = values["-measure_scale"]    

            ImageAnalysis(idir, odir, img_scale, measure_scale, shape, num_ind, frame_interval)
window.close()



