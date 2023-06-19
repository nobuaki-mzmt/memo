
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


# ---------------------------------------------------------------------------------------------
# Main part of video analysis
# ---------------------------------------------------------------------------------------------
def ImageAnalysis(idir, odir, scale, cropping, shape, fwidth, v_len, offset, output_FPS):

    path = glob.glob(idir + os.sep + "*.mp4")
    filenums = list(range((len(path))))

    for i in filenums:
        v = path[i]
        video = cv2.VideoCapture(v)
        
        width = video.get(cv2.CAP_PROP_FRAME_WIDTH)
        height = video.get(cv2.CAP_PROP_FRAME_HEIGHT)

        fps = video.get(cv2.CAP_PROP_FPS)
        if int(fps) == 29:
            fps = 30
        elif int(fps) == 59:
            fps = 60
        else:
            return("FPS is not 29.97 or 59.94")

        total_frames = int(video.get(cv2.CAP_PROP_FRAME_COUNT))
        start_frame = int(video.get(cv2.CAP_PROP_FPS) * offset)
        if v_len > 0:
            end_frame = start_frame + int(v_len * fps)
        else:
            end_frame = total_frames

        print(v)
        print("width:{}, height:{}, total_frames:{}, fps:{}".format(width, height, total_frames, video.get(cv2.CAP_PROP_FPS)))

        ## Cropping
        x0, y0, x1, y1 = 0, 0, int(width), int(height)
        drawing = True
        if cropping == "True":
            # select crop range
            video.set(cv2.CAP_PROP_POS_FRAMES, 0)
            ret, frame = video.read()
            img = frame.copy()

            img2 = cv2.resize(img, dsize=None, fx=scale, fy=scale)
            sx0, sy0 = 0,0
            if shape == "circle":
                def trim_click(event, x, y, flags, param):
                    nonlocal sx0, sy0, x0, y0, x1, y1, scale, drawing, end
                    if event == cv2.EVENT_LBUTTONDOWN:
                        drawing = True
                        sx0, sy0 = x, y
                    elif event == cv2.EVENT_MOUSEMOVE:
                        if drawing:
                            cv2.circle(img_copy, center=(int((x - sx0) / 2) + sx0, int((y - sy0) / 2) + sy0),
                                       radius=int(math.sqrt((sx0 - x) ** 2 + (sy0 - y) ** 2) / 2),
                                       color=(0, 0, 255), thickness=1)
                    elif event == cv2.EVENT_LBUTTONUP:
                        diameter = math.sqrt((sx0 - x) ** 2 + (sy0 - y) ** 2)
                        cv2.circle(img_copy, center=(int((x - sx0) / 2) + sx0, int((y - sy0) / 2) + sy0),
                                   radius=int(diameter / 2),
                                   color=(0, 0, 255), thickness=1)
                        x0 = ((x - sx0) / 2) + sx0 - (diameter / 2)
                        y0 = ((y - sy0) / 2) + sy0 - (diameter / 2)
                        x1 = ((x - sx0) / 2) + sx0 + (diameter / 2)
                        y1 = ((y - sy0) / 2) + sy0 + (diameter / 2)
                        drawing = False
                    elif event == cv2.EVENT_RBUTTONDOWN:
                        end = 1
                    press('enter')
            elif shape == "square":
                def trim_click(event, x, y, flags, param):
                    nonlocal sx0, sy0, x0, y0, x1, y1, scale, drawing, end
                    if event == cv2.EVENT_LBUTTONDOWN:
                        drawing = True
                        sx0, sy0 = x, y
                    elif event == cv2.EVENT_MOUSEMOVE:
                        if drawing:
                            if abs(x-sx0) > abs(y-sy0):
                                cv2.rectangle(img_copy, (sx0, sy0), (sx0+y-sy0, y), (0, 0, 255), thickness = 1)
                            else:
                                cv2.rectangle(img_copy, (sx0, sy0), (x, sy0+x-sx0), (0, 0, 255), thickness = 1)
                    elif event == cv2.EVENT_LBUTTONUP:
                        if abs(x-sx0) > abs(y-sy0):
                            sx1 = sx0+y-sy0
                            sy1 = y
                        else:
                            sx1 = x
                            sy1 = sy0+x-sx0
                        cv2.rectangle(img_copy, (sx0, sy0), (sx1, sy1), (0, 0, 255), thickness = 1)
                        drawing = False
                    elif event == cv2.EVENT_RBUTTONDOWN:
                        x0 = sx0
                        y0 = sy0
                        x1 = sx1
                        y1 = sy1
                        end = 1
                    press('enter')

            
            img_copy = img2.copy()
            img_output = img2.copy
            end = 0
            drawing = False
            while True:
                cv2.imshow('window', img_copy)
                if drawing:
                    img_copy = img2.copy()
                cv2.putText(img_copy, 'Trim. L DOWN -> L UP. R click to finish', (100, 100), cv2.FONT_HERSHEY_PLAIN, 3,
                            (0, 0, 255),
                            2, cv2.LINE_AA)
                cv2.setMouseCallback('window', trim_click)
                k = cv2.waitKey(0)
                if end == 1:
                    break
                if k == 27:
                    break
            cv2.destroyAllWindows()
            if k == 27:
                break


            x0 = int(x0 / scale)
            x1 = int(x1 / scale)
            y0 = int(y0 / scale)
            y1 = int(y1 / scale)
            if x0 > x1:
                x0, x1 = x1, x0
            if y0 > y1:
                y0, y1 = y1, y0

            if x0 < 0:
                x0 = 0
            if y0 < 0:
                y0 = 0
            if x1 > width:
                x1 = int(width)
            if y1 > height:
                y1 = int(height)

            print(x0, x1, y0, y1)


        ## Video writer
        video = cv2.VideoCapture(v)
        fourcc = cv2.VideoWriter_fourcc('m', 'p', '4', 'v')
        v2 = v.replace('.mp4', '_trim.mp4')
        writer = cv2.VideoWriter(v2.replace(idir, odir), fourcc, output_FPS, (fwidth, fwidth))
        frame_interval = int(fps/output_FPS)
        video.set(cv2.CAP_PROP_POS_FRAMES, start_frame)
        for i in tqdm.tqdm(range(start_frame, end_frame)):
            ret, frame = video.read()
            if ret:
                if i % frame_interval == 0:
                    frame_trim = frame[y0:y1, x0:x1]
                    frame_trim = cv2.resize(frame_trim, (fwidth, fwidth))
                    writer.write(frame_trim)
        writer.release()


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
     [sg.Text("Crop"),
     sg.Combo(['True', 'False'], default_value="True", size=(4, 1), key="-cropping")
     ],     
     [sg.Text("Frame width"),
     sg.In(key='-fwidth-')],
     [sg.Text("Video length (sec)"),
     sg.In(key='-vlength-')],
     [sg.Text("offset (sec)"),
     sg.In(key='-offset-')],
     [sg.Text("output FPS (def = 30)"),
     sg.In(key='-output_FPS-')]
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
    else:
        if event =="button_start":
            if len(values["-INFOLDERNAME-"]) == 0:
                print("no input!")
            elif len(values["-fwidth-"]) == 0:
                print("specify frame width")
            else:
                if event == 'button_start':
                    idir = values["-INFOLDERNAME-"]
                    if len(values["-OUTFOLDERNAME-"]) == 0:
                        odir = idir + "/cropped/"
                        if not os.path.exists(odir):
                            os.makedirs(odir)
                    else:
                        odir = values["-OUTFOLDERNAME-"]

                    if len(values["-scale-"]) == 0:
                        scale = 0.5
                    else:
                        scale = float(values["-scale-"])

                    fwidth = int(values["-fwidth-"])

                    if len(values["-offset-"]) == 0:
                        offset = 0
                    else:
                        offset = int(values["-offset-"])

                    if len(values["-vlength-"]) == 0:
                        vlength = -1
                    else:
                        vlength = int(values["-vlength-"])

                    if len(values['-output_FPS-']) == 0:
                        output_FPS = 30
                    else:
                        output_FPS = int(values['-output_FPS-'])
                    
                    shape = values["-shape"]    
                    cropping = values["-cropping"]    

                    message = ImageAnalysis(idir, odir, scale, cropping, shape, fwidth, vlength, offset, output_FPS)
                    sg.popup(message)            

window.close()