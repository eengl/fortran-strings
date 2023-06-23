# This is the CMake file for the src directory of fortran-strings.
#
# Eric Engle

# These are the source files.
set(fortran_src strings.f90)
set(lib_name ${PROJECT_NAME})
set(module_dir "${CMAKE_CURRENT_BINARY_DIR}/include")

# Create library. It will be STATIC by default, but SHARED if option
# BUILD_SHARED_LIBS is on.
add_library(${lib_name} ${fortran_src})
add_library(${PROJECT_NAME}::${lib_name} ALIAS ${lib_name})

# For shared, set SOVERSION; increment it if API changes (other than
# adding new functions).
if(BUILD_SHARED_LIBS)
  set_target_properties(${lib_name} PROPERTIES SOVERSION 0)
endif()

# Set the compile flags.
set_target_properties(${lib_name} PROPERTIES COMPILE_FLAGS "${BUILD_FLAGS}")
set_target_properties(${lib_name} PROPERTIES Fortran_MODULE_DIRECTORY "${module_dir}")
target_include_directories(${lib_name} PUBLIC $<BUILD_INTERFACE:${module_dir}> $<INSTALL_INTERFACE:include>)
list(APPEND LIB_TARGETS ${lib_name})  
install(DIRECTORY ${module_dir} DESTINATION ${CMAKE_INSTALL_PREFIX})

# Set up install.
install(
  TARGETS ${LIB_TARGETS}
  EXPORT ${PROJECT_NAME}Exports
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

### Package config
include(CMakePackageConfigHelpers)
set(CONFIG_INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

export(EXPORT ${PROJECT_NAME}Exports
  NAMESPACE ${PROJECT_NAME}::
  FILE ${PROJECT_NAME}-targets.cmake)

configure_package_config_file(
  ${CMAKE_SOURCE_DIR}/cmake/PackageConfig.cmake.in ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  INSTALL_DESTINATION ${CONFIG_INSTALL_DESTINATION})
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  DESTINATION ${CONFIG_INSTALL_DESTINATION})

write_basic_package_version_file(
  ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion)
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  DESTINATION ${CONFIG_INSTALL_DESTINATION})

install(EXPORT ${PROJECT_NAME}Exports
  NAMESPACE ${PROJECT_NAME}::
  FILE ${PROJECT_NAME}-targets.cmake
  DESTINATION ${CONFIG_INSTALL_DESTINATION})
