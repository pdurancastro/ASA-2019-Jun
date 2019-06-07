	.data
		mensaje1: .asciiz "Introduce el valor (Salida 0): "
		mensaje2: .asciiz "Introduce el parámetro a borrar: "
	.text
	
	move $s0,$zero #inicializamos a 0 cima de la pila
	
bucle_valor:
	la $a0,mensaje1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	beqz $v0,salir_programa
	
	move $a0,$s0
	move $a1,$v0
	
	jal node_push
	move $s0,$v0	#Actualizo el push

	b bucle_valor

salir_programa:

	la $a0,mensaje2
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $a0,$s0
	move $a1,$v0
	jal node_remove
							
	li $v0,10
	syscall
	
node_remove:
	#a0<-node top
	#a1<-nodo a borrar
	#v0->direccion de memoria del nodo borrado

	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
bucle_remove:
	
	lw $t0,4($a0)
	beqz $t0,fin_bucle_remove
	
	lw $t1,0($t0)
	bne $t1,$a1,avanzar
	
	lw $t2,4($t0)
	sw $t2,4($a0)
	
	move $v0,$t0
avanzar:
	lw $a0,4($a0)
	b bucle_remove
	
	
fin_bucle_remove:	
	
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	jr $ra
	
	
node_push:
	#a0<-direccion del nodo del top
	#a1<-valor del top
	#v0->Direccion del nuevo nodo creado
	
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	sw $a0,0($fp)
	
	li $a0,8
	li $v0,9
	syscall
	
	lw $a0,0($fp)
	
	#Guardas a1 y a0
	sw $a1,0($v0)
	sw $a0,4($v0)
	
	
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	jr $ra
	
	

	
	
	
	
