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
	move $s0,$s1	#Se hace en el primer caso para no tener a null 
	
novacia:
	b bucle_main
	
fin_bucle_main:

	la $a0,mensaje2
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	#v0 <- valor a borrar 
	
	move $a0,$s0
	move $a1,$v0

	jal remove_node

	li $v0,10
	syscall
	
remove_node:
	#a0 <- Primer nodo 
	#a1 <- Valor a borrar
	#v0 -> Puntero al nodo borrado
	
	#Crear Pila
	sub $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	li $v0,0
	
	beqz $a0,fin_remove_node

bucle_remove:
	lw $t0,4($a0)	#t0<- apunta al siguiente
	beqz $t0,fin_remove_node
	lw $t1,0($t0)	#Cargas el valor del elemento siguiente en una variable	
if:	
	bne $t1,$a1,avanzo
	lw $t2,4($t0)
	sw $t2,4($a0)
	move $v0,$t0	#v0<- Direccion del nodo borrado
	b fin_remove_node
		
avanzo:
	lw $a0,4($a0)
	b bucle_remove 	
	
fin_remove_node:	
	#Borrar Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
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

	
fin_insert:
	
	#Borrar Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
	jr $ra
	
	
