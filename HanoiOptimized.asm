#Authors: Jorge Alejandro Dong Llauger IS714046 and Kevin Antonio Moreno Melgoza IS714714
#Date: 19/02/20
#Description: Program in assembler MIPS to solve HANOI TOWERS  with N disks. 

.data
.word 
.text

main:
addi $s0,$zero,8	#number of disks N

addi $t8,$zero,1 	#Set register to 1 for future beq

addi $t0,$zero,0x1001	#base for all pointers
sll  $t0,$t0, 16	#shift left logical

addi $t1,$t0,0x0020 	#pointer to  tower B

addi $t2,$t0,0x0040	#pointer to  tower C


add $s1,$zero,$s0 	#counter i

for:		 	# "for" to store all disks in tower A
sw $s1,0($t0)		#store disk in tower A
addi $t0,$t0,4		#update last position of tower A
addi $s1,$s1,-1		# update counter i
bne $s1,$zero,for	#if counter i!=0 continue with for

recursive:		
jal hanoi		#HANOI FIRST call to hanoi function
j exit	

hanoi:
bne $s0,$t8,else	#If(n==1) Base case
addi $t0, $t0, -4	#decrease one byte of the origin tower
lw $t3,0($t0)   	#get disk from origin tower
sw $zero,0($t0) 	#remove disk from origin tower
sw $t3,0($t2)  	 	#place disk  to destination tower
addi $t2,$t2,4 		#update last position of destination tower
jr $ra

else:			#SAVE DATA IN STACK
addi $sp,$sp,-8 	#decrease sp 2 bytes to store data
sw $ra,4($sp)   	#store the returning direction in stack
sw $s0,0($sp)   	#store actual N in stack


swap:			# swap between auxiliar tower and destination tower
add $t7,$zero,$t2  	#temporary = OLD DESTINATION
add $t2,$zero,$t1  	#SWAP NEW DESTINATION= OLD AUX
add $t1,$zero,$t7  	#SWAP NEW AUX= OLD DESTINATION
bne  $a3, $zero, recover  #if the auxiliar flag != 0, jump to the label recover, else continue

# After swap
addi $s0,$s0,-1		#n=n-1;
jal hanoi 
addi $a3, $zero, 1	#axuiliar flag = 1 (recursive calls from left child ended)
j   swap		#jump to the label swap
 		
recover: 		#load data from stack 
add  $a3, $zero, $zero	#clean flag
lw   $s0, 0($sp)	#load N from the top of the stack	
lw   $ra, 4($sp)	#load ra direction from the stack	
addi $sp, $sp, 8	#increase 2 bytes to the stack pointer

addi $t0, $t0, -4	#decrease one byte to the origin tower
lw $t3,0($t0)   	#get disk from origin tower 
sw $zero,0($t0) 	#remove disk from origin tower
sw $t3,0($t2)   	#place disk  to destination tower 
addi $t2,$t2,4 		#update last position of destination tower

addi $sp,$sp,-8 	#save 2 bytes of memory to store data
sw $ra,4($sp)   	#store the returning direction in stack
sw $s0,0($sp)   	#store actual N in stack

			#SWAP
add $t7,$zero,$t0  	#temporary = OLD ORIGIN
add $t0,$zero,$t1  	#SWAP NEW ORIGIN = OLD AUX
add $t1,$zero,$t7  	#SWAP NEW AUX= OLD ORIGIN
addi $s0,$s0,-1	   	#n=n-1;

jal hanoi		#load RA from stack, to jump to the previous recursive call	
lw   $ra, 4($sp)	#load ra direction from the stack	
addi $sp, $sp, 8	#increase 2 bytes to the stack pointer

			#SWAP
add $t7,$zero,$t0  	#temporary = OLD ORIGIN
add $t0,$zero,$t1  	#SWAP NEW ORIGIN = OLD AUX
add $t1,$zero,$t7  	#SWAP NEW AUX= OLD ORIGIN


jr $ra
exit:			#END PROGRAM
