
message(STATUS "\n-- vcpkg --")

include("/home/cris/.vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake")

find_package(fmt CONFIG REQUIRED)
find_package(Catch2 CONFIG REQUIRED)
find_package(PNG REQUIRED)
find_package(sol2 CONFIG REQUIRED)
find_package(glfw3 CONFIG REQUIRED)

# find_package(GLEW REQUIRED)
find_package(glm CONFIG REQUIRED)
find_package(SDL2 CONFIG REQUIRED)
find_package(sdl2-gfx CONFIG REQUIRED)
find_package(JPEG REQUIRED)
find_package(SDL2_image CONFIG REQUIRED)

find_package(SDL2_mixer CONFIG REQUIRED)
find_package(SDL2_net CONFIG REQUIRED)
find_package(SDL2_ttf CONFIG REQUIRED)

# find_package(SDL2PP REQUIRED)
find_package(Lua REQUIRED)
find_package(range-v3 CONFIG REQUIRED)

message(STATUS "-- vcpkg --\n")