all:	strings.mod libfstrings.a libfstrings.so

strings.mod:	strings.f90
	$(FC) -g -fbacktrace -c $^

libfstrings.a:	strings.o
	$(AR) -ruv $@ $^

libfstrings.so:	strings.o
	$(FC) -I. -fPIC -shared -o $@ $^

test:		test.f90 
	$(FC) -I. -o $@ $^ -L./ -lfstrings

clean:
	-rm -f strings.mod strings.o libfstrings.a libfstrings.so

cleanall:	clean
	-rm -f test
