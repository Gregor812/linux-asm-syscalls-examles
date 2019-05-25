.file "true.s"
.section .text

_start:
	# syscall(number=93/exit, arg0=0)
	mov $60, %rax
	mov $0, %rdi
	syscall
.global _start

