# Set up some extra Conan dependencies based on our needs
# before loading Conan
set(CONAN_EXTRA_REQUIRES "")
set(CONAN_EXTRA_OPTIONS "")

# if(CPP_STARTER_USE_IMGUI)
# set(
# CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES}
# imgui-sfml/2.1@bincrafters/stable)

# set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} sfml:shared=False
# sfml:graphics=True sfml:audio=False sfml:window=True
# libalsa:disable_python=True)
# endif()
macro(run_conan)
	list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
	list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

	# # https://docs.conan.io/1/howtos/cmake_launch.html
	# Download automatically, you can also just copy the conan.cmake file
	if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
		message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
		file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
			"${CMAKE_BINARY_DIR}/conan.cmake")

		conan_add_remote(NAME bincrafters URL https://bincrafters.jfrog.io/artifactory/api/conan/public-conan)

	else()
		message(STATUS "+++ CONAN ALREADY INSTALLED!!!")
		message(STATUS "Conan Path: ${CMAKE_BINARY_DIR}\n")
	endif()

	include(${CMAKE_BINARY_DIR}/conan.cmake)

	conan_cmake_run(
		REQUIRES
		${CONAN_EXTRA_REQUIRES}

		# // ------------------------------ //
		#
		# ## Conan Packages ###
		#
		catch2/2.13.7 # ## Stable

		# catch2/3.0.0@catchorg/stable ### Testing
		#
		docopt.cpp/0.6.3
		fmt/8.0.1 # ## Format Console text
		spdlog/1.9.2
		glad/0.1.34 # ## openGL
		glew/2.2.0 # ## openGL
		nlohmann_json/3.10.2 # ## JSON
		sol2/3.2.3 # ## Lua Sol2
		range-v3/0.12.0

		# imgui-sfml/2.1@bincrafters/stable
		#
		# ## Enable glad and glfw if you have problems.
		#
		# glfw/3.3.2@bincrafters/stable
		#
		# // ------------------------------ //
		#
		# sdl2/2.0.10@bincrafters/stable
		# glew/2.1.0@bincrafters/stable
		# mesa-glu/9.0.1@bincrafters/stable
		#
		# // ------------------------------ //
		#
		OPTIONS
		${CONAN_EXTRA_OPTIONS}
		BASIC_SETUP

		# # Individual targets to link to
		# CMAKE_TARGETS // cant use ${CONAN_LIBS}

		# ## Options (Optionals)
		# fmt:shared=False
		# sfml:shared=False
		# sfml:graphics=True
		# sfml:audio=False
		# sfml:window=True
		# libalsa:disable_python=True

		#
		BUILD
		missing
	)
endmacro()
