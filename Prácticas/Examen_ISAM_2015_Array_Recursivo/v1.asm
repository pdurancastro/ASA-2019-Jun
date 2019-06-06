
	.data
	
	array: .word 1,2,3,4,5
	.text
	
	la $a0, array
	li $a1, 3
	li $a2, 0
	li $a3, 5
	
	jal buscar_desde
	#v0 -> devuelve la posicion del elemento 3
	
	move $a0,$v0	#posicion
	addiu $a1,$v0,1 #posicion +1
	la $a2, array
	jal intercambiar
	
	
	li $v0, 10
	syscall
	
	
intercambiar:
	#a0 -> i
	#a1 -> j
	#a2 ->array
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	mul $t0,$a0,4		#--> i*4
	addu $t1,$t0,$a2	#--> direccion array[i]
	lw $t2,0($t1)		#--> Valor del array[i]
	
	mul $t3,$a1,4 		#--> j*4
	addu $t4,$t3,$a2	#--> direccion array[j]
	lw $t5,0($t4)		#--> Valor del array[j]
	
	sw $t2,0($t4)		#--> Valor del array[i] = direccion array[j]
	sw $t5,0($t1)		#--> Valor del array[j] = direccion array[i]
		
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
	jr $ra
	
	

buscar_desde:
	#a0<- array
	#a1<- valor
	#a2<- posicion
	#a3<- NumElementos
	#v0 -> depende de las condiciones
	
	#Crear pila
	
	subi $sp,$sp,32
	sw $ra,0($sp)
	sw $fp,4($sp)
	addiu $fp,$sp,28
	
	blt $a2,$a3,salto_1 #Salto si no se cumple
	#Se cumple el if
	li $v0,-1
	
	b fin_buscar_desde
	
salto_1: 
	#inicializar el puntero para sacar cadena[pos]
	mul $t0,$a2,4 		#t0 <-Direccion relativa desde el principio [pos]
	addu $t0,$t0,$a0 	# <-Direccion cadena[pos] 
	lw $t1,0($t0) 		# <-cadena[pos]
	
	bne $t1,$a1,salto_2
	
	move $v0,$a2		#v0 -> devuelve la pos del elemento a buscar
	b fin_buscar_desde
	
salto_2:
	sw $a0,0($fp)
	sw $a1,-4($fp)
	sw $a2,-8($fp)
	sw $a3,-12($fp)
	sw $t0,-16($fp)
	
	addiu $a2,$a2,1
	jal buscar_desde
	
	lw $a0,0($fp)
	lw $a1,-4($fp)
	lw $a2,-8($fp)
	lw $a3,-12($fp)
	lw $t0,-16($fp)
	
	
fin_buscar_desde:	
	#Borrar pila
	lw $ra,0($sp)
	lw $fp,4($sp)
	addiu $sp,$sp,32
	
	jr $ra
