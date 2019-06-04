	.data
	mensaje1: .asciiz "Introduzca el numero de elementos del array: "
	mensaje2: .asciiz "Introduzca numero: "
	
	.text
	
	la $a0,mensaje1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	#v0 <- numero de elementos
	move $s0,$v0 #s0 <- Numero de elementos
	move $a0,$s0
	
	jal crear_array
	
	move $s1,$v0 #s1<-Guardas el principio
	
	move $a0,$s1 #Le paso la direccion de memoria del array
	move $a1,$s0 #Le paso el numero de elementos
	
	jal inicializar_array
	

	li $v0,10
	syscall
	
	
inicializar_array:
	#a0 <- array
	#a1 <- Numero de Elementos
	
	#Crear pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	
	#Necesito un 0 para poder comparar en el bucle
	move $t0,$zero

bucle_inicializar:
	bge $t0,$a1,fin_inicializar_array
	
	#Guardo a0,a1 puesto que voy a llamar a syscall
	sw $a0,0($fp)
	#sw $a1,-4($fp)
	
	la $a0,mensaje2
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	#v0 <- numero leido
	
	#Recupero mis elementos
	lw $a0,0($fp)
	#lw $a1,-4($fp)
	
	sw $v0,0($a0) #Guardo el primer elemento leido del array 
	addiu $a0,$a0,4 #avanzo al siguiente en el array
	addiu $t0,$t0,1 #i++
	b bucle_inicializar

fin_inicializar_array:

	#Borrar pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addiu $sp,$sp,32
	jr $ra

crear_array:

	#a0 <- numero maximo de elementos
	#v0 -> Direccion de memoria

	#Creo Pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	
	sw $a0,0($fp)
	
	mul $a0,$a0,4
	li $v0,9	#Reservar en el monton
	syscall
	
	lw $a0,0($fp)	
	
	#Destruyo pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	jr $ra
	

	
