	.data 
	cadena: .space 256
	mensaje1: .asciiz "Introduzca la cadena: "
	mensaje2: .asciiz "La longitud de la cadena es: "
	
	.text
	
	la $a0, mensaje1
	li $v0, 4
	syscall
	
	la $a0, cadena # <-- tipo space declaras la direccion de memoria
	li $a1, 256 # <-- valor requerido de espacio para el syscall
	li $v0, 8
	syscall
	
	la $s0, cadena #s0 <- direccion (cadena[i])
	li $s1, 0 #s1 <- longitud
	
bucle:	
	lb $t0, 0($s0) # <- Cadena[i]
	beqz $t0, fin_bucle
	li $t1, '\n' #t1 <- '\n'
	beq $t0, $t1, fin_bucle
	addiu $s1, $s1, 1	#longitud ++
	addiu $s0, $s0, 1	#siguiente posicion del string
	b bucle
	
fin_bucle:
	
	la $a0, mensaje2
	li $v0, 4
	syscall
	
	move $a0, $s1
	li $v0, 1
	syscall
	
	li $v0, 10 
	syscall
	

