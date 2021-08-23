all: decode run

decode: decode.o libcypher.so
	gcc -m32 decode.o -L. -lcypher -o decode

invasive: fix.o bypass.o decode.o libcypher.so
	gcc -m32 fix.o bypass.o decode.o -L. -Wl,-rpath='$$ORIGIN' -lcypher -o decode

bypass.o: bypass.c
	gcc -m32 -c $< -o $@

file1: invasive
	./decode -k ABC -d crypt1.dat file1

file2: invasive
	./decode -k ABC -d crypt2.dat file2

fix.o: fix.S
	as -32 $< -o $@

.PHONY: clean run
clean:
	rm -f decode bypass.o fix.o

run: decode
	LD_LIBRARY_PATH=. ./decode