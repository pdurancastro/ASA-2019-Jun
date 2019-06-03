	.data
	cadena: .asciiz "hola que tal\n"
	
	.text
	
	la $a0,cadena
	
	jal puntero_al_final
	
	nop
	
	li $v0,10
	syscall 
	
puntero_al_final:
	
	#a0 <- Cadena de Caracteres en memoria
	#v0 -> Direccion de memoria del ultimo caracter
	
	#Creo la pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	move $v0, $zero
	
bucle_puntero:
	lb $t0,0($a0)
	beqz $t0,fin_bucle_puntero
	li $t1,'\n'
	beq $t0,$t1,fin_bucle_puntero
	move $v0,$a0
	addiu $a0,$a0,1	
	b bucle_puntero
	
fin_bucle_puntero:
	
	#Borro la pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	jr $ra
	