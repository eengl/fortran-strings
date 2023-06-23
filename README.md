![Status](https://github.com/eengl/fortran-strings/actions/workflows/build_linux.yml/badge.svg)

# fortran-strings

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
* **str_swapcase** - Swap the case of letters in a string.

All functions return a deferred-length, allocatable character scalar (``character(len=:), allocatable``) with the exception of **``str_count``** which returns an integer and **``str_test``** which returns a logical.

For more detailed documentation, see https://eengl.github.io/fortran-strings/

## Requirements

* CMake v3.15+
* Fortran compiler (tested with gfortran 4.8.4 and later)

## Installation

```bash
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/install /path/to/fortran-strings
make
make test
make install
```
