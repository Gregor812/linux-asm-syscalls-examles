all: args

args: args.o ../hello/stdlib.o
	ld -nostdlib -o $@ $^

%.o: %.s
	as -o $@ $<

.PHONY: clean

clean:
	rm args args.o
