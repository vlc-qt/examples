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
INCLUDE_DIRECTORIES(${LIBVLCQT_INCLUDE_DIR})
INCLUDE_DIRECTORIES(
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_BINARY_DIR}/src
)

# This line tells cmake to create the Project program.
ADD_EXECUTABLE(${PROJECT_NAME} MACOSX_BUNDLE WIN32 ${Project_UIC_Srcs} ${Project_Srcs})

# Here the needed Qt Libraries are added to the link command.
TARGET_LINK_LIBRARIES(${PROJECT_NAME} Qt5::Widgets ${LIBVLCQT_WIDGETS_LIBRARY} ${LIBVLCQT_LIBRARY})


#
# Installation
#
INSTALL(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    BUNDLE DESTINATION .
)
