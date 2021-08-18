decode: decode.o libcypher.so
	gcc -m32 decode.o -L. -lcypher -o decode


.PHONY: clean
clean:
	rm -f decode