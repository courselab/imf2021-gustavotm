all: decode run

decode: decode.o libcypher.so
	gcc -m32 decode.o -L. -lcypher -o decode

invasive: bypass.o decode.o libcypher.so
	gcc -m32 bypass.o decode.o -L. -Wl,-rpath='$$ORIGIN' -lcypher -o decode

bypass.o: bypass.c
	gcc -m32 -c $< -o $@

.PHONY: clean run
clean:
	rm -f decode

run: decode
	LD_LIBRARY_PATH=. ./decode