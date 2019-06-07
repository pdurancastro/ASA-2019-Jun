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
	
remove_node: 
	#a0 <- direccion primer nodo
	#a1 <- valor a borrar
	#v0 -> dir nodo borrado o NULL si no esta
	
	#Crear Pila
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	li $v0,0
	beqz $a0,fin_remove
	
bucle_remove:
	lw $t0,4($a0) 		#Cargo en t0 el valor del siguiente 
	beqz $t0,fin_remove	#Si el siguiente es un 0 sales
	lw $t1,0($t0)		#t1<-siguiente
if1:	
	bne $a1,$t1,endif1
	lw $t2,4($t0)		#t2 <-- guardo el siguiente del siguiente
	sw $t2,4($t0)
	move $v0,$t0		#v0 <-- nodo borrado
	b fin_remove
	
endif1:
	lw $a0,4($a0)
	b bucle_remove

	
fin_remove:	
	#borrar pila
	sw $ra,0($sp)
	sw $fp,4($sp)
	addi $sp,$sp,32
	jr $ra


insert_node:

	#a0<-direccion del ultimo nodo de la lista
	#a1<- valor a añadir
	#v0-> Direccion del nuevo nodo creado
	
	#Crear Pila
	sub $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	#Guardas el va,or de a0
	sw $a0,0($fp)
	
	li $a0,8
	li $v0,9
	syscall
	#v0-> devuelve la direccion de memoria del monton
	
	#Recuperas a0
	lw $a0,0($fp)
	
	sw $a1,0($v0)
	sw $zero,4($v0)
	
	beqz $a0,fin_insert	#la lista está vacia
	
	sw $v0,4($a0)
	
	#Inserta por el final
	#########
	#   1	#
	#########
	#   2	#
	#########
	
fin_insert:
	
	#Borrar Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
	jr $ra
	
	
	
