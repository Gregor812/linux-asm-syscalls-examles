.file "stdlib.s"

.section .text

.macro SaveRegisters
	push %rbx
	push %rbp
	push %r12
	push %r13
	push %r14
	push %r15
.endm

.macro RestoreRegisters
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	pop %rbp
	pop %rbx
.endm

.macro Write fileDescriptor bufferPointer length
	mov $1, %rax
	mov \fileDescriptor, %rdi
	mov \bufferPointer, %rsi
	mov \length, %rdx
	syscall
.endm

.macro Exit exitCode
	mov $60, %rax
	mov \exitCode, %rdi
	syscall
.endm

# GetStringLength(char* string)

# rdi -- pointer to the start of string
# r12 -- string symbol index
# rax -- return value

GetStringLength:
	SaveRegisters

	mov $0, %r12 # index = 0

	loop:
		# r13b = string[index]
		mov (%rdi, %r12, 1), %r13b
		# if (r13b == 0) goto return
		cmp $0, %r13b
		je return

		inc %r12 # ++index
		jmp loop
	
	return:
		mov %r12, %rax
		RestoreRegisters
		ret

.type GetStringLength, @function
.global GetStringLength

# PutString(int fileDescriptor, char* string)

# rdi -- fileDescriptor
# rsi -- string

PutString:
	SaveRegisters

	mov %rdi, %r12 # r12 = fileDescriptor
	mov %rsi, %r13 # r13 = string
	
	mov %r13, %rdi
	call GetStringLength

	mov %rax, %r14 # r14 = stingLength

	Write %r12 %r13 %r14
	RestoreRegisters
	ret

.type PutString, @function
.global PutString

TerminateProcess:
	Exit %rdi
	ret

.type TerminateProcess, @function
.global TerminateProcess

