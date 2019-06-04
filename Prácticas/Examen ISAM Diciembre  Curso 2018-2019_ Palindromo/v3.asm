	.data
	cadena: .space 256
	mensaje: .asciiz "Introduzca la cadena:"
	mensajees: .asciiz "La cadena es palindroma"
	mensajenoes: .asciiz "La cadena NO es palindroma"
	.text
	
	li $a0,256
	la $a1,cadena
	jal leer_cadena
	
	
	la $a0,cadena
	jal es_palindromo
	beqz $v0,msgNO
	
	la $a0,mensajees
	li $v0,4
	syscall
	b fin_main
	
	
msgNO: 
	la $a0, mensajenoes
	li $v0,4
	syscall

	#nop	#<--- Introduzco un punto de ruptura para ver que funciona
		
fin_main:
	li $v0,10
	syscall
	
leer_cadena: 
	#a0 <- max
	#a1 <- dir de memoria de cadena
	
	#Creo pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	
	#Guardo mis 2 valores a0 y a1
	sw $a0,0($fp)
	sw $a1,-4($fp)
	
	la $a0,mensaje
	li $v0,4
	syscall
	
	#Recupero mis valores en otro orden para lectura
	lw $a0,-4($fp)
	lw $a1, 0($fp)
	li $v0,8
	syscall
	
	lw $a0,0($fp)
	lw $a1,-4($fp)
	
fin_leer_cadena:
	#Destruyo pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	jr $ra
				
es_palindromo:
	#a0 <- Zona de memoria de la cadena de caract
	#v0 	-> 1 Si es palindromo
	#	-> 0 Si no lo es
	
	#Creamos pila
	
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	
	sw $a0,0($fp)	#voy a llamar a una subturina por tanto guardo en la pila
	jal puntero_al_final
	lw $a0,0($fp)	#recupero el valor 
	move $t0,$v0 #t0 <- final de la cadena
	li $v0,1 # <- Es palindromo, es decir guardo en t0 lo que me interesaba y ahora pongo la nueva salida
	
bucle_es_palindromo:
	#1º Condicion de salida
	bge $a0,$t0,fin_es_palindromo

	lb $t1,0($a0) #t1 elemento primero
	lb $t2,0($t0) #t2 elemento del final
	beq $t1,$t2, iguales
	#No son iguales
	move $v0, $zero #no son palindromos
	b fin_es_palindromo	

iguales:
	addiu $a0,$a0,1 #avanzo el puntero del principio
	subiu $t0,$t0,1	#retrocedo el puntero del final
	b bucle_es_palindromo

fin_es_palindromo:
	#Borramos pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addiu $sp,$sp,32
	jr $ra
				
	
puntero_al_final: 
	#a0 <- Direccion de la cadena
	#v0 -> Direccion final de la cadena
	
	#Creamos la pila
	subi $sp,$sp,32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addiu $fp,$sp,28
	move $v0,$zero 

bucle_puntero:

	lb $t0,0($a0)
	beqz $t0, fin_bucle_puntero #Salgo cuando es \0
	li $t1,'\n'
	beq $t0,$t1,fin_bucle_puntero #Salgo cuando es \n
	move $v0, $a0 #Guardas la direccion de memoria de la cadena en v0
	addiu $a0,$a0,1 #Incrementas el valor de a0
	b bucle_puntero
	
fin_bucle_puntero:	

	#Destruimos la pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addiu $sp,$sp,32
	jr $ra
	
	
