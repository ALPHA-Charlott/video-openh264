
Target version: (marked as h264)
```
ffmpeg -version|head -n3
ffmpeg version N-98469-g93febc4e15 Copyright (c) 2000-2020 the FFmpeg developers
built with Apple clang version 11.0.3 (clang-1103.0.32.62)
configuration: 
--prefix=/Users/charlottalph/ffmpeg_debug/cmpl_openh264 --disable-doc --pkg-config-flags=--static i
--extra-cflags=-I/Users/charlottalph/Src/ffmpeg_build_macro/include 
--extra-ldflags=-L/Users/charlottalph/Src/ffmpeg_build_macro/lib 
--extra-cflags='-fPIC ' --extra-cxxflags='=-fPIC' --extra-libs=-lz --enable-pic 
--disable-gpl 
--disable-nonfree 
--disable-openssl 
--enable-libvpx 
--enable-libopenh264 
--enable-libopus
```

reference version: (marked as x264 or GPL version)
```
ffmpeg -version|head -n3
ffmpeg version 4.3 Copyright (c) 2000-2020 the FFmpeg developers
built with Apple clang version 11.0.3 (clang-1103.0.32.62)
configuration: 
--prefix=/Users/charlottalph/ffmpeg_debug/macro_with_gpl 
--pkg-config-flags=--static 
--extra-cflags=-I/Users/charlottalph/Src/ffmpeg_build_macro/include 
--extra-ldflags=-L/Users/charlottalph/Src/ffmpeg_build_macro/lib 
--extra-libs=-lpthread 
--extra-libs=-lm 
--bindir=/Users/charlottalph/bin/macro_with_gpl 
--enable-gpl 
--enable-libfdk_aac 
--enable-libx264 
--enable-nonfree
```

Builtin Parameters Helper
```
Encoder libopenh264 [OpenH264 H.264 / AVC / MPEG-4 AVC / MPEG-4 part 10]:
    General capabilities: threads
    Threading capabilities: auto
    Supported pixel formats: yuv420p
libopenh264enc AVOptions:
  -slice_mode        <int>        E..V...... set slice mode, use slices/max_nal_size (from 0 to 4) (default fixed)
     fixed           1            E..V...... a fixed number of slices
     dyn             3            E..V...... Size limited (compatibility name)
     sizelimited     3            E..V...... Size limited
  -loopfilter        <int>        E..V...... enable loop filter (from 0 to 1) (default 1)
  -profile           <int>        E..V...... set profile restrictions (from -99 to 65535) (default -99)
     constrained_baseline 578          E..V......
     main            77           E..V......
     high            100          E..V......
  -max_nal_size      <int>        E..V...... set maximum NAL size in bytes (from 0 to INT_MAX) (default 0)
  -allow_skip_frames <boolean>    E..V...... allow skipping frames to hit the target bitrate (default false)
  -cabac             <int>        E..V...... Enable cabac(deprecated, use coder) (from 0 to 1) (default 0)
  -coder             <int>        E..V...... Coder type (from -1 to 1) (default default)
     default         -1           E..V......
     cavlc           0            E..V......
     cabac           1            E..V......
     vlc             0            E..V......
     ac              1            E..V......
  -rc_mode           <int>        E..V...... Select rate control mode (from -1 to 3) (default quality)
     off             -1           E..V...... bit rate control off
     quality         0            E..V...... quality mode
     bitrate         1            E..V...... bitrate mode
     buffer          2            E..V...... using buffer status to adjust the video quality (no bitrate control)
     timestamp       3            E..V...... bit rate control based on timestamp

```
