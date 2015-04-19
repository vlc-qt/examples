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

LIBS       += -lvlc-qt -lvlc-qt-widgets


# Edit below for custom library location
#LIBS       += -L/Users/tadej/workspace/tanoprojects/install/vlc-qt/lib -lvlc-qt -lvlc-qt-widgets
#INCLUDEPATH += /Users/tadej/workspace/tanoprojects/install/vlc-qt/include

# Copy required dlls on windows with install target
#win32 {
#	CONFIG(debug, debug|release) {
#		LIBS += -L../../../../vlc-qt-build-debug/install/lib -llibvlc-qt -llibvlc-qt-widgets
#		INCLUDEPATH += ../../../../vlc-qt-build-debug/install/include
#		vlcQtDlls.path = $$OUT_PWD/debug
#		vlcQtDlls.files = ../../../../vlc-qt-build-debug/install/bin/libvlc*
#		vlcQtDlls.files += ../../../../vlc-qt-build-debug/install/bin/plugins
#	} else {
#		LIBS += -L../../../../vlc-qt-build/install/lib -llibvlc-qt -llibvlc-qt-widgets
#		INCLUDEPATH += ../../../../vlc-qt-build/install/include
#		vlcQtDlls.path = $$OUT_PWD/release
#		vlcQtDlls.files = ../../../../vlc-qt-build/install/bin/libvlc*
#		vlcQtDlls.files += ../../../../vlc-qt-build/install/bin/plugins
#	}
#	INSTALLS += vlcQtDlls
#}
