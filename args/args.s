.section .rodata

Prefix:
	.ascii "Hello \0"

Suffix:
	.ascii "!\n\0"

.section .text

_start:
	# first value from stack is argc
	pop %r12 # r12 = argc

	# second value from stack is process name
	# skip it
	pop %r13 # r13 = argv[0]
	dec %r12

	# pop first arg pointer
	pop %r13 #r13 = argv[1]

	Loop:
		cmp $0, %r12
		je Exit

		mov $1, %rdi
		mov $Prefix, %rsi
		call PutString
	
		mov $1, %rdi
		mov %r13, %rsi
		call PutString

		mov $1, %rdi
		mov $Suffix, %rsi
		call PutString

		dec %r12
		pop %r13
		jmp Loop
	Exit:
		mov $0, %rdi
		call TerminateProcess

.global _start

