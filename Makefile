all: decode file1 file2

decode: libcrak.so decode.o libcypher.so
	gcc -m32 decode.o -L. -Wl,-rpath='$$ORIGIN' -lcrak -lcypher -o decode

invasive: fix.o bypass.o decode.o libcypher.so
	gcc -m32 fix.o bypass.o decode.o -L. -Wl,-rpath='$$ORIGIN' -lcypher -o decode

bypass.o: bypass.c
	gcc -m32 -c $< -o $@

fix.o: fix.S
	as -32 $< -o $@

libcrak.so: bypass.o fix.o
	gcc -m32 --shared $^ -o $@

file1: invasive
	./decode -k ABC -d crypt1.dat file1

file2: invasive
	./decode -k ABC -d crypt2.dat file2

.PHONY: clean run dist
clean:
	rm -f decode bypass.o fix.o

dist:
	tar zcvf decode.tar.gz Makefile fix.S bypass.c decode.o libcypher.so
