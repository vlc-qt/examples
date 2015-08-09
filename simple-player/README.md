# VLC-Qt Simple Player Example

A simple VLC-Qt powered media player with support for:
  - Video playback
  - Volume slider
  - Progress bar
  - Equalizer

This example is compatible with:
  - CMake and qmake
  - Qt5
  - latest VLC-Qt with VLC 2.2 or later

## TODO
  - qmake install

## Build system selection
If you want to use CMake, you can delete
  - simple-player.pro
  - src/src.pro

If you want to use qmake, you can delete
  - CMakeLists.txt
  - cmake/*
  - src/CMakeLists.txt


## Platform specific notes

### Windows

You can install all required libraries with (CMake only)
```
make install
make windows
```

### OS X

Create package using (CMake only)
```
make install
make dmg
```