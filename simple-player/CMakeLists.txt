#
# VLC-Qt Simple Player
# Copyright (C) 2015 Tadej Novak <tadej@tano.si>
#

CMAKE_MINIMUM_REQUIRED(VERSION 3.0.2)
CMAKE_POLICY(VERSION 3.0.2)

PROJECT(simple-player VERSION 1.0.0)

CONFIGURE_FILE(
    "${CMAKE_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
    "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)

ADD_CUSTOM_TARGET(uninstall
    "${CMAKE_COMMAND}" -P "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake")

SET(CMAKE_MODULE_PATH
    ${CMAKE_SOURCE_DIR}/cmake
)

# Automatically run moc, uic and/or rcc, if required
SET(CMAKE_AUTOMOC ON)
SET(CMAKE_AUTOUIC ON)

# C++11 support
IF(NOT MSVC)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
ENDIF()

# Show all warnings
IF(NOT MSVC)
    SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wall -Wextra")
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -Wextra")
ENDIF()

# Make final release build smaller
IF(CMAKE_COMPILER_IS_GNUCXX)
    SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -s")
    SET(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} -s")
ENDIF()

# Statically link with libgcc
IF(MINGW)
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libgcc -static-libstdc++")
    SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -static-libgcc -static-libstdc++")
ENDIF()

IF(MSVC)
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nologo -Zc:wchar_t")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -nologo -Zc:wchar_t -w34100 -w34189")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /NOLOGO /DYNAMICBASE /NXCOMPAT")
ENDIF()

# Find Qt
FIND_PACKAGE(Qt5 5.2.0 REQUIRED COMPONENTS Widgets)

# Add additional libraries
FIND_PACKAGE(VLCQt REQUIRED COMPONENTS Widgets)

# Set Qt bin dir to find QtCore*.dll and other libs to install
STRING(REGEX REPLACE "([^ ]+)[/\\].*" "\\1" QT_BIN_DIR_TMP "${QT_MOC_EXECUTABLE}")
STRING(REGEX REPLACE "\\\\" "/" QT_BIN_DIR "${QT_BIN_DIR_TMP}")  # Replace back slashes to slashes
STRING(REGEX REPLACE "bin" "lib" QT_LIB_DIR "${QT_BIN_DIR}")

# Set default install path:
# In *nix environments this is /usr/local
# Under M$ Windows this is C:\Program files\${PROJECT_NAME}
# WARNING: Leading slash should be added - this is for easier concatenation of the strings due to slash/backslash issues
IF(MINGW OR MSVC)
    IF(NOT CMAKE_INSTALL_PREFIX)
        SET(CMAKE_INSTALL_PREFIX "C:/Program files/${PROJECT_NAME}")
    ENDIF()
    SET(PROJECT_INSTALL_BIN_DIR ".")
    SET(PROJECT_INSTALL_LIB_DIR "lib")
ELSEIF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    IF(NOT CMAKE_INSTALL_PREFIX)
        SET(CMAKE_INSTALL_PREFIX "/Applications")
    ENDIF()
    SET(PROJECT_INSTALL_BIN_DIR "${PROJECT_NAME}.app/Contents/MacOS")
    SET(PROJECT_INSTALL_LIB_DIR "${PROJECT_NAME}.app/Contents/MacOS/lib")
    SET(CMAKE_INSTALL_RPATH "@executable_path/lib")
ELSE()
    IF(NOT CMAKE_INSTALL_PREFIX)
        SET(CMAKE_INSTALL_PREFIX "/usr/local")
    ENDIF()
    SET(PROJECT_INSTALL_BIN_DIR "bin")
    SET(PROJECT_INSTALL_LIB_DIR "lib")
ENDIF()

# Set the OS X Bundle specific CMake variables which will be used to populate the plist for
# the application bundle
SET(MACOSX_BUNDLE_COPYRIGHT "2015 Tadej Novak")
SET(MACOSX_BUNDLE_ICON_FILE "${PROJECT_NAME}.icns")
SET(MACOSX_BUNDLE_GUI_IDENTIFIER "si.tano.${PROJECT_NAME_LOWER}")

SET(WINDOWS_AUTHOR "Tadej Novak")
SET(WINDOWS_DESCRIPTION "A simple VLC-Qt example player")
SET(WINDOWS_COPYRIGHT "Copyright (C) ${MACOSX_BUNDLE_COPYRIGHT}")


# Include source
IF(MINGW OR MSVC)
    ADD_SUBDIRECTORY(windows)
ELSEIF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    ADD_SUBDIRECTORY(osx)
ENDIF()

ADD_SUBDIRECTORY(src)
