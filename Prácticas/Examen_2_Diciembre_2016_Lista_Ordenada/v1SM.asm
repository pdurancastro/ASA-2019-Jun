	.data 
	
	.text
	
	#Primer nodo
	li $a0,2
	move $a1,$zero
	
	jal node_t_create
	
	move $s0,$v0
	
	li $v0,10
	syscall
	
node_t_create:

	#a0<-valor
	#a1<-direccion siguiente
	#v0->Salida direccion del nuevo nodo
	
	sub $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	sw $a0,0($fp)
	
	li $t0,8
	move $a0,$t0
	
	li $v0,9
	syscall
	
	lw $a0,0($fp)
	
	sw $a0,0($v0)
	sw $a1,4($v0)
	
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $sp,$sp,32
	jr $ra
	