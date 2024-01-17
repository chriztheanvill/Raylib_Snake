### TEST ###

# automatically enable catch2 to generate ctest targets
if(CONAN_CATCH2_ROOT_DEBUG)
message("------------------------------ TRUE")
include(${CONAN_CATCH2_ROOT_DEBUG}/lib/cmake/Catch2/Catch.cmake)
else()
message("------------------------------ FALSE" ${CONAN_CATCH2_ROOT})
  include(${CONAN_CATCH2_ROOT}/lib/cmake/Catch2/Catch.cmake)
endif()


add_library(catch_main STATIC catch_main.cpp)
target_link_libraries(catch_main PUBLIC CONAN_PKG::catch2)

add_executable(tests test.cpp)
target_link_libraries(tests PRIVATE 
											## System
											project_options 
											project_warnings
											${LUA_LIBRARY}
											${THREAD_LIBRARIES}
											${OPENGL_VIDEO_LIBRARIES}
											${Boost_LIBRARIES}
											
											## Catch
											catch_main
											
											## My Libs
											)
# target_link_libraries(tests PRIVATE project_warnings project_options
#                                     catch_main)

# Automatically discover tests that are defined
# in catch based test files you can modify the unittests.
# TEST_PREFIX to whatever you want, or use different
# for different binaries
catch_discover_tests(
  tests
  TEST_PREFIX
  "Engine_test."
  EXTRA_ARGS
  -s
  --reporter=xml
  --out=tests.xml)


# add_executable(Testing_Engine test.cpp)
# target_link_libraries(Testing_Engine PRIVATE 
# 											## System
# 											project_options 
# 											project_warnings

# 											## Catch
# 											catch_main

# 											## My Libs
# 											Engine
# 											)

# catch_discover_tests(
#   Testing_Engine
#   TEST_PREFIX
#   "My_Test."
#   EXTRA_ARGS
#   -s
#   --reporter=xml
#   --out=constexpr.xml)
