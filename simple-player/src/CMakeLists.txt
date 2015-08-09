#
# VLC-Qt Simple Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#
# List of sources
#
# Define the UI source files
SET(Project_UIs
    EqualizerDialog.ui
    SimplePlayer.ui
)

# Define the C++ source files
SET(Project_Srcs
    main.cpp
    EqualizerDialog.cpp
    SimplePlayer.cpp
)


#
# Compiler settings
#
# This needs to be added in order for #include to work inside .cpp files
INCLUDE_DIRECTORIES(
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_BINARY_DIR}/src
)

# Compile resources with windres
IF(MINGW)
    ADD_CUSTOM_COMMAND(
        OUTPUT ${CMAKE_BINARY_DIR}/windows/Project.obj
        COMMAND ${CMAKE_RC_COMPILER}
        -i ${CMAKE_BINARY_DIR}/windows/Project.rc
        -o ${CMAKE_BINARY_DIR}/windows/Project.obj
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/windows"
    )
    SET(Project_Srcs ${Project_Srcs} ${CMAKE_BINARY_DIR}/windows/Project.obj)
ENDIF()

IF(MSVC)
    SET(Project_Srcs ${Project_Srcs} ${CMAKE_BINARY_DIR}/windows/Project.rc)
ENDIF()

# Build iconset on OS X
IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    SET(Project_Iconset ${CMAKE_SOURCE_DIR}/osx/Project.iconset)

    FILE(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/src/${PROJECT_NAME}.app/Contents/Resources)
    FIND_PROGRAM(ICONUTIL_EXECUTABLE NAMES iconutil)
    ADD_CUSTOM_COMMAND(
        OUTPUT ${CMAKE_BINARY_DIR}/src/${PROJECT_NAME}.app/Contents/Resources/${PROJECT_NAME}.icns
        COMMAND ${ICONUTIL_EXECUTABLE} --convert icns --output ${CMAKE_BINARY_DIR}/src/${PROJECT_NAME}.app/Contents/Resources/${PROJECT_NAME}.icns
        ${Project_Iconset}
    )
    SET(Project_Srcs ${Project_Srcs} ${CMAKE_BINARY_DIR}/src/${PROJECT_NAME}.app/Contents/Resources/${PROJECT_NAME}.icns)
ENDIF()

# This line tells cmake to create the Project program.
ADD_EXECUTABLE(${PROJECT_NAME} MACOSX_BUNDLE WIN32 ${Project_UIs} ${Project_Srcs})

# Use custom Info.plist
IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES INSTALL_RPATH "${QT_LIB_DIR};@executable_path/../Frameworks")
    SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_INFO_PLIST "${CMAKE_BINARY_DIR}/osx/Info.plist")
ENDIF()

# Here the needed Qt Libraries are added to the link command.
TARGET_LINK_LIBRARIES(${PROJECT_NAME} Qt5::Widgets VLCQt::Widgets)


#
# Installation
#
INSTALL(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${PROJECT_INSTALL_BIN_DIR}
    BUNDLE DESTINATION .
)
