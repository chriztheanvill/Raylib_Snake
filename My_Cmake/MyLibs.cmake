# # Graphics
#
# PkgConfig
# OpenGl
# Vulkan
# GFLW
# GLEW
# Glad
# SFML
# SDL2
#
#
#
# set(CMAKE_MODULE_PATH /usr/local/lib/cmake /usr/local/lib/x86_64-linux-gnu/cmake)
# set(CMAKE_PREFIX_PATH /usr/local/lib/cmake/glfw3)

# ## SFML
# set(OpenGL_GL_PREFERENCE GLVND)
# set(OpenGL_GL_PREFERENCE LEGACY) ## Un comment if doesn't work

find_package(PkgConfig REQUIRED)
find_package(OpenGL REQUIRED)
find_package(Vulkan REQUIRED)
find_package(SDL2 REQUIRED)
# find_package(Raylib 4.2.0 REQUIRED)

# find_package(SFML 2.5 COMPONENTS system window graphics network audio REQUIRED)
find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)
find_package(GLEW REQUIRED STATIC)

# if(CMAKE_SYSTEM_NAME MATCHES "Linux")
# if(${LSB_RELEASE_ID_SHORT} STREQUAL "Fedora")
# find_package (Lua51 REQUIRED)
# else()
# # find_package(Lua 5.3 REQUIRED)
# FIND_PACKAGE(Lua REQUIRED)
# endif()
# endif()
find_package(Lua REQUIRED)
add_definitions(-DLUA)

# include_directories(/usr/local/include ${LUA_INCLUDE_DIR})
message(STATUS "+++ LUA dir: " ${LUA_VERSION_STRING} " - " ${LUA_INCLUDE_DIR} " - " ${LUA_LIBRARIES} " - " ${LUA_LIBRARY})

# Install the development libraries of Lua 5.3 with sudo apt-get install liblua5.3-dev
# In our Makefile, replace -llua with -llua5.3

# ## GLFW
# ## GLFW additions
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

# set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS ON CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

# # SDL2
include_directories(
	${SDL2_INCLUDE_DIRS}

	# #   ${SDL2IMAGE_INCLUDE_DIRS}
	# #   ${SDL2GFX_INCLUDE_DIRS}
	${LUA_INCLUDE_DIR}
)

# message(STATUS "+++ SDL2 dir: " ${SDL2_INCLUDE_DIRS} " - " ${SDL2_IMAGE_INCLUDE_DIR})

# include_directories(
# ${SDL2_INCLUDE_DIR}
# ${SDL2_IMAGE_INCLUDE_DIR}
# ${SDL2_TTF_INCLUDE_DIR}
# )

# # OPENGL_VIDEO_LIBRARIES
set(
	OPENGL_VIDEO_LIBRARIES

	# # GENERAL System Libraries
	#${OPENGL_LIBRARY}
	${OPENGL_LIBRARIES}
	${OPENGL_gl_LIBRARIES}
	${OPENGL_glu_LIBRARIES}

	# GLFW
	${GLFW_LIBRARIES}
	#${GLFW3_LIBRARY}
	${GLFW3_LIBRARIES}
	${GLEW_LIBRARIES}
	#${GLEW_LIBRARY}

	# # SDL2
	${SDL2_LIBRARIES}
	${SDL2GFX_LIBRARIES}
	${SDL2_IMAGE_LIBRARIES}
	${SDL2_TTF_LIBRARIES}

	# # Define Libraries
	Vulkan::Vulkan
	OpenGL::GL
	GLEW::GLEW
	glfw
	SOIL
	OpenGL

	# # SDL2
	SDL2
	SDL2_image
	SDL2_net
	SDL2_mixer
	SDL2_ttf
	SDL2_gfx

	# ----- Raylib ----- #
	# raylib

	# ----- SFML ----- #
	# ${SFML_LIBRARIES}
	# ${SFML_DEPENDENCIES}
	# sfml-system
	# sfml-window
	# sfml-graphics
	# sfml-network
	# sfml-audio
	# #   sfml‑main // NO

	# # LUA
	lua5.4 # # Debian SID BTRFS
	# lua # # Fedora
	m
	dl

	# # SDL2_sound

	# # System Libraries
	# Xi
	# GLEW
	# GLU
	# m
	# GL
	# m
	# glut
	# pthread
	# dl
	# drm
	# Xdamage
	# X11-xcb
	# xcb-glx
	# xcb-dri2
	# #glfw3
	# rt
	# m
	# dl
	# Xrandr
	# Xinerama
	# Xxf86vm
	# Xext
	# Xcursor
	# Xrender
	# Xfixes
	# X11
	# pthread
	# xcb
	# Xau
	# Xdmcp
	# assimp
	# #

	# # TCP
	mysqlclient
)
