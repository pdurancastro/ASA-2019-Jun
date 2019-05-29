	.data
	cadena: .asciiz "Hola que tal estas?"
	mensaje: .asciiz "La longitud es :  "
	 
	.text
	 
	la $s0, cadena #s0 <- dir(cadena)
	li $s1, 0	#s1 <- longitud = 0
	 
bucle:	 
	lb $t0,0($s0) #t0 <- cadena[i]
	beqz $t0, fin_bucle
	addiu $s1, $s1, 1 # longitud++
	addiu $s0, $s0, 1 # siguiente posicion del string
	b bucle
		 		
	
fin_bucle:
	la $a0, mensaje
	li $v0, 4
	syscall
	
	move $a0, $s1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall 
	
