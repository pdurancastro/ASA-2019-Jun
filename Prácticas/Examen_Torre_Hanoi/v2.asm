	.data
	move_disk: .asciiz "Move disk "
	from_peg: .asciiz " from_peg "
	to_peg: .asciiz " to_peg "
	salto: .asciiz "\n"
	num_discos: .asciiz "Introduce el número de discos (1-8)> "
	
	
	
	.text
	
	la $a0,num_discos
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $a0,$v0	#Numero de discos
	li $a1,1	#Sitio de comienzo
	li $a2,2	#Sitio en el que se termina
	li $a3,3	#Torre para realizar cambios
	
	jal hanoi
	
	li $v0,10
	syscall
	
hanoi:
	#a0<-n
	#a1<-start
	#a2<-finish
	#a3<-extra
	
	#Creo pila
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	#if(n != 0)
	beqz $a0,fin_hanoi
	
	#hanoi(n-1, start, extra, finish);
		#-> Guardo en la pila los valores puesto que modificare a0,a2,a3
	sw $a0,0($fp)
	sw $a1,-4($fp)
	sw $a2,-8($fp)
	sw $a3,-12($fp)
	
	subi $a0,$a0,1
	move $a1,$a1 #No es necesario pero asi no hay lios
	lw $a2,-12($fp)
	lw $a3,-8($fp)
	
	jal hanoi
	
	lw $a0,0($fp)
	lw $a1,-4($fp)
	lw $a2,-8($fp)
	lw $a3,-12($fp)
	
	#print_string(“Move disk”)

	#Guardo el valor de a0
	sw $a0,0($fp)
	
	la $a0,move_disk
	li $v0,4
	syscall
	
	#Recupero el valor de a0
	lw $a0,0($fp)
	
	#print_int(n)
	move $a0,$a0 #No hace falta
	li $v0,1
	syscall
	
	#print_string(“from peg”);
	
	#Guardo el valor de a0
	sw $a0,0($fp)
	la $a0,from_peg
	li $v0,4
	syscall
	
	#Recupero el valor de a0
	lw $a0,0($fp)
	
	#Guardo el valor de a0
	sw $a0,0($fp)
	#print_int(start);
	move $a0,$a1
	li $v0,1
	syscall
	
	#Recupero el valor de a0
	lw $a0,0($fp)
	
	#print_string(“to peg”);
	
	#Guardo el valor de a0
	sw $a0,0($fp)
	
	la $a0,to_peg
	li $v0,4
	syscall
	
	#Recupero el valor de a0
	lw $a0,0($fp)
	
	sw $a0,0($fp)
	
	#print_int(finish)
	move $a0,$a2
	li $v0,1
	syscall
	
	#Recupero el valor de a0
	lw $a0,0($fp)
	
	#print_string(“.\n”);
	sw $a0,0($fp)
	
	la $a0,salto
	li $v0,4
	syscall
	
	#Recupero el valor de a0
	lw $a0,0($fp)
	
	#hanoi(n-1, extra, finish, start)
	
	sw $a0,0($fp)
	sw $a1,-4($fp)
	sw $a2,-8($fp)
	sw $a3,-12($fp)
	
	subi $a0,$a0,1
	move $a1,$a3
	move $a2,$a2
	lw $a3,-4($fp)
	
	jal hanoi
	
	lw $a0,0($fp)
	lw $a1,-4($fp)
	lw $a2,-8($fp)
	lw $a3,-12($fp)
	

fin_hanoi:
	#Destruyo Pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addi $sp,$sp,32
	jr $ra
	