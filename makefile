all:	test.x

strings.mod strings.o:	strings.f90
	$(FC) -c $^

test.x:	test.f90 strings.o
	$(FC) -o $@ $^

clean:
	-rm -f strings.mod strings.o test.o test.x
