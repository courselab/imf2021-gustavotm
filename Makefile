all: decode run

decode: decode.o libcypher.so
	gcc -m32 decode.o -L. -lcypher -o decode


.PHONY: clean run
clean:
	rm -f decode

run: decode
	LD_LIBRARY_PATH=. ./decode