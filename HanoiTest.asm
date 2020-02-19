
.data

.word 
.text

main:
addi $t1,$zero,0x10010000 #pointer to first tower
addi $t2,$zero, 0x10010020#pointer to second tower
addi $t3,$zero, 0x10010040 #pointer to third tower
add $t1,$zero,$a1 #AUX
add $t2,$zero,$a2 #FIN

for:		 	#store disks in tower A
beq $s1,$zero,hanoi	#HANOI (N,COM,AUX,FIN)
sw $s1,0($a0)
addi $a0,$a0,4
sub $s1,$s1,1
add $t0,$zero,$a0 #COM
j for

hanoi: 
bne $s0,1,else	#If(n==1)
lw $t3,0($t0)   #get disk from tower COM
sw $zero,0($t0) #remove disk from tower COM
sw $t3,0($t2)   #place disk  to tower FIN
jr $ra
else:
add $t7,$zero,$t2  #temporal = OLD FIN
add $t2,$zero,$t1  #SWAP NEW FIN = OLD AUX
add $t1,$zero,$t7  #SWAP NEW AUX= OLD FIN
sub $s0,$s0,1	#n=n-1;
jal hanoi   #HANOI(N-1,COM,FIN,AUX)
lw $t3,0($t0)   #get disk from tower COM
sw $zero,0($t0) #remove disk from tower COM
sw $t3,0($t2)   #place disk  to tower FIN
swap3:
add $t7,$zero,$t2 #temporal7 = 	NEW AUX





j exit
exit: