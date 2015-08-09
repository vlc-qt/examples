#
# VLC-Qt Simple Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#

SET(CMAKE_MACOSX_RPATH ON)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
SET(CMAKE_OSX_ARCHITECTURES x86_64)

IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    ADD_CUSTOM_TARGET(dmg
        "${QT_BIN_DIR}/macdeployqt" "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app" -dmg)
ENDIF()

CONFIGURE_FILE(
    ${CMAKE_SOURCE_DIR}/osx/Info.plist.in
    ${CMAKE_BINARY_DIR}/osx/Info.plist
)

# Installation
INSTALL(DIRECTORY ${VLCQtCoreFramework} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/Frameworks")
INSTALL(DIRECTORY ${VLCQtWidgetsFramework} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/Frameworks")
