"""
Program to convert h5 to csv
"""

# ----- packages ---------------------------------------------#
import glob
import h5py
import numpy as np
from numpy.linalg import norm
from scipy.interpolate import interp1d
import pandas as pd
import PySimpleGUI as sg
import os
import re
# ------------------------------------------------------------#

# ------------------------------------------------------------#
def fill_missing(Y, kind="linear"):
        initial_shape = Y.shape
        Y = Y.reshape((initial_shape[0], -1))
        # Interpolate along each slice.
        for i in range(Y.shape[-1]):
            y = Y[:, i]
            # Build interpolant.
            x = np.flatnonzero(~np.isnan(y))
            f = interp1d(x, y[x], kind=kind, fill_value=np.nan, bounds_error=False)
            # Fill missing
            xq = np.flatnonzero(np.isnan(y))
            y[xq] = f(xq)
            # Fill leading or trailing NaNs with the nearest non-NaN values
            mask = np.isnan(y)
            y[mask] = np.interp(np.flatnonzero(mask), np.flatnonzero(~mask), y[~mask])
            Y[:, i] = y
            if sum(np.isnan(y)) > 0:
                print("error"+str(i))
                print("error"+(i))
        # Restore to initial shape.
        Y = Y.reshape(initial_shape)
        return Y

def convertH5CSV(in_dir, out_dir, ind_name):
    coord_name = ["x", "y"]
    files = glob.glob(in_dir + "/*.h5")

    for f_name in files:
        with h5py.File(f_name, "r") as f:
            dset_names = list(f.keys())
            locations = f["tracks"][:].T
            node_names = [n.decode() for n in f["node_names"][:]]
        
        print(f_name)
        f_base_name = os.path.basename(f_name)
        locations = fill_missing(locations)
        print("number of individuals: " + str(locations.shape[3]))

        
        for i_ind in range(locations.shape[3]):
            label_name = []
            coordinates = []
            for i_body in range(locations.shape[1]): 
            #    if re.search(r'(head|abd|prono)', node_names[i_body]):
                for i_coord in range(locations.shape[2]):
                    label = node_names[i_body] + "_" + coord_name[i_coord]
                    loc_ndar = locations[:, i_body, i_coord, i_ind]
                    loc_list = loc_ndar.tolist()
                    coordinates.append(loc_list)
                    label_name.append(label)

            df = pd.DataFrame(coordinates)
            df = df.T
            df = df.set_axis(label_name, axis='columns')
            out_name = out_dir + os.sep + f_base_name.replace(".h5", "_" + ind_name[i_ind] + ".csv")
            df.to_csv(out_name)
    return("Done")

# ---------------------------------------------------------------------------------------------
sg.theme('Dark')
frame1 = sg.Frame('', [
    [sg.Text("In"),
     sg.InputText('Input folder', key='-INPUTTEXT-', enable_events=True),
     sg.FolderBrowse(button_text='select', size=(8, 1), key="-INFOLDERNAME-")
     ],
    [sg.Text("Out"),
     sg.InputText('Output folder', key='-INPUTTEXT-', enable_events=True),
     sg.FolderBrowse(button_text='select', size=(8, 1), key="-OUTFOLDERNAME-"),
     sg.Text("*generated if not specified")
     ],
    [sg.Text("Assing individual name"),
     sg.InputText('f1, m1', key='-INDNAME-', enable_events=True),
     sg.Text("*default: f1, m1")
     ]
], size=(650, 120))

frame2 = sg.Frame('', [
    [sg.Submit(button_text='Start', size=(10, 3), key='button_start')]], 
    size=(100, 80))

layout = [[frame1, frame2]]

window = sg.Window('convert h5 to csv', layout, resizable=True)


while True:
    event, values = window.read()

    if event is None:
        print('exit')
        break
    else:
        if event == 'button_start':
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

                    if len(values["-INDNAME-"]) == 0:
                        ind_name = ['f1', 'm1']
                    else:
                        s = values["-INDNAME-"]
                        l = [x.strip() for x in s.split(',')]
                        ind_name = [str(s) for s in l]

                    message = convertH5CSV(idir, odir, ind_name)
                    sg.popup(message)
window.close()



