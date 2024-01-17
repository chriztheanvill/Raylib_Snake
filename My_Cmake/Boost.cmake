################################################################
## BOOST Default System
set(Boost_USE_STATIC_LIBS        ON)  # only find static libs
set(Boost_USE_DEBUG_LIBS         OFF) # ignore debug libs and
set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost REQUIRED COMPONENTS thread system date_time filesystem chrono atomic)
if(Boost_FOUND)
	include_directories(${Boost_INCLUDE_DIRS})
	 message(STATUS "+++ Boost SUCCESS!!!")
	 message(STATUS "Boost_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
	 message(STATUS "Boost_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
	 message(STATUS "Boost_LIBRARIES: ${Boost_LIBRARIES}")
	 message(STATUS "Boost_VERSION: ${Boost_VERSION}")
	 message(STATUS "boost inc:${Boost_INCLUDE_DIR}")
	 message(STATUS "boost lib: ${Boost_LIBRARY_DIR}")
endif()

# find_package(Boost )
# if(NOT Boost_FOUND)
# 	message(FATAL_ERROR "Could not find boost!!!")
# 	else()
# 	message(STATUS "Boost Find it!!!")
# endif()


################################################################
