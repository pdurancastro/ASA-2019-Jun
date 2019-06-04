	.data
	mensaje: .asciiz "Introduzca el numero de elementos del array: "
	
	.text
	
	la $a0, mensaje
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	#v0 <- numero de elementos
	move $a0,$v0
	
	jal crear_array
	
	move $s0,$v0 #<- Guardo el principio

	li $v0,10
	syscall


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
	li $v0,9
	syscall
	
	lw $a0,0($fp)	
	
	#Destruyo pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	jr $ra
	
#ESTA VERSION SOLO PERMITE VER QUE ESTOY TRABAJANDO EN EL HEAP Y COMO SE RESERVA LA MEMORIA NO TE RAYES SI VES QUE NO HACE MAS
	