# fortran-strings

[![Build Status](https://travis-ci.com/eengl/fortran-strings.svg?branch=master)](https://travis-ci.com/eengl/fortran-strings)

## Introduction

fortran-strings is a Fortran library and module which contains functions for common string manipulations.  The function ideas originate mainly from Python's built-in [string](https://docs.python.org/3.7/library/stdtypes.html#string-methods) functions.  The functions are accessible by using ``strings`` module in your Fortran code

``use strings``

The function names are prefixed with ``str_``.  The following is a list of available functions:

* **str_count** - Count the occurrences of a substring in a string.
* **str_replace** - Replace a substring with another substring within a parent string.
* **str_upper** - Convert all letters to uppercase.
* **str_lower** - Convert all letters to lowercase.
* **str_split** - Split string based on a character delimiter and return string given by the column number.
* **str_uniq** - Removed duplicative entries from a delimited string.
* **str_zfill** - Pad a string with zeroes ("0") to specified width. If width is <= input string width, then the original string is returned.
* **str_center** - Center a string to a specified width.  The default character to fill in the centered string is a blank character.
* **str_reverse** - Reverse a string.
* **str_test** - Return .true. is a substring is found in a string, .false. otherwise.

All functions return a deferred-length, allocatable character scalar (``character(len=:), allocatable``) with the exception of **``str_count``** which returns an integer and **``str_test``** which returns a logical.

## Requirements

* Fortran compiler (tested with gfortran 4.8.4 and later)

## Build and Installation

Admittedly, my knowledge of automake, autotools, etc is not strong at this time.  The makefile is preconfigured to compile with GNU Fortran (gfortran) ``$FC`` and its appropriate compiler options ``$FFLAGS``.  The default install path is set to ``/usr/local`` via ``$PREFIX``.  To change these make variables, simply edit the makefile or set these variables on the command line prior to the make commands.

```bash
[FC=... FFLAGS="..." PREFIX="..."] make # Build
make test # Test
[sudo] [FC=... FFLAGS="..." PREFIX="..."] make install # Install (sudo access required if install to system area)
```

## Usage

This package provides a module file (**``<prefix>/include/strings.mod``**) and both a shared object library (**``<prefix>/lib/libfstrings.so``**) and a static library (**``<prefix>/lib/libfstrings.a``**).  To use this ``fortran-strings`` in your Fortran program, you must use the ``USE`` statement in your main program or procedure source and during compile, you must specify the library of your choice to the compiler/linker.

Example code:

```fortran
program test
use strings
implicit none

character(len=:), allocatable :: mystring
integer :: icount

mystring="Hello World!  Hello from Fortran!"
icount=str_count(mystring,"Hello") ! Return a count of "Hello" in mystring
write(6,*)"icount = ",icount

end program test
```

Example compile and link to the ***static*** library using gfortran:

```bash
gfortran -I<prefix>/include -o test.x test.f90 <prefix>/lib/libfstrings.a
```

Note that this does not make the executable 100% static.

Example compile and link to the ***shared object*** library using gfortran:

```bash
gfortran -I<prefix>/include -o test.x test.f90 -L<prefix>/lib -lfstrings
```

Note that when compiling and linking to shared object libraries, the library path must be specified in the appropriate environment variable prior to invocation (Linux: ``LD_LIBRARY_PATH``; macOS: ``DYLD_LIBRARY_PATH``).
