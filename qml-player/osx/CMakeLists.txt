#
# VLC-Qt QML Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#

IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    ADD_CUSTOM_TARGET(dmg
        "${QT_BIN_DIR}/macdeployqt" "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app" -qmldir="${CMAKE_SOURCE_DIR}/src/qml" -dmg
        WORKING_DIRECTORY ${QT_BIN_DIR})
ENDIF()

CONFIGURE_FILE(
    ${CMAKE_SOURCE_DIR}/osx/Info.plist.in
    ${CMAKE_BINARY_DIR}/osx/Info.plist
)

# Installation
INSTALL(DIRECTORY ${VLCQtCoreFramework} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/Frameworks")
INSTALL(DIRECTORY ${VLCQtQmlFramework} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/Frameworks")
