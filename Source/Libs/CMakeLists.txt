###### Libraries ######
#
# Type of libraries
# SHARED:		dll, so, dylib
# STATIC:		lib, a
# INTERFACE:	Only headers, Doesnt show up in IDE's
#
# * Shared are small space size, does not uses RAM
# But sometimes needs some 3rds libraries to work on
# * Static, does not need 3rds, there all in the lib
# But are bigger in space size, uses RAM to work

### Engine
add_library(
        #	 Engine STATIC
        Engine SHARED
        #        src/Engine/Constants.h
        #
        src/Engine/Engine.cpp
        src/Engine/Engine.h
        #

		)

# set_target_properties(Engine PROPERTIES LINKER_LANGUAGE CXX)

# add_library(
# 	Component SHARED
# 	src/Engine/Component.h
# )

# set_target_properties(Component PROPERTIES LINKER_LANGUAGE CXX)

### Unique Header file
## Examples Librarie
# add_library(
#         examples_video
#         examples/examples_video.h
# )
# ## Set examples_video.h C++ file
# ## This is only for unique headers.
# set_target_properties(examples_video PROPERTIES LINKER_LANGUAGE CXX)
### Unique Header file

# target_compile_definitions(son_library PUBLIC SON_LIBRARY_VERSION-1)
# PUBLIC:		MAIN + SON_LIBRARY
# PRIVATE:		SON_LIBRARY
# INTERFACE:	MAIN


target_include_directories(
        Engine PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src"
        # Constants PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src"
        # Entity PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src"
        # EntityManager PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src"
        # Component PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src"
        # Transform PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src"
)

# ### Add LINKS
target_link_libraries(
        Engine PUBLIC
        ## Options
        # project_options
        # project_warnings
        ## Conan
        CONAN_PKG::docopt.cpp
        CONAN_PKG::fmt
        CONAN_PKG::spdlog
        CONAN_PKG::nlohmann_json
        # CONAN_PKG::imgui-sfml
        # CONAN_PKG::sdl2
        ## MY LIBRARIES

        # Component
)


###### Libraries ######

# ON BOOST USE
# find_package(Boost REQUIRED
#				COMPONENTS thread system)
# target_link_libraries(mylib
#						Boost::thread)

# AVOID TO USE
# include_directories
# add_definitions
# add_dependences
# add_compile_options
