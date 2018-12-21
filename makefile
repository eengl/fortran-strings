all:	MODULE libfstrings.a libfstrings.so

MODULE:	strings.f90
	$(FC) -g -fbacktrace -c $^

libfstrings.a: strings.o
	$(AR) -ruv $@ $^

libfstrings.so: strings.o
	$(FC) -I. -fPIC -shared -o $@ $^

clean:
	-rm -f strings.mod strings.o libfstrings.a libfstrings.so
