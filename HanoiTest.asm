.data
.word 
.text

main:

addi $t8,$zero,1 	#Set register to 1 for future beq
lui $1,0x00001001
ori $1,$1,0x00000000
add $a0,$0,$1 		#pointer to  tower A

lui $1,0x00001001
ori $1,$1,0x00000020
add $a1,$0,$1		 #pointer to  tower B

lui $1,0x00001001
ori $1,$1,0x00000040
add $a2,$0,$1 		#pointer to  tower C

add $t1,$zero,$a1 	#AUX
add $t2,$zero,$a2 	#FIN

addi $s0,$zero,4	#number of disks N
add $s1,$zero,$s0 	#i

for:		 	# "for" to store all disks in tower A
beq $s1,$zero,recursive	# jumps to the first call of the hanoi function once all the disks are in tower A
sw $s1,0($a0)		#store disk in tower A
addi $a0,$a0,4		#update last position of tower A
sub $s1,$s1,1		# update i
add $t0,$zero,$a0 	#COM 
j for

recursive:
jal hanoi		#HANOI (N,COM,AUX,FIN) FIRST call to hanoi function
j exit

hanoi:
bne $s0,$t8,else	#If(n==1)
addi $t0, $t0, -4	#moves one byte to the bottom of the origin tower
lw $t3,0($t0)   	#get disk from tower COM
sw $zero,0($t0) 	#remove disk from tower COM
sw $t3,0($t2)  	 	#place disk  to tower FIN
addi $t2,$t2,4 		#update last position of tower
jr $ra
else:
#parte stack pointer
addi $sp,$sp,-8 	#save 2 bytes of memory to store data
sw $ra,4($sp)   	#store the returning direction in stack
sw $s0,0($sp)   	#store actual N in stack

# swap between aux and fin
swap:
add $t7,$zero,$t2  	#temporal = OLD FIN
add $t2,$zero,$t1  	#SWAP NEW FIN = OLD AUX
add $t1,$zero,$t7  	#SWAP NEW AUX= OLD FIN
bne  $a3, $zero, recover  	#if the auxiliar flag != 0, jump to the label recover, else continue

# After swap
sub $s0,$s0,1		#n=n-1;
jal hanoi 
addi $a3, $zero, 1		#axuiliar flag = 1
j   swap			#jump to the label switch
 		
recover: 			#aqui tenemos que mover el stack para arriba y agarrar los datos
add  $a3, $zero, $zero		#limpiamos  la bandera
lw   $s0, 0($sp)		#load n from the top of the stack	
lw   $ra, 4($sp)		#load ra direction from the stack	
addi $sp, $sp, 8		#add 8 to the stack pointer

addi $t0, $t0, -4	#moves one byte to the bottom of the origin tower
lw $t3,0($t0)   	#get disk from tower COM
sw $zero,0($t0) 	#remove disk from tower COM
sw $t3,0($t2)   	#place disk  to tower FIN
addi $t2,$t2,4 		#update last position of tower

addi $sp,$sp,-8 	#save 2 bytes of memory to store data
sw $ra,4($sp)   	#store the returning direction in stack
sw $s0,0($sp)   	#store actual N in stack

#SWAP
add $t7,$zero,$t0  #temporal = OLD COM
add $t0,$zero,$t1  #SWAP NEW COM = OLD AUX
add $t1,$zero,$t7  #SWAP NEW AUX= OLD COM
sub $s0,$s0,1	#n=n-1;

jal hanoi
#aqui otra vez hacemos lo del stack, y pasamos del hijo derecho del primer hanoi(2) al print del hanoi(3)
lw   $s0, 0($sp)		#load n from the top of the stack	
lw   $ra, 4($sp)		#load ra direction from the stack	
addi $sp, $sp, 8		#add 8 to the stack pointer

# hacer switch
add $t7,$zero,$t0  #temporal = OLD COM
add $t0,$zero,$t1  #SWAP NEW COM = OLD AUX
add $t1,$zero,$t7  #SWAP NEW AUX= OLD COM
#hacer switch
#add $t7,$zero,$t2  #temporal = OLD FIN
#add $t2,$zero,$t1  #SWAP NEW FIN = OLD AUX
#add $t1,$zero,$t7  #SWAP NEW AUX= OLD FIN

#mover disco (PRINT)
#addi $t0, $t0, -4	#moves one byte to the bottom of the origin tower
#lw $t3,0($t0)   #get disk from tower COM
#sw $zero,0($t0) #remove disk from tower COM
#sw $t3,0($t2)   #place disk  to tower FIN
#addi $t0,$t0,4 #update last position of tower

jr $ra

j exit

exit:
