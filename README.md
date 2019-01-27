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
* **str_uniq** - Removed duplicative entries from a \b delimited string.
* **str_zfill** - Pad a string with zeroes ("0") to specified width. If width is <= input string width, then the original string is returned.
* **str_center** - Center a string to a specified width.  The default character to fill in the centered string is a blank character.
* **str_reverse** - Reverse a string.

All functions return a deferred-length, allocatable character scalar (``character(len=:), allocatable``) with the exception of **``str_count``** which returns an integer.

## Requirements

* Fortran compiler (tested with gfortran 4.8.4 and later)

## Build and Installation

Admittedly, my knowledge of automake, autotools, etc is not strong at this time.  The makefile is preconfigured to compile with GNU Fortran (gfortran) ``$FC`` and its appropriate compiler options ``$FFLAGS``.  The default install path is set to ``/usr/local`` via ``$PREFIX``.  To change these make variables, simply edit the makefile or set these variables on the command line prior to the make commands.

``> [FC=... FFLAGS="..." PREFIX="..."] make``

``> [sudo] [FC=... FFLAGS="..." PREFIX="..."] make`` **(sudo access required to install to system area)**

### Test

Prior to ``make install ``, though optional, it is good practice to test the build with via

``> make test``


