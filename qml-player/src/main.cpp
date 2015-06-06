/*
* VLC-Qt QML Player
* Copyright (C) 2015 Tadej Novak <tadej@tano.si>
*/

#include <QtCore/QCoreApplication>
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>

#include <vlc-qt/Common.h>
#include <vlc-qt/QmlVideoPlayer.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName("VLC-Qt QML Player");
    QCoreApplication::setAttribute(Qt::AA_X11InitThreads);

    QGuiApplication app(argc, argv);
    VlcCommon::setPluginPath(app.applicationDirPath() + "/plugins");
    VlcQmlVideoPlayer::registerPlugin();

    QQuickView quickView;
    quickView.setSource(QUrl(QStringLiteral("qrc:/qml/video.qml")));
    quickView.setResizeMode(QQuickView::SizeRootObjectToView);
    quickView.show();

    return app.exec();
}
