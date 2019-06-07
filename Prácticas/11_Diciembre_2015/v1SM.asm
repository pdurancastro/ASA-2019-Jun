	.data
		mensaje1: .asciiz "Introduce el valor (0 Salir): "
		mensaje2: .asciiz "Introduce el numero a borrar: "
	.text

	move $s0,$zero #Inicializo s0 al comienzo de la cadena
	
bucle:
	la $a0,mensaje1
	li $v0,4
	syscall
	
	la $v0,5
	syscall
	#v0 -> direccion memoria del valor
	
	beqz $v0,fin_bucle
	
	move $a0,$s0
	move $a1,$v0
	
	jal node_push
	#v0 -> direccion del nodo creado
	move $s0,$v0
	
	b bucle
	
fin_bucle:

	la $a0,mensaje2
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	#v0 ->direccion de memoria del nodo
	
	move $a0,$s0
	move $a1,$v0
	
	jal node_remove
	#v0 ->direccion del nodo borrado

	li $v0,10
	syscall

node_remove:
	#a0 <- Direccion del top
	#a1 <- Valor del nodo a borrar
	
	#crear pila
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	lw $t0,4($a0) 	#Siguiente
	
	beqz $t0,fin_remove
	
	lw $t1,0($t0)
	bne $a1,$t1,avanzo
	
	lw $t2,4($t0)
	sw $t2,4($a0)
	
	move $v0,$t0
	
avanzo:
	lw $a0,4($a0)
	b node_remove
	
	
fin_remove:	
	#borrar pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addi $sp,$sp,32
	jr $ra
	
	
	
node_push:
	#a0 <- Direccion del nodo en la cima de la pila
	#a1 <- Valor del nodo
	#v0 -> Direccion del nuevo nodo creado
	
	#crear pila
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	#Guardp en la pila a0
	sw $a0,0($fp)
	
	#Llamo al monton para almacenar los valores
	
	li $a0,8
	li $v0,9
	syscall
	#v0 --->direccion del monton
	lw $a0,0($fp)

	sw $a1,0($v0)
	sw $a0,4($v0)
	
	#borrar pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addi $sp,$sp,32
	jr $ra
	
	
	
	