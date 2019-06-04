	.data
	cadena: .asciiz "hola que tal\n"
	
	.text
	
	la $a0,cadena
	jal puntero_al_final
	
	nop	#<--- Introduzco un punto de ruptura para ver que funciona
	
	li $v0,10
	syscall
	
	
puntero_al_final: 
	#a0 <- Direccion de la cadena
	#v0 -> Direccion final de la cadena
	
	#Creamos la pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	move $v0,$zero 

bucle_puntero:

	lb $t0,0($a0)
	beqz $t0, fin_bucle_puntero #Salgo cuando es \0
	li $t1,'\n'
	beq $t0,$t1,fin_bucle_puntero #Salgo cuando es \n
	move $v0, $a0 #Guardas la direccion de memoria de la cadena en v0
	addiu $a0,$a0,1 #Incrementas el valor de a0
	b bucle_puntero
	
fin_bucle_puntero:	

	#Destruimos la pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addiu $sp,$sp,32
	jr $ra
	
	