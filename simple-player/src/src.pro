#
# VLC-Qt Simple Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#

TARGET      = simple-player
TEMPLATE    = app
CONFIG 	   += c++11

QT         += widgets

SOURCES    += main.cpp \
    SimplePlayer.cpp \
    EqualizerDialog.cpp

HEADERS    += SimplePlayer.h \
    EqualizerDialog.h

FORMS      += SimplePlayer.ui \
    EqualizerDialog.ui

LIBS       += -lVLCQtCore -lVLCQtWidgets


# Edit below for custom library location
LIBS       += -L/Users/tadej/workspace/tanoprojects/install/vlc-qt/lib -lVLCQtCore -lVLCQtWidgets
INCLUDEPATH += /Users/tadej/workspace/tanoprojects/install/vlc-qt/include
