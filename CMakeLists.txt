cmake_minimum_required(VERSION 3.10)

project(ntrip VERSION 1.2.0 LANGUAGES CXX)

option(NTRIP_BUILD_CASTER "Build NtripCaster support" ON)
option(NTRIP_BUILD_CLIENT "Build NtripClient support" ON)
option(NTRIP_BUILD_SERVER "Build NtripServer support" ON)
option(NTRIP_BUILD_EXAMPLES "Build example executables" ON)

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Using default build type: Debug")
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release)
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(git_utility)

find_package(Threads REQUIRED)

set(GIT_BRANCH "")
get_git_branch(GIT_BRANCH)
set(GIT_HASH "")
get_git_hash(GIT_HASH)

message(STATUS "Source code version: ${PROJECT_VERSION}")
message(STATUS "Git branch: ${GIT_BRANCH}")
message(STATUS "Git hash: ${GIT_HASH}")

set(NTRIP_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(NTRIP_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(NTRIP_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

set(NTRIP_GENERATED_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/generated")
file(MAKE_DIRECTORY "${NTRIP_GENERATED_INCLUDE_DIR}")
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/src/cmake_definition.h.in"
  "${NTRIP_GENERATED_INCLUDE_DIR}/cmake_definition.h"
  @ONLY
)

set(NTRIP_SOURCES
  "${CMAKE_CURRENT_SOURCE_DIR}/src/ntrip_util.cc"
)

if (NTRIP_BUILD_CLIENT)
  list(APPEND NTRIP_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/ntrip_client.cc")
else()
  message(STATUS "NtripClient support disabled")
endif()

if (NTRIP_BUILD_SERVER)
  list(APPEND NTRIP_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/ntrip_server.cc")
else()
  message(STATUS "NtripServer support disabled")
endif()

if (NTRIP_BUILD_CASTER)
  list(APPEND NTRIP_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/ntrip_caster.cc")
else()
  message(STATUS "NtripCaster support disabled")
endif()

add_library(ntrip ${NTRIP_SOURCES})
add_library(ntrip::ntrip ALIAS ntrip)

target_compile_features(ntrip PUBLIC cxx_std_11)
target_include_directories(ntrip
  PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
    "${NTRIP_GENERATED_INCLUDE_DIR}"
)
target_link_libraries(ntrip PUBLIC Threads::Threads)

if (MSVC)
  target_compile_options(ntrip PRIVATE /W4)
else()
  target_compile_options(ntrip PRIVATE -Wall)
endif()

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  target_compile_options(ntrip PRIVATE -Wfatal-errors)
endif()

if (WIN32)
  target_link_libraries(ntrip PUBLIC ws2_32)
endif()

set_target_properties(ntrip PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib"
)

if (NTRIP_BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()
