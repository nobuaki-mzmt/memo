rem ------------ cmd samples ------------

rem -- file list
dir
dir *.MP4
rem -- including subjective directories
dir /s
dir *-05.jpg /s


rem ------------- ffmpeg -----------------
rem It seems that ffmpeg can't accept *avi or *MP4 in "-i"

rem ---- basic syntax ----
ffmpeg -i input.mp4 -c:v libx264 -s 1920x1080 -b:v 1000k output.mp4
rem 1. 	options for -c:v
rem 		libx264: CPU
rem  		h264_nvenc: using GPU
rem 2. 	-b:v 
rem 		bit rate (specify if you want to reduce the file size)

rem ---- trimming ----
ffmpeg -ss 20 -i input.mp4 -t3600 output.mp4

rem ---- multiple files ----
for f in *.MP4; do ffmpeg -ss 20 -i "$f" -t 3600 -c:v h264_nvenc -b:v 1000k -s 1920x1080 %%i-small.mp4; done

rem ---- speed change ----
ffmpeg -i input.mp4 -vf setpts=PTS/3.0 -af atempo=2.0 outputx2.mp4
ffmpeg -i input.mp4 -vf setpts=PTS/3.0 -af atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0,atempo=2.0 -vcodec libx264 -threads 4 outputx128.mp4

rem ---- snapshots ----
ffmpeg -ss 0 -i CF_MM1.MTS -frames:v 1 -q:v 1 CF_MM1.jpg
rem 1.	-ss 0
rem 		position to take snapshot
rem 2.	-frames:v 1
rem 		take one snapshot
rem 3.	-q:v 1
rem 		quality range of the image. range 1-31. 1 is the best.


rem ---- connect videos ----
ffmpeg -safe 0 -f concat -i connect.txt -c:v libx264 -b:v 400k -threads 4 -s 1280x720 test2.mp4
rem connect.txt include file lists that you want to connect







rem ------ Imagemagiks -----
rem -- Šg’£Žq‚Ì•ÏŠ·
convert *.emf res_Levy_%03d.png

rem -- —]”’‚ÌƒgƒŠƒ~ƒ“ƒO
convert *.png -trim +repage trim_%03d.png
rem -- or
mogrify -trim +repage *.png

rem -- gifì¬ (delay1.5‚ªÅ‘¬H)
convert -delay 1.5 -loop 1 *.png movie.gif
convert -delay 1.5 -loop 0 bin*.png bin_movie.gif
convert -delay 30 -loop 0 *.jpg movie.gif
rem -- -loop: loop‚·‚é‰ñ”, 0‚¾‚Æ–³ŒÀ

convert -delay 4 -loop 1 *.png movie.gif
convert -delay 1.5 -loop 0 *.png movie2.gif

rem -- ‰ñ“]
mogrify -rotate 90 *.png

rem -- ‰æ‘œ‚ÌŒ‹‡
montage *.jpg -tile 6x5 -geometry 2048x1536  Hetero-B-1-all.jpg
montage *.jpg -tile 6x5 -geometry 1024x768  Hetero-B-1-all.jpg
montage *.jpg -tile 6x5 -geometry 1024 Hetero-B-1-all.jpg
montage *.jpg -tile 5x5 -geometry 1024 Hetero-B-1-all.jpg

