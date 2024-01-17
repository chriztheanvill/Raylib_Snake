# # // TODO Actualizar: EN lugar de CMAKE_CXX_FLAGS usar add_compile_options

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  message(STATUS "+++ Using Clang!!! ${CMAKE_CXX_COMPILER} - ${CMAKE_CXX_COMPILER_VERSION}")

  # set(CMAKE_CXX_COMPILER "clang++")
  # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a ")
  # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-module-maps -fprebuilt-implicit-modules")

  # set(PREBUILT_MODULE_PATH ${CMAKE_BINARY_DIR}/modules)

  # add_compile_options(-fmodules)
  add_compile_options(-stdlib=libc++)

# add_compile_options(-fbuiltin-module-map)
# add_compile_options(-fimplicit-module-maps)
# add_compile_options(-fprebuilt-module-path=${PREBUILT_MODULE_PATH})
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  message(STATUS "+++ Using GNU!!! ${CMAKE_CXX_COMPILER} - ${CMAKE_CXX_COMPILER_VERSION}")

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a -fmodules-ts")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a -fdiagnostics-color=always ")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fdiagnostics-color=always")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  message(STATUS "+++ Using INTEL!!!")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  message(STATUS "+++ Using MSVC!!!")
endif()