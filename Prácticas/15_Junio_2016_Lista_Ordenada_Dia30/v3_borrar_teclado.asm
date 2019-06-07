	.data
	mensaje1: .asciiz "Introduzca el valor (0 salir): "
	mensaje2: .asciiz "Introduzca el valor a eliminar: "
	
	.text
	
	move $s0,$zero	#inicio
	move $s1,$zero	#fin
	
bucle_main:

	la $a0,mensaje1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	#v0 <- valor leido
	
	beqz $v0,fin_bucle_main #Si introducen un 0 salgo
	
	move $a0,$s1	
	move $a1,$v0	#Valor leido	

	jal insert_node
	
	move $s1,$v0	#Actualizo el ultimo
	bnez $s0,novacia
	move $s0,$s1
	
novacia:
	b bucle_main
	
fin_bucle_main:

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
	
	
	
