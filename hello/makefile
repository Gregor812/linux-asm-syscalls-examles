all: hello

hello: hello.o stdlib.o
	gcc -o $@ $^

%.o: %.s
	as -o $@ $<

%.o: %.c
	gcc -Wno-implicit-function-declaration -c -o $@ $<

.PHONY: clean

clean:
	rm hello hello.o
