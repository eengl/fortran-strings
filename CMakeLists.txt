# This is the main CMake file for fortran-strings.
#
# Eric Engle
cmake_minimum_required(VERSION 3.15)

# Get the version from the VERSION file.
file(STRINGS "VERSION" pVersion)
project(fortran-strings VERSION ${pVersion} LANGUAGES Fortran)

# Set the version for the documentation.
SET(PACKAGE_VERSION ${pVersion})

include(GNUInstallDirs)

# Handle user options.
OPTION(ENABLE_DOCS "Enable generation of doxygen-based documentation" OFF)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

# Turn on position independent code
SET(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Check build type.
if(NOT CMAKE_BUILD_TYPE MATCHES "^(Debug|Release|RelWithDebInfo|MinSizeRel)$")
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE
    "Release"
    CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
    "MinSizeRel" "RelWithDebInfo")
endif()

# Set compiler flags.
if(CMAKE_Fortran_COMPILER_ID MATCHES "^(Intel)$")
  set(CMAKE_Fortran_FLAGS
    "-g -traceback -fpp ${CMAKE_Fortran_FLAGS}")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^(GNU)$")
  set(CMAKE_Fortran_FLAGS "-g -fbacktrace ${CMAKE_Fortran_FLAGS}")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^(NVHPC)$")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
endif()

# Handle argument mismatch problems for GNU versions > 10.
if(${CMAKE_Fortran_COMPILER_ID} MATCHES "^(GNU)$" AND ${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 10)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -w -fallow-argument-mismatch -fallow-invalid-boz")
endif()

# This is where the library code is.
add_subdirectory(src)

# Build and run tests.
include(CTest)
if(BUILD_TESTING)
    add_subdirectory(tests)
endif()
#
# Does the user want to generate documentation?
#if(ENABLE_DOCS)
#  find_package(Doxygen REQUIRED)
#endif()
#add_subdirectory(docs)  
