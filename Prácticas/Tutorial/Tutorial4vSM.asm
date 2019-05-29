	.data
	cadena: .space 256
	mensaje1: .asciiz "Introduce la palabra: "
	mensaje2: .asciiz "La longitud es: "
	
	.text
	
	la $a0, mensaje1
	li $v0, 4
	syscall
	
	la $a0, cadena
	li $a1, 256
	li $v0, 8
	syscall
	
	move $s0, $a0	#<-- Direccion de memoria de la cadena
	li $s1, 0	#<-- Longitud de la cadena
	
	
bucle:
	lb $t0, 0($s0)
	beqz $t0, fin_bucle
	li $t1, '\n'
	beq $t0, $t1, fin_bucle
	addiu $s1, $s1, 1
	addiu $s0, $s0, 1
	
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
