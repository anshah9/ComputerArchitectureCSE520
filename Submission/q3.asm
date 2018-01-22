# Title:	Project 1 part 3
# Filename:	q3.asm
# Date:		1/19/2018
# Description:	Pointers
# Input:	None
# Output:	Stores the sum of the array elements in the memory and displays output

################# Data segment #####################
	.data	
	#arr[10] = {2,4,6,8,10,12,14,16,18,20}
	arr: 	.space 40	# sizeof(int) * 10
	sum: 	.word	0	# to store sum of elements
	sumPtr:	.word 	0	# pointer to hold address of sum
################# Code segment #####################
	.text
	.globl main
main:				# main program entry
	la $s0,arr		# load starting address of the array 
	la $s1,sum		# load address of sum
	sw $s1,sumPtr		# store address of sum in sumPtr
	addi $t0,$zero,0	# loop counter : increments by 1
	addi $t2,$zero,0	# memory address counter : increments by 4
	
Loop1:				# loop to populate array
	beq $t0,10,EndLoop1
	add $t1,$zero,$t0	# $t1 = $t0
	addi $t1,$t1,1		# $t1 = $t1 + 1
	mul $t1,$t1,2		# $t1 = ($t1 + 1) * 2 : arr[i] = 2*(i+1)
	add $t3,$t2,$s0		# increment memory address to access next element
	sw $t1, 0($t3)		# store $t1 variable at address $t3
	addi $t2,$t2,4		# increment address by 4 as int is of 4 bytes 
	addi $t0,$t0,1		# increment loop counter
	j Loop1

EndLoop1:		
	addi $t0,$zero,0	# loop counter : increments by 1
	addi $t2,$zero,0	# memory address counter : increments by 4
	
Loop2:	beq $t0,10,EndLoop2
	add $t3,$t2,$s0		# increment memory address to access next element
	lw $a0,sumPtr		# load address of sum : value of sumPtr
	la $a1,($t3)		# load array element from memory in arg1
	jal updateSum		# function call

	addi $t2,$t2,4		# increment address by 4 as int is of 4 bytes 
	addi $t0,$t0,1		# increment loop counter
	j Loop2

EndLoop2:
	lw $a0,sum
	li $v0,1
	syscall			# display sum
	
	li $v0,10		# Exit program
	syscall

#end : main

#start : updateSum function
updateSum:
	lw $t4,($a0)		# sum
	lw $t5,($a1)		# arr[i]
	add $t4,$t4,$t5		# sum = sum + arr[i]
	sw $t4,($a0)		# strore sum at its address
	jr $ra			# function return

#end : updateSum function
