	.data
	cadena: .asciiz "Introduzca el número: "
	cadena2: .asciiz "El resultado es: "
	
	.text
	
	la $a0, cadena #a0 <-direccion de la cadena
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 #s0 <- Tengo el Primer numero
	
	la $a0, cadena #a0 <-direccion de la cadena
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0 #s1 <- Tengo el Segundo numero
	
	addu $s2, $s0, $s1 # <-  $s0 + $s1
	
	la $a0,cadena2 #a0 <- direccion de la cadena
	li $v0, 4
	syscall
	
	move $a0,$s2 # Mostrar por pantalla el resultado
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	