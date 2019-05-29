	.data
	cadena: .asciiz "Holi"
	longitud: .asciiz "La longitud es: "
	.text
	
	la $s0, cadena
	li $s1, 0
	
bucle: 
	lb $t1, 0($s0)
	beqz $t1, fin_bucle
	addiu $s1, $s1, 1
	addiu $s0, $s0, 1
	b bucle
	
fin_bucle:
	 la $a0, longitud
	 li $v0, 4
	 syscall
	 
	 move $a0, $s1
	 li $v0, 1
	 syscall 
	 
	 li $v0, 10
	 syscall