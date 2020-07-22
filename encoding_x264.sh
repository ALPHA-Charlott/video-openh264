#!/bin/bash
#HLS, Dash and fallback code from zazu.berlin 2020, Version 20200424


ffcmd=$HOME'/ffmpeg_debug/macro_with_gpl/bin/'ffmpeg
VIDEO_IN=./source/Sintel.mp4
title="${VIDEO_IN%.*}"
echo $title

VIDEO_OUT=${title}_master
HLS_TIME=4
FPS=25
GOP_SIZE=100
PRESET_P=fast
V_SIZE_1=960x540
V_SIZE_2=416x234
V_SIZE_3=640x360
V_SIZE_4=768x432
V_SIZE_5=1280x720
V_SIZE_6=1920x1080

# HLS
 # -c:a aac -b:a 128k -ac 1 -ar 44100\
${ffcmd} -hide_banner -threads 8 -i $VIDEO_IN -y \
    -preset $PRESET_P -keyint_min $GOP_SIZE -g $GOP_SIZE -sc_threshold 0 -r $FPS -c:v libx264 -pix_fmt yuv420p \
    -map v:0 -s:0 $V_SIZE_1 -b:v:0 2M -maxrate:0 2.14M -bufsize:0 4.28M \
    -map v:0 -s:1 $V_SIZE_2 -b:v:1 145k -maxrate:1 155k -bufsize:1 310k \
    -map v:0 -s:2 $V_SIZE_3 -b:v:2 365k -maxrate:2 390k -bufsize:2 780k \
    -map v:0 -s:3 $V_SIZE_4 -b:v:3 730k -maxrate:3 781k -bufsize:3 1278k \
    -map v:0 -s:4 $V_SIZE_4 -b:v:4 1.1M -maxrate:4 1.17M -bufsize:4 2M \
    -map v:0 -s:5 $V_SIZE_5 -b:v:5 3M -maxrate:5 3.21M -bufsize:5 5.5M \
    -map v:0 -s:6 $V_SIZE_5 -b:v:6 4.5M -maxrate:6 4.8M -bufsize:6 9.6M \
    -map v:0 -s:7 $V_SIZE_6 -b:v:7 6M -maxrate:7 6.42M -bufsize:7 11M \
    -map v:0 -s:8 $V_SIZE_6 -b:v:8 7.8M -maxrate:8 8.3M -bufsize:8 16.6M \
    -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 \
    -c:a libfdk_aac -ac 2 -b:a 128k -r:a 44100 \
    -f hls -hls_time $HLS_TIME -hls_playlist_type vod -hls_flags independent_segments \
    -master_pl_name $VIDEO_OUT.m3u8 \
    -hls_segment_filename HLS/stream_%v/s%06d.ts \
    -strftime_mkdir 1 \
    -var_stream_map "v:0,a:0 v:1,a:1 v:2,a:2 v:3,a:3 v:4,a:4 v:5,a:5 v:6,a:6 v:7,a:7 v:8,a:8" HLS/stream_%v.m3u8
