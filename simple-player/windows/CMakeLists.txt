#
# VLC-Qt Simple Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#
# Windows Extra

IF(MINGW OR MSVC)
    CONFIGURE_FILE(
        ${CMAKE_SOURCE_DIR}/windows/Project.rc.in
        ${CMAKE_BINARY_DIR}/windows/Project.rc
    )
ENDIF()

IF(CMAKE_BUILD_TYPE MATCHES Debug)
    SET(VLCQtPostfix "d")
ENDIF()
IF(MINGW)
    SET(VLCQtPrefix "lib")
ENDIF()

SET(VLCQtLibs
    ${VLCQtCoreLocation}/bin/${VLCQtPrefix}VLCQtCore${VLCQtPostfix}.dll
    ${VLCQtWidgetsLocation}/bin/${VLCQtPrefix}VLCQtWidgets${VLCQtPostfix}.dll
    ${VLCQtCoreLocation}/bin/libvlc.dll
    ${VLCQtCoreLocation}/bin/libvlccore.dll
)

SET(VLCQtPlugins ${VLCQtCoreLocation}/bin/plugins)

FILE(GLOB VLCGcc "${VLCQtCoreLocation}/bin/libgcc_s_*-1.dll")
IF(VLCGcc)
    SET(ExtraLibs
        ${VLCGcc}
    )
ENDIF()

FILE(GLOB VLCStd "${VLCQtCoreLocation}/bin/libstdc++-6.dll")
IF(VLCStd)
    SET(ExtraLibs
        ${ExtraLibs}
        ${VLCQtCoreLocation}/bin/libstdc++-6.dll
        ${VLCQtCoreLocation}/bin/libwinpthread-1.dll
    )
ENDIF()

ADD_CUSTOM_TARGET(windows
    "${QT_BIN_DIR}/windeployqt.exe" "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}/${PROJECT_NAME}.exe")


################
# Installation #
################
INSTALL(FILES ${VLCQtLibs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
INSTALL(DIRECTORY ${VLCQtPlugins} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")

IF(VLCGcc OR VLCStd)
    INSTALL(FILES ${ExtraLibs} DESTINATION "${CMAKE_INSTALL_PREFIX}/${PROJECT_INSTALL_BIN_DIR}")
ENDIF()
