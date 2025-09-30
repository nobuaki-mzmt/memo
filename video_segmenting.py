
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
def ImageAnalysis(idir, odir, scale, cropping, shape, fwidth, v_len, offset, output_FPS, segment_interval):

    path = glob.glob(idir + os.sep + "*.mp4")
    filenums = list(range((len(path))))
    frame_number = 0

    for i in filenums:
        v = path[i]
        video = cv2.VideoCapture(v)
        
        width = video.get(cv2.CAP_PROP_FRAME_WIDTH)
        height = video.get(cv2.CAP_PROP_FRAME_HEIGHT)

        fps = video.get(cv2.CAP_PROP_FPS)
        fps = int(fps)
        if (fps == 29) or (fps == 30):
            fps = 30
        elif (fps == 59) or (fps == 60):
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

        ## Video writer
        video = cv2.VideoCapture(v)
        fourcc = cv2.VideoWriter_fourcc('m', 'p', '4', 'v')
        segment_num = 0
        v2 = v.replace('.mp4', ('_' + f'{segment_num:02}' + '.mp4'))
        print(v2)

        frame_interval = int(fps/output_FPS)
        video.set(cv2.CAP_PROP_POS_FRAMES, start_frame)

        if (frame_number == 0):
            writer = cv2.VideoWriter(v2.replace(idir, odir), fourcc, output_FPS, (int(width), int(height)))
            output_filename = v2.replace(idir, odir)
            ret, frame = video.read()
            cv2.imwrite(output_filename.replace("mp4", "jpg"), frame)

        for i in tqdm.tqdm(range(start_frame, end_frame)):
            ret, frame = video.read()
            frame_number += 1
            if ret:
                if frame_number % frame_interval == 0:
                    frame_out = cv2.putText(frame, str(frame_number), (50,100), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
                    writer.write(frame_out)
                    if frame_number % segment_interval == 0:
                        writer.release()
                        segment_num = segment_num + 1
                        v2 = v.replace('.mp4', '_' + f'{segment_num:02}' + '.mp4')
                        print(v2)
                        writer = cv2.VideoWriter(v2.replace(idir, odir), fourcc, output_FPS, (int(width), int(height)))
                        output_filename = v2.replace(idir, odir)
                        cv2.imwrite(output_filename.replace("mp4", "jpg"), frame)
    writer.release()
    return("Done")


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
     sg.Combo(['circle'], default_value="circle", size=(4, 1), key="-shape")
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
     sg.In(key='-output_FPS-')],
     [sg.Text("segment interval (in frame)"),
     sg.In(key='-segment_interval-')]
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
            else:
                if event == 'button_start':
                    idir = values["-INFOLDERNAME-"]
                    if len(values["-OUTFOLDERNAME-"]) == 0:
                        odir = idir + "/segmented/"
                        if not os.path.exists(odir):
                            os.makedirs(odir)
                    else:
                        odir = values["-OUTFOLDERNAME-"]

                    if len(values["-scale-"]) == 0:
                        scale = 0.5
                    else:
                        scale = float(values["-scale-"])

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
                    
                    if len(values['-segment_interval-']) == 0:
                        segment_interval = 1800
                    else:
                        segment_interval = int(values['-segment_interval-'])

                    shape = values["-shape"]    
                    cropping = values["-cropping"]    

                    message = ImageAnalysis(idir, odir, scale, cropping, shape, 0, vlength, offset, output_FPS, segment_interval)
                    sg.popup(message)            

window.close()