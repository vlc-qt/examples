/*
* VLC-Qt QML Player
* Copyright (C) 2015 Tadej Novak <tadej@tano.si>
*/

import QtQuick 2.0
import VLCQt 0.11

Rectangle {
    width: 640
    height: 480
    color: "black"

    VlcVideoPlayer {
        id: vidwidget
        anchors.fill: parent
        url: "http://videos.hd-trailers.net/e23ab4b8-a737-46dd-a0e4-259ba36056b6_YsfXbEghC5XywlmkKiYrF0D1oWcPYHA94aPeKmTuUKJJVJBpH4AFbPzcNWMhAJHuRnKZAAatvKg-_8_0.mp4"
    }
}
