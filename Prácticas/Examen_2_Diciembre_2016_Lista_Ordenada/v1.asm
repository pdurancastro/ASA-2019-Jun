	.data
	.text
	
	move $s0,$zero #<-- Principio
	
	# Crear el primer nodo
		#a0 <-valor
		li $a0,2
		#a1 <-puntero al siguiente nodo, empieza a null
		move $a1,$zero
	
	jal node_t_create
	
	move $s0,$v0	#--Apunto al primer nodo
	
	
	li $v0,10
	syscall
	
node_t_create:
	
	#a0 <- Valor
	#a1 <- Direccion del nodo siguiente
	#v0 -> Direccion del nuevo nodo
	
	
	#Creo Pila
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	#Almaceno a0
	sw $a0,0($fp)
	
	#Guardar valores en el heap
	#En a0 necesito el tamaño
	li $a0,8
	li $v0,9
	syscall
	
	#v0-> Contiene la direccion del nodo en el que está alojado
	
	#Recupero a0
	lw $a0,0($fp)
	
	sw $a0,0($v0)
	sw $a1,4($v0)
	
	#Destruyo Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addi $sp,$sp,32
	
	jr $ra
