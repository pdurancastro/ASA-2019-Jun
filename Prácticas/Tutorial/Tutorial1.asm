	.data
	
	a: .word 5 # reservo para a una palabra y la inicializo a 5
	b: .word 4 # reservo para b una palabra y la inicializo a 4
	c: .space 4 #reservo para c una palabra de (4 bytes) pero no la inicializo
	.text
	
	lw $t0, a # t0 <- a
	lw $t1, b # t1 <- b
	addu $t2, $t1, $t0 #t2 <- a + b
	sw $t2,c
	
	li $v0, 10
	syscall
	