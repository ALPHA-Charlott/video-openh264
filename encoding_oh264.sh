#!/bin/bash
#HLS, Dash and fallback code from zazu.berlin 2020, Version 20200424

ffcmd=$HOME'/ffmpeg_debug/cmpl_openh264/bin/'ffmpeg
VIDEO_IN=source/$1
filename=${VIDEO_IN##*/}
title="${filename%.*}"

if [[ -e $VIDEO_IN ]]; then
    echo $title ' ------>'
else
    exit;
fi


VIDEO_OUT=${title}_264_master
HLS_TIME=4
FPS=25
GOP_SIZE=90

V_SIZE_1=256x144
V_SIZE_2=426x240
V_SIZE_3=640x360
V_SIZE_4=854x480
V_SIZE_5=1280x720
V_SIZE_6=1920x1080

# HLS
 # -c:a aac -b:a 128k -ac 1 -ar 44100\

mkdir -p ${title}_HLS_264


${ffcmd} -hide_banner -y -i $VIDEO_IN \
    -keyint_min $GOP_SIZE -g $GOP_SIZE -sc_threshold 0 -r $FPS -c:v h264 -pix_fmt yuv420p \
    -rc_mode off -vbsf h264_mp4toannexb  -coder 1 -loopfilter 1 \
    -map v:0 -s:0 $V_SIZE_1 -b:v:0 144k -maxrate:0 180k -bufsize:0 320k \
    -profile:v constrained_baseline -level 12 -coder 0 \
    -map v:0 -s:1 $V_SIZE_2 -b:v:1 180k -maxrate:1 210k -bufsize:1 360k \
    -profile:v constrained_baseline -level 22 -coder 0  \
    -map v:0 -s:2 $V_SIZE_3 -b:v:2 735k -maxrate:2 780k -bufsize:2 1M \
    -profile:v high -level 30 \
    -map v:0 -s:3 $V_SIZE_4 -b:v:3 900k -maxrate:3 1.1M -bufsize:3 1.5M  \
    -profile:v high -level 40 \
    -map v:0 -s:4 $V_SIZE_5 -b:v:4 5.2M -r:v:0 50 -maxrate:4 7.8M -bufsize:4 10.8M \
    -profile:v high -level 52  \
    -map v:0 -s:5 $V_SIZE_6 -b:v:5 8.5M -r:v:0 50 -maxrate:5 11.2M -bufsize:5 15.6M \
    -profile:v high -level 52 \
    -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 \
    -c:a aac -ac 2 -b:a 128k -r:a 44100 \
    -f hls -hls_time $HLS_TIME -hls_playlist_type vod -hls_flags independent_segments \
    -master_pl_name $VIDEO_OUT.m3u8 \
    -hls_segment_filename ${title}_HLS_264/${title}_stream_%v/s%06d.ts \
    -strftime_mkdir 1 \
    -var_stream_map "v:0,a:0 v:1,a:1 v:2,a:2 v:3,a:3 v:4,a:4 v:5,a:5" ${title}_264_stream_%v.m3u8
