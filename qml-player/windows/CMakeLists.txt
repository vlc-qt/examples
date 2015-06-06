#
# VLC-Qt QML Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#
# Windows Extra

IF(MINGW OR MSVC)
    CONFIGURE_FILE(
        ${CMAKE_SOURCE_DIR}/windows/Project.rc.in
        ${CMAKE_BINARY_DIR}/windows/Project.rc
    )
ENDIF()

SET(Vlc_Plugins_Type
    3dnow
    access
    access_output
    audio_filter
    audio_mixer
    audio_output
    codec
    demux
    meta_engine
    misc
    mmx
    mmxext
    mux
    packetizer
    services_discovery
    sse2
    stream_filter
    stream_out
    text_renderer
    video_chroma
    video_filter
    video_output
)

MACRO(VLC_INSTALL_PLUGINS)
    FOREACH(type ${ARGN})
        FILE(GLOB Vlc_Plugins ${LIBVLCQT_BIN_DIR}/plugins/${type}/*.dll)
        INSTALL(FILES ${Vlc_Plugins} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}/plugins/${type}")
    ENDFOREACH(type)
ENDMACRO(VLC_INSTALL_PLUGINS)

STRING(REGEX REPLACE "\\\\" "/" LIBVLCQT_INCLUDE_DIR "${LIBVLCQT_INCLUDE_DIR}")

STRING(REGEX REPLACE "sdk/include" "" LIBVLCQT_BIN_DIR "${LIBVLCQT_INCLUDE_DIR}")
STRING(REGEX REPLACE "include" "bin" LIBVLCQT_BIN_DIR "${LIBVLCQT_BIN_DIR}")

STRING(REGEX REPLACE "bin" "plugins" QT_PLUGINS_DIR "${QT_BIN_DIR}")

SET(Qt5_Platforms
    ${QT_PLUGINS_DIR}/platforms/qminimal${LE}.dll
    ${QT_PLUGINS_DIR}/platforms/qwindows${LE}.dll
)

SET(Qt5_Libs
    ${QT_BIN_DIR}/Qt5Core${LE}.dll
    ${QT_BIN_DIR}/Qt5Gui${LE}.dll
)

FILE(GLOB Qt5_Libs_Icu ${QT_BIN_DIR}/icu*.dll)

SET(Qt5_Libs_Gles
    ${QT_BIN_DIR}/libEGL${LE}.dll
    ${QT_BIN_DIR}/libGLESv2${LE}.dll
)

FILE(GLOB Qt5_Libs_D3D ${QT_BIN_DIR}/D3DCompiler_*.dll)

SET(Qt5_Libs_Qml
    ${QT_BIN_DIR}/Qt5Network${LE}.dll
    ${QT_BIN_DIR}/Qt5Qml${LE}.dll
    ${QT_BIN_DIR}/Qt5Quick${LE}.dll
)

IF (MINGW)
    SET(VlcQt_Prefix "lib")
ENDIF()
SET(VlcQt_Libs
    ${LIBVLCQT_BIN_DIR}/${VlcQt_Prefix}vlc-qt-core.dll
    ${LIBVLCQT_BIN_DIR}/${VlcQt_Prefix}vlc-qt-qml.dll
)

SET(Vlc_Libs
    ${LIBVLCQT_BIN_DIR}/libvlc.dll
    ${LIBVLCQT_BIN_DIR}/libvlccore.dll
)

FILE(GLOB Vlc_Gcc "${LIBVLCQT_BIN_DIR}/libgcc_s_*-1.dll")
IF(Vlc_Gcc)
    SET(Extra_Libs
        ${Vlc_Gcc}
    )
ENDIF()

FILE(GLOB Vlc_Std "${LIBVLCQT_BIN_DIR}/libstdc++-6.dll")
IF(Vlc_Std)
    SET(Extra_Libs
        ${LIBVLCQT_BIN_DIR}/libstdc++-6.dll
        ${LIBVLCQT_BIN_DIR}/libwinpthread-1.dll
    )
ENDIF()

IF(MINGW)
    SET(Extra_Libs
        ${Extra_Libs}
        ${QT_BIN_DIR}/libgcc_s_${GCC_EH_METHOD}-1.dll
        ${QT_BIN_DIR}/libstdc++-6.dll
        ${QT_BIN_DIR}/libwinpthread-1.dll
    )
ENDIF()


################
# Installation #
################
INSTALL(FILES ${Qt5_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
INSTALL(FILES ${Qt5_Libs_Icu} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
INSTALL(FILES ${Qt5_Platforms} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}/platforms")
IF(WITH_ANGLE)
    INSTALL(FILES ${Qt5_Libs_Gles} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
    INSTALL(FILES ${Qt5_Libs_D3D} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
ENDIF()
INSTALL(FILES ${Qt5_Libs_Qml} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")

INSTALL(FILES ${VlcQt_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
INSTALL(FILES ${Vlc_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")

IF(MINGW OR Vlc_Gcc)
    INSTALL(FILES ${Extra_Libs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
ENDIF()

VLC_INSTALL_PLUGINS(${Vlc_Plugins_Type})
