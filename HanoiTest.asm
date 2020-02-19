
.data

.word 
.text

main:
addi $t1,$zero,0x10010000 #pointer to first tower
addi $t2,$zero, 0x10010020#pointer to second tower
addi $t3,$zero, 0x10010040 #pointer to third tower

addi $s0,$zero,3 #number of disks
addi $s1,$zero,1 #i
loop:
beq $s0,$zero,
sw $s0,0($t1)
