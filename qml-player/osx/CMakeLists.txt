#
# VLC-Qt QML Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#

IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    ADD_CUSTOM_TARGET(dmg
        "${QT_BIN_DIR}/macdeployqt" "${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app" -qmldir="${CMAKE_SOURCE_DIR}/src/qml" -dmg)
ENDIF()

STRING(REGEX REPLACE "include" "" LIBVLCQT_DIR "${LIBVLCQT_INCLUDE_DIR}")
STRING(REGEX REPLACE "include" "lib" LIBVLCQT_LIB_DIR "${LIBVLCQT_INCLUDE_DIR}")

CONFIGURE_FILE(
    ${CMAKE_SOURCE_DIR}/osx/Info.plist.in
    ${CMAKE_BINARY_DIR}/osx/Info.plist
)

FILE(GLOB VlcQt_Core_Libs ${LIBVLCQT_LIB_DIR}/libvlc-qt-core.*)
FILE(GLOB VlcQt_Qml_Libs ${LIBVLCQT_LIB_DIR}/libvlc-qt-qml.*)

SET(VlcQt_Libs
    ${VlcQt_Core_Libs}
    ${VlcQt_Qml_Libs}
)

FILE(GLOB Vlc_Libs ${LIBVLCQT_LIB_DIR}/libvlc.*)
FILE(GLOB VlcCore_Libs ${LIBVLCQT_LIB_DIR}/libvlccore.*)

FILE(GLOB Vlc_Plugins ${LIBVLCQT_DIR}/plugins/*.dylib)


# Installation
INSTALL(FILES ${VlcQt_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_LIB_DIR}")
INSTALL(FILES ${Vlc_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_LIB_DIR}")
INSTALL(FILES ${VlcCore_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_LIB_DIR}")
INSTALL(FILES ${Vlc_Plugins} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}/plugins")
