.data

.word 
.text

main:

addi $t8,$zero,1 #Set register to 1 for future beq
lui $1,0x00001001
ori $1,$1,0x00000000
add $a0,$0,$1 	#pointer to  tower A

lui $1,0x00001001
ori $1,$1,0x00000020
add $a1,$0,$1 #pointer to  tower B

lui $1,0x00001001
ori $1,$1,0x00000040
add $a2,$0,$1 #pointer to  tower C

add $t1,$zero,$a1 #AUX
add $t2,$zero,$a2 #FIN

addi $s0,$zero,4 #number of disks N
add $s1,$zero,$s0 #i

for:		 	# for to store all disks in tower A
beq $s1,$zero,hanoi	#HANOI (N,COM,AUX,FIN)
sw $s1,0($a0)		#store disk in tower
add $sp,$sp,-4		#decrease stack pointer
sw $s1,0($sp)		# save i in stack ponter (n's)
addi $a0,$a0,4
sub $s1,$s1,1
add $t0,$zero,$a0 	#COM
sub $t0,$t0,4 		#DECREASE COM 
j for

hanoi:
bne $s0,$t8,else	#If(n==1)
lw $t3,0($t0)   #get disk from tower COM
sw $zero,0($t0) #remove disk from tower COM
addi $t2,$t2,4  #increase position at destination tower
sw $t3,0($t2)   #place disk  to tower FIN
sub $t0,$t0,4 #update last position of tower


#add $sp,$sp,4 #increase stack pointer (n's)
#lw $s0,0($sp) #load in $s0 reference to stack pointer
jr $ra
else:
# swao between aux and fin
add $t7,$zero,$t2  #temporal = OLD FIN
add $t2,$zero,$t1  #SWAP NEW FIN = OLD AUX
add $t1,$zero,$t7  #SWAP NEW AUX= OLD FIN
sub $s0,$s0,1	#n=n-1;
# After swap-> t2: aux, t3:com, t1:fin
jal hanoi   #HANOI(N-1,COM,FIN,AUX)
#swap to get previous values of com,aux,fin
add $t7,$zero,$t2  #temporal = OLD FIN
add $t2,$zero,$t1  #SWAP NEW FIN = OLD AUX
add $t1,$zero,$t7  #SWAP NEW AUX= OLD FIN
#agregado JD  
lw $t3,0($t0)   #get disk from tower COM
sw $zero,0($t0) #remove disk from tower COM
addi $t2,$t2,4  #increase position at destination tower
sw $t3,0($t2)   #place disk  to tower FIN
sub $t0,$t0,4 #update last position of tower

addi $sp,$sp,4 #increase stack pointer (n's)
lw $s0,0($sp) #load in $s0 reference to stack pointer
#fin agregado JD
# Before swap-> t2: aux, t3:com, t1:fin
add $t7,$zero,$t0  #temporal = OLD COM
add $t0,$zero,$t1  #SWAP NEW COM = OLD AUX
add $t1,$zero,$t7  #SWAP NEW AUX= OLD COM



#agregado JD
sub $s0,$s0,1	#n=n-1;
#After swap -> t2: aux, t3:com, t1:fin
#Fin agregado JD

#lw $t3,0($t0)   #get disk from tower COM
#sw $zero,0($t0) #remove disk from tower COM
#sw $t3,0($t2)   #place disk  to tower FIN
#sub $t0,$t0,4 #update last position of tower
#add $t7,$zero,$t2  #temporal = OLD FIN
#add $t2,$zero,$t1  #SWAP NEW FIN = OLD AUX
#add $t1,$zero,$t7  #SWAP NEW AUX= OLD FIN
#add $t7,$zero,$t1 #temporal = OLD AUX
#add $t1,$zero,$t2  # OLD COM-NEW AUX
#add $t2,$zero,$t7  #OLD AUX NEW COM
jal hanoi

j exit