:: ------------ cmd samples ------------

:: -- file list
dir
dir *.MP4
:: -- including subjective directories
dir /s
dir *-05.jpg /s

::  -- ZMQError during SLEAP
:: check the process id that uses the port 9001
netstat -ano | findstr :9001
:: find the name of the process with pid
tasklist /fi "pid eq 11628"
:: kill the process with the pid
taskkill /pid 11628

:: ------------- ffmpeg -----------------
:: It seems that ffmpeg can't accept *avi or *MP4 in "-i"

:: ---- basic syntax ----
ffmpeg -i input.mp4 -c:v libx264 -s 1920x1080 -b:v 1000k output.mp4
:: 1. 	options for -c:v
:: 		libx264: CPU
::  		h264_nvenc: using GPU
:: 2. 	-b:v 
:: 		bit rate (specify if you want to reduce the file size)

:: ---- trimming ----
ffmpeg -ss 20 -i input.mp4 -t3600 output.mp4

:: ---- multiple files ----
:: Mac
for f in *.MP4; do ffmpeg -ss 20 -i "$f" -t 3600 -c:v h264_nvenc -b:v 1000k -s 1920x1080 %%i-small.mp4; done
:: Windows
for /r %f in (*.mp4) do ffmpeg -ss 20 -i "$f" -t 3600 -c:v h264_nvenc -b:v 1000k -s 1920x1080 %%i-small.mp4
for /r %f in (*.wmv) do ffmpeg -i "%~f" -c:v h264_nvenc "%~nf.mp4"
:: When running a for loop directly in cmd, need to use % instead of %% as the loop variable.
:: This is because the %% symbol is used to escape variables in batch files, but is not necessary when running a loop directly in cmd.

for %i in (*.mp4) do ffmpeg -i "%i" -c:v h264_nvenc -b:v 1M -crf 23 -c:a copy "%~ni_UMA.mp4"

:: ---- speed change ----
ffmpeg -i input.mp4 -vf setpts=PTS/3.0 -af atempo=2.0 outputx2.mp4
ffmpeg -i input.mp4 -vf setpts=PTS/3.0 -af atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0 -vcodec libx264 -threads 4 outputx128.mp4

:: ---- snapshots ----
ffmpeg -ss 0 -i CF_MM1.MTS -frames:v 1 -q:v 1 CF_MM1.jpg
:: 1.	-ss 0
:: 		position to take snapshot
:: 2.	-frames:v 1
:: 		take one snapshot
:: 3.	-q:v 1
:: 		quality range of the image. range 1-31. 1 is the best.

:: ---- connect videos ----
ffmpeg -safe 0 -f concat -i connect.txt -c:v libx264 -b:v 400k -threads 4 -s 1280x720 test2.mp4
:: connect.txt include file lists that you want to connect

:: ---- create gif from movie ----
ffmpeg -i input.mp4 -vf scale=320:-1 -r 10 output.gif


:: ----------------- Imagemagiks -----------------
:: -- check if installed
where magick

:: -- create gif animation
magick convert -delay 10 -loop 0 *.jpg movie.gif
:: -delay 10:  time interval (1/100 sec)


:: -- Šg’£Žq‚Ì•ÏŠ·
convert *.emf res_Levy_%03d.png

:: -- —]”’‚ÌƒgƒŠƒ~ƒ“ƒO
convert *.png -trim +repage trim_%03d.png
:: -- or
mogrify -trim +repage *.png

convert -delay 4 -loop 1 *.png movie.gif
convert -delay 1.5 -loop 0 *.png movie2.gif

:: -- ‰ñ“]
mogrify -rotate 90 *.png

:: -- ‰æ‘œ‚ÌŒ‹‡
montage *.jpg -tile 6x5 -geometry 2048x1536  Hetero-B-1-all.jpg
montage *.jpg -tile 6x5 -geometry 1024x768  Hetero-B-1-all.jpg
montage *.jpg -tile 6x5 -geometry 1024 Hetero-B-1-all.jpg
montage *.jpg -tile 5x5 -geometry 1024 Hetero-B-1-all.jpg

