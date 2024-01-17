# Packaging support

set(CPACK_PACKAGE_VENDOR "SystemsInu")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Game")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

# set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENCE")
# set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

# # Linux
# ## RPM

# cpack -G RPM
# rpm -qpR /the/generated/software.rpm

# LINUX SUPPORT
# # Debian
option(ENABLE_PKG_DEB "Enable Packaging for Debian" OFF)
option(ENABLE_SHARE_SOURCE "Enable Packaging for Debian" OFF)

if(ENABLE_PKG_DEB)
	message(STATUS "+++ PACKAGING FOR DEBIAN +++")
	message(STATUS "cd build && cpack \n\n")

	# # Generates the Normal Executable
	install(
		TARGETS ${PROJECT_NAME}

		# COMPONENT linapp
		RUNTIME DESTINATION "/home/.${PROJECT_NAME}/"
		LIBRARY DESTINATION "/home/.${PROJECT_NAME}/"
		DESTINATION "/home/.${PROJECT_NAME}/"
	)

	# # Generates the Debug Executable
	install(
		TARGETS ${PROJECT_NAME}
		CONFIGURATIONS Debug
		RUNTIME DESTINATION "/home/.${PROJECT_NAME}/Debug/bin"
		LIBRARY DESTINATION "/home/.${PROJECT_NAME}/Debug/lib"
	) # $(CMAKE_INSTALL_PREFIX) / bin

	# # Generates the Release Executable
	install(
		TARGETS ${PROJECT_NAME}
		CONFIGURATIONS Release
		RUNTIME DESTINATION "/home/.${PROJECT_NAME}/Release/bin"
		LIBRARY DESTINATION "/home/.${PROJECT_NAME}/Release/lib"
	) # $(CMAKE_INSTALL_PREFIX) / bin

	if(ENABLE_SHARE_SOURCE)
		message(STATUS "SHARING SOURCE\n\n")

		# # Main.CPP
		install(
			FILES "0000/main_cmake/main.cpp"
			DESTINATION "/home/.${PROJECT_NAME}/src"
		) # $(CMAKE_INSTALL_PREFIX) / bin

		# install(FILES "0000/main_cmake/main.cpp" DESTINATION project) # $(CMAKE_INSTALL_PREFIX) / bin

		# # Headers if are in the same folder with main.cpp
		install(
			DIRECTORY "0000/main_cmake/src" # source directory
			DESTINATION "/home/.${PROJECT_NAME}/src" # target directory
			FILES_MATCHING # install only matched files
			PATTERN "*.h" # select header files
		)
	endif() # # ENABLE SHARE SOURCE

	# # Assets
	install(
		DIRECTORY "assets" # source directory
		DESTINATION "/home/.${PROJECT_NAME}/" # target directory

		# FILES_MATCHING # install only matched files
		# PATTERN "*.h" # select header files
	)

	set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
	set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Cris") # required
	set(CPACK_DEBIAN_PACKAGE_VERSION 1) # App Version
	set(CPACK_DEBIAN_PACKAGE_RELEASE 1) # Packaging Version

	# set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.3.1-6), libc6 (< 2.4)")
	set(CPACK_GENERATOR "DEB") # # ENABLE JUST FOR DEBIAN, NOT FOR WIN OR OTHERS

# Note: If runs cpack without args, will create all source generators
# # 7Z, TGZ and DEBs

# ####################################################
# ####################################################
else() # # Compressor
	# Common

	# 7Z 7-Zip file format (archive)
	# IFW Qt Installer Framework (executable)
	# NSIS Null Soft Installer (executable)
	# NSIS64 Null Soft Installer (64-bit, executable)
	# STGZ Self extracting Tar GZip compression (archive)
	# TBZ2 Tar BZip2 compression (archive)
	# TGZ Tar GZip compression (archive)
	# TXZ Tar XZ compression (archive)
	# TZ Tar Compress compression (archive)
	# WIX MSI file format via WiX tools (executable archive)
	# ZIP ZIP file format (archive)
	# DEB SH file format (archive)
	message(STATUS "+++ PACKAGING FOR COMPRESSION +++")
	message(STATUS "cd build && cpack -G 7Z .")
	message(STATUS " * Check the list in My_Cmake/Packaging.cmake\n\n")

	install(
		TARGETS ${PROJECT_NAME}
		CONFIGURATIONS Debug
		RUNTIME DESTINATION Debug/bin
	) # $(CMAKE_INSTALL_PREFIX) / bin

	install(
		TARGETS ${PROJECT_NAME}
		CONFIGURATIONS Release
		RUNTIME DESTINATION Release/bin
	) # $(CMAKE_INSTALL_PREFIX) / bin

	if(ENABLE_SHARE_SOURCE)
		message(STATUS "SHARING SOURCE\n\n")

		# # Main.CPP
		install(
			FILES "Source/Main/main.cpp"
			DESTINATION src
		) # $(CMAKE_INSTALL_PREFIX) / bin

		# install(FILES "Source/Main/main.cpp" DESTINATION project) # $(CMAKE_INSTALL_PREFIX) / bin

		# # Headers if are in the same folder with main.cpp
		install(
			DIRECTORY "Source/Main/src" # source directory
			DESTINATION "src" # target directory
			FILES_MATCHING # install only matched files
			PATTERN "*.h" # select header files
		)
	endif() # # ENABLE SHARE SOURCE

	# # Assets
	install(
		DIRECTORY "assets" # source directory
		DESTINATION "." # target directory

		# FILES_MATCHING # install only matched files
		# PATTERN "*.h" # select header files
	)

	set(CPACK_SOURCE_GENERATOR "7Z;TGZ") # # MAKE A COMPRESSION

	# set(CPACK_SOURCE_GENERATOR "7Z;TGZ;DEB") ## MAKE A COMPRESSION
endif() # # ENABLE_PKG_DEB

set(
	CPACK_SOURCE_IGNORE_FILES
	/.git
	/.cache
	/dist
	/google_test
	/.*build.*
	/\\\\.DS_Store
)

# cpack path/to/build/directory
# cd build && cpack -G 7Z .
include(CPack) # # SHOULD BE AT THE END
