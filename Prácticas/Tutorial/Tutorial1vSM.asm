	.data
	a: .word 4 
	b: .word 5
	c: .space 4
	.text
	
	lw $t0,a
	lw $t1,b
	addu $t2,$t0,$t1
	sw $t2,c
	
	li $v0, 10
	syscall
	