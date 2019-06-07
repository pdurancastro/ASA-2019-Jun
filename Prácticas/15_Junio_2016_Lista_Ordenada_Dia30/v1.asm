	.data
	
	
	.text
	
	move $s0,$zero	#inicio
	move $s1,$zero	#fin
	
	# Insertas el primer nodo
	move $a0,$s1
	li $a1,1
	jal insert_node
	#Apuntas al mismo sitio inicio y fin
	move $s0,$v0
	move $s1,$v0
	
	#Creo nodo 2
	move $a0,$s1
	li $a1,2
	jal insert_node
	move $s1,$v0
	
	#Creo nodo 3
	move $a0,$s1
	li $a1,3
	jal insert_node
	move $s1,$v0
	
	
	#Borrar nodo 2
	move $a0,$s0
	li $a1,3
	jal remove_node
	
	
	li $v0,10
	syscall
	


insert_node:

	#a0<-direccion del ultimo nodo de la lista
	#a1<- valor a añadir
	#v0-> Direccion del nuevo nodo creado
	
	#Crear Pila
	sub $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	
	sw $a0,0($fp)
	
	li $a0,8
	li $v0,9
	syscall
	
	lw $a0,0($fp)
	
	#v0-> devuelve la direccion de memoria
	sw $a0,0($v0)
	sw $a1,4($v0)
	
	beqz $a0,fin_insert	#la lista está vacia
	
	sw $v0,4($a0)
	
fin_insert:
	
	#Borrar Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
	jr $ra
	
	
	
