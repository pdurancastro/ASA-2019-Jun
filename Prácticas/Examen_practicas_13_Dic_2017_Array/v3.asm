	.data
	mensaje1: .asciiz "Introduzca el numero de elementos del array: "
	mensaje2: .asciiz "Introduzca numero: "
	mensaje3: .asciiz "Introduzca numero a borrar: "
	
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
	
	la $a0,mensaje3
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $a0,$s1
	move $a1,$v0
	move $a2,$zero
	move $a3,$s0
	jal borrar_contenido
	move $s2,$v0
	
	li $v0,10
	syscall
	
	
	
borrar_contenido:
	#a0 <- array
	#a1 <- valor
	#a2 <- pos
	#a3 <- elementos
	
	#Crear pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	
	blt $a2,$a3,salto1 #Lo hacemos al reves es decir si no cumple salgo sino salto

	li $v0,-1
	b fin_borrar	
		
salto1:
	mul $t0,$a2,4 #<- Direccion relativa al principio
	addu $t0,$t0,$a0 #<- Direccion cadena[pos]
	lw $t1,0($t0) # cadena[pos]
	bne $t1,$a1,salto2 #no se cumple el segundo if
	#Si se cumple el if
	sw $zero,0($t0)
	move $v0,$a2
	b fin_borrar
	
salto2:
	#Devuelve borrar contenido el cual solo tiene cambiado pos = pos + 1
	sw $a2,0($fp)
	addiu $a2,$a2,1
	jal borrar_contenido
	lw $a2,0($fp)

fin_borrar:
	#Destruir pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addiu $sp,$sp,32
	jr $ra	
	
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
	

	
