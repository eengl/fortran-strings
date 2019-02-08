PREFIX ?= /usr/local

FC ?= gfortran

ifeq ($(FC),"gfortran")
FFLAGS ?= -O3 -g -fbacktrace -fPIC
endif
ifeq ($(FC),"ifort")
FFLAGS ?= -O3 -g -traceback -fPIC
endif

.PHONY:	all clean cleanall install install-docs test

all:	strings.mod libfstrings.a libfstrings.so

strings.mod:	strings.f90
	$(FC) $(FFLAGS) -c $^

libfstrings.a:	strings.o
	$(AR) -ruv $@ $^

libfstrings.so:	strings.o
	$(FC) -I. $(FFLAGS) -shared -o $@ $^

test:
	@$(FC) -I./ $(FFLAGS) -o test/test_shared.x test/test.f90 -L./ -lfstrings
	@$(FC) -I./ $(FFLAGS) -o test/test_static.x test/test.f90 ./libfstrings.a
	@test/test.sh shared
	@test/test.sh static


install:
	-install -d -v -m 755 $(PREFIX)/include
	-install -d -v -m 755 $(PREFIX)/lib
	-install -d -v -m 755 $(PREFIX)/share/man/man3
	-install -v -m 755 strings.mod $(PREFIX)/include/strings.mod
	-install -v -m 755 libfstrings.a $(PREFIX)/lib/libfstrings.a
	-install -v -m 755 libfstrings.so $(PREFIX)/lib/libfstrings.so

install-docs:
	-install -v -m 755 docs/man/man3/strings.3 $(PREFIX)/share/man/man3/strings.3

clean:
	-rm -f strings.mod strings.o libfstrings.a libfstrings.so

cleanall:	clean
	-rm -f test/test.x