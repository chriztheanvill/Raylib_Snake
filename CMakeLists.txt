# ## Using Ccmake
# #
# # $ cd /media/cris/Panzer/Cris/Documents/Workspace_Linux/Cpp_Cmake_VSCode/build
# # $ ccmake ..
# #
# # Push [enter] to change val
# # Push [c] to config
# # Push [g] to make the changes happen and exit
# # Push [q] to exit, and not make changes
# #
# # Setup
# #     Cppcheck ON
# #     Clang-tidy OFF
# #     Cppcheck ON
# #     Enable_Sanitizer_Address ON (On sanitizer, just can be enabled one kind)
# #
# ##

# # Main CMAKE file
# # CMAKE version minimun required 3.16.3
cmake_minimum_required(VERSION 3.28.1)

# # Name System proyect ##
project(My_00 VERSION 1.0.0 LANGUAGES C CXX)

add_compile_options(

  # -std=c++20
  -ffast-math

  # Improve maths
  # -ffast-math
  #
  # # -ffast-math has all this
  # -ffinite-math-only
  # -fno-signed-zeros
  # -fno-trapping-math
  # -fassociative-math
  # -fno-math-errno
  # -freciprocal-math
  # -funsafe-math-optimizations
  # -fcx-limited-range
  # # -ffast-math has all this
  # ~Improve maths

  # -fmodules-ts
)

include(My_Cmake/Standard_Project_Settings.cmake)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_20 cxx_lambda_init_captures)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)

# standard compiler warnings
include(My_Cmake/Compiler_Warnings.cmake)
set_project_warnings(project_warnings)

# sanitizer options if supported by compiler
include(My_Cmake/Sanitizers.cmake)
enable_sanitizers(project_options)

# Find Linux Version
include(My_Cmake/Linux_Ver.cmake)

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
  get_linux_lsb_release_information()
  message(STATUS "+++++++++++++++ GNU Linux ${LSB_RELEASE_ID_SHORT} ${LSB_RELEASE_VERSION_SHORT} ${LSB_RELEASE_CODENAME_SHORT} +++++++++++++++")
endif()

# enable Threads
include(My_Cmake/Threads.cmake)

# enable doxygen
include(My_Cmake/Doxygen.cmake)
enable_doxygen()

# allow for static analysis options
include(My_Cmake/Static_Analyzers.cmake)

# ###############################################################
# Enable Boost (Please NO)
# include(My_Cmake/Boost.cmake)

# ###############################################################
# Enable MyLibs
include(My_Cmake/MyLibs.cmake)

# ###############################################################
# # Conan config (Old)
# include(My_Cmake/Conan_v1.cmake)
# run_conan()
# ###############################################################
# # Conan config (New)
include(My_Cmake/Conan_v2.cmake)

# ###############################################################
# # vcpkg
# include(My_Cmake/Vcpkg_Find.cmake)

# ###############################################################

# set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 17)
# set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# # Set the current directory the run time folder
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR})

# ###############################################################
# Very basic PCH example
option(ENABLE_PCH "Enable Precompiled Headers" ON)

# option(ENABLE_PCH "Enable Precompiled Headers" OFF)
if(ENABLE_PCH)
  # This sets a global PCH parameter, each project will build its own PCH, which
  # is a good idea if any #define's change
  #
  message(STATUS " -- Precompiled Headers ")

  # target_precompile_headers(project_options INTERFACE <vector> <string> <map> <utility>)
  target_precompile_headers(
    project_options

    # PUBLIC
    # "foo.h"
    INTERFACE

    # System
    <array>
    <iostream>
    <fstream>
    <map>
    <memory>
    <iterator>
    <random>
    <string>
    <utility>
    <vector>

    # 3s
    <SDL2/SDL.h>
    <SDL2/SDL_image.h>
    <SDL2/SDL_ttf.h>

    # <fmt/core.h>
    # <fmt/color.h>
    <glm/glm.hpp>

    # Boost
    # <boost/format.hpp>

    # <boost/filesystem
  )
endif()

# ###############################################################
# Enable C++20

# add_definitions(-std=c++11)
# add_definitions(-std=c++17 -DANALYSIS=ON)
# add_definitions(-std=c++2a -DANALYSIS=ON)
# add_definitions(-std=c++20 -DANALYSIS=ON)

# # DEPRECATED
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated -Wdeprecated-declarations")
# set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -Xclang -fconcepts-ts")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20 -Xclang -fconcepts-ts")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20 -fconcepts")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a -fconcepts")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a ")

# # Which C++ version.
# set(CMAKE_C_STANDARD 99)
# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD 14)
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD 23)

# # Debug flags.
set(CMAKE_BUILD_TYPE Debug)

# set(CMAKE_BUILD_TYPE Release)

# # Check compiler
# # https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html
set(CMAKE_SYSTEM_NAME Linux)

# set(CMAKE_SYSTEM_PROCESSOR arm)
# set(triple arm-linux-gnueabihf)

# set(CMAKE_C_COMPILER clang)
# set(CMAKE_CXX_COMPILER clang++)
# set(CMAKE_C_COMPILER_TARGET ${triple})
# set(CMAKE_CXX_COMPILER_TARGET ${triple})
include(My_Cmake/Clang_setup.cmake)

# # For example, to build LLVM, Clang, libcxx, and libcxxabi,
# # use -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxxabi".

# ###############################################################

# Enable Testing
enable_testing()

# message( "Testing enabled!!!" )
# add_subdirectory(test)
# add_subdirectory(googletest)

# ## List Programs ###
# # 0000 program ##
add_subdirectory(Source)

# ###############################################################
# # FOR Single project
# target_link_libraries(
# ${PROJECT_NAME} PUBLIC
# # ${LUA_LIBRARIES}
# ${LUA_LIBRARY}
# ${THREAD_LIBRARIES}
# ${OPENGL_VIDEO_LIBRARIES}
# # ${Boost_LIBRARIES}
# )

# ###############################################################

# message(STATUS "\n -- CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR}")
# message(STATUS "\n -- CMAKE_CURRENT_LIST_DIR ${CMAKE_CURRENT_LIST_DIR}")

# # <==================================== The Original
# add_custom_target(
# copy-compile-commands ALL
# ${CMAKE_COMMAND} -E copy
# ${CMAKE_BINARY_DIR}/compile_commands.json
# ${CMAKE_CURRENT_LIST_DIR}
# )

# # Only when are changes
# add_custom_target(
# copy-compile-commands ALL
# ${CMAKE_COMMAND} -E copy_if_different
# ${CMAKE_BINARY_DIR}/compile_commands.json
# ${CMAKE_CURRENT_LIST_DIR}
# )

# file(COPY
# ${CMAKE_BINARY_DIR}/compile_commands.json
# DESTINATION
# ${CMAKE_CURRENT_LIST_DIR})

# ###############################################################
message(STATUS "\n -- MY -- CMake C FLAGS ${CMAKE_C_FLAGS}")
message(STATUS " -- MY -- CMake C++ FLAGS ${CMAKE_CXX_FLAGS} \n\n")

# ###############################################################
# # Features
# ## Lambdas
target_compile_features(
  ${PROJECT_NAME} PRIVATE

  # LAMBDA FEATURES
  cxx_lambda_init_captures

  # C++17 ENABLED
  # cxx_std_17
  # C++20 ENABLED
  cxx_std_20

  # C++23 ENABLED
  # cxx_std_23
)

# ###############################################################

# # Packaging
# ## LINUX, COMPRESSOR
include(My_Cmake/Packaging.cmake)

# ###############################################################
# # Install
# install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin) # $(CMAKE_INSTALL_PREFIX) / bin
# install(FILES "src/main.cpp" DESTINATION src) # $(CMAKE_INSTALL_PREFIX) / bin
# target_link_libraries(${PROJECT_NAME} PRIVATE son_library)

# install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)
# ###############################################################
# ###############################################################

# install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)
# ###############################################################
# ###############################################################
