## Convert image to movie

#-- 1. movie ----------------#
import cv2
import glob

in_dir = r""
file_extension = "jpg"
names = glob.glob(in_dir+r'\*.' + file_extension)
output = "output.mp4"
fps = 10
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
width = 1000
height = 562
frames = cv2.VideoWriter(output, fourcc, fps, (width,height))

for i in range(len(names)):
    img_read = cv2.imread(names[i])
    # All images need to be the same size
    img_read = cv2.resize(img_read, dsize=(width, height)) 
    frames.write(img_read)

frames.release()
#----------------------------#


#-- 2. gif ------------------#
import cv2
import os
import glob
from PIL import Image

in_dir = r""
file_extension = "jpg"
names = glob.glob(in_dir+r'\*.' + file_extension)
output = "output.gif"

imgs = []
for i in range(len(names)):
    img_read = cv2.imread(names[i])
    img_read = cv2.resize(img_read, dsize=(round(img_read.shape[0]/2), round(img_read.shape[1]/2))) # if you want to resize
    # convert opencv -> PIL to use .save function
    pil_image = img_read.copy()
    pil_image = cv2.cvtColor(pil_image, cv2.COLOR_BGR2RGB)
    pil_image = Image.fromarray(pil_image)
    imgs.append(pil_image)

imgs[0].save(output, save_all=True, append_images=imgs[1:], optimize=False, duration=10, loop=0)
#----------------------------#