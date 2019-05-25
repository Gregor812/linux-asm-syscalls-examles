all: true

true: true.o 
	ld -nostdlib -o $@ $^

%.o: %.s
	as -o $@ $<

.PHONY: clean

clean:
	rm true true.o

