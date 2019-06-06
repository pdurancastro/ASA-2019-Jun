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
	
	
	
	
	move $a0,$s0
	li $a1,7
	jal insert_in_order
	
	beqz $v0, fin_programa
	
	move $s0,$v0	#--Apunto al primer nodo
	
fin_programa: 	
	li $v0,10
	syscall
	

insert_in_order:

	#a0 <- Primer nodo de la lista
	#a1 <- Valor del nodo añadir
	#v0 -> NULL si no se actualiza el primero, la direccion si se actualiza el primero
	
	
	#Creo Pila
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	#Caso de insertar por el principio
	li $v0,0 		#Inicializo v0 NULL direccion del nodo creado
	lw $t0,0($a0)		#El primer elemento de a0
	blt $t0,$a1,principio	#Si el primer elemento del valor que me pasan es menor que a1, inserto por el principio
	
	#Resto de casos (insertar medio y final)
bucle_insert:
	lw $t0,4($a0)		#Puntero al siguiente valor
	beqz $t0,insertar_final
	lw $a0,4($a0)		#Avanzo la lista
	b bucle_insert

insertar_final:
	#enlazar con el final
	
	sw $a0,0($fp)
	sw $a1,-4($fp)
	
	lw $a0,-4($fp)
	move $a1,$t0	#El siguiente nodo creado es el siguiente

	jal node_t_create
	
	lw $a0,0($fp)
	lw $a1,-4($fp)
	
	move $v0,$zero	
	
	sw $v0,4($a0)
	move $v0,$zero
	
	b fin_insert
	
principio:
	sw $a0,0($fp)
	sw $a1,-4($fp)
	
	#Los parametros de entrada son al reves en crear nodo
	lw $a0,-4($fp)
	lw $a1,0($fp)
	
	jal node_t_create
	#v0 -> Devuelve el nuevo principio
	b fin_insert
	
fin_insert:
	#Destruyo Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addi $sp,$sp,32
	
	jr $ra	
	
	
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
