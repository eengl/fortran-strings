PREFIX ?= /usr/local

.PHONY:	all clean cleanall install test

all:	strings.mod libfstrings.a libfstrings.so

strings.mod:	strings.f90
	$(FC) -g -fbacktrace -fPIC -c $^

libfstrings.a:	strings.o
	$(AR) -ruv $@ $^

libfstrings.so:	strings.o
	$(FC) -I. -fPIC -shared -o $@ $^

test:
	@$(FC) -I./ -o test/test_shared.x test/test.f90 -L./ -lfstrings
	@$(FC) -I./ -o test/test_static.x test/test.f90 ./libfstrings.a
	@test/test.sh shared
	@test/test.sh static


install:
	-install -d -v -m 755 $(PREFIX)/include
	-install -d -v -m 755 $(PREFIX)/lib
	-install -v -m 755 strings.mod $(PREFIX)/include/strings.mod
	-install -v -m 755 libfstrings.a $(PREFIX)/lib/libfstrings.a
	-install -v -m 755 libfstrings.so $(PREFIX)/lib/libfstrings.so

clean:
	-rm -f strings.mod strings.o libfstrings.a libfstrings.so

cleanall:	clean
	-rm -f test/test.x