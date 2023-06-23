# This is the CMake build file for the test directory of fortran-strings.

# Eric Engle

# This function builds, links, and runs a test program.
function(create_test name)
  add_executable(${name} ${name}.f90)
  target_link_libraries(${name} PRIVATE fortran-strings::fortran-strings)
  add_test(NAME ${name} COMMAND ${name})
endfunction()

create_test(test_fortran_strings)
