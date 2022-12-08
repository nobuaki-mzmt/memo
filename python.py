#-----------------------------------------------------------------#
# Basic
#-----------------------------------------------------------------#
for i in name1:
	if skip == True:
		print("skip loop")
		continue
    if escape == True:
		print("escape loop")
		break
    do

if 1 == 2:
        do
    elif 1==3:
        do
    else:
        do
#-----------------------------------------------------------------#

#-----------------------------------------------------------------#
# String treating
#-----------------------------------------------------------------#
## split string
name = "abc_efg"
id   = name.split('_')

## 0 padding
obs_day = 1
str(obs_day).zfill(2)
# 01
#-----------------------------------------------------------------#

#-----------------------------------------------------------------#
# Date treating
#-----------------------------------------------------------------#
## convert string to date
date = 201026
datetime.datetime.strptime(str(date), '%Y%m%d')

## date adding
date + datetime.timedelta(days=1)
#-----------------------------------------------------------------#


#-----------------------------------------------------------------#
# Image analysis
#-----------------------------------------------------------------#

#-----------------------------------------------------------------#
# Open cv
#-----------------------------------------------------------------#
## read image
img = cv2.imread("image/image_in.jpg")

## save image
cv2.imwrite(path + "image/image_out.jpg", img1)

## get height / width / channel
h, w, c = img.shape

## left rotate
img = cv2.rotate(img, cv2.ROTATE_90_COUNTERCLOCKWISE)

## cropping
img1 = img[y1: y2, x1 : x2]

## show image
# cv show image does not work with jupyter notebook
# use matplotlib instead
from matplotlib import pyplot as plt
img1 = cv2.cvtColor(img1, cv2.COLOR_BGR2RGB)
plt.imshow(img1)
#-----------------------------------------------------------------#

