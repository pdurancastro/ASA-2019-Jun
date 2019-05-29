	.data
	cadena: .asciiz "Introduzca el numero: "
	cadena2: .asciiz "El resultado es: "
	
	.text
	
	la $a0, cadena
	li $v0, 4 
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	la $a0, cadena
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	addu $s2, $s1, $s0 
	
	la $a0, cadena2
	li $v0, 4
	syscall
	
	move $a0, $s2
	li $v0, 1
	syscall
	
	
	