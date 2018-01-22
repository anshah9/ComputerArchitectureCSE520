# Title:	Project 1 part 4
# Filename:	q4.asm
# Date:		1/19/2018
# Description:	Recursion
# Input:	value of 'i' and 'x'
# Output:	result of the computation Compute(i,x)

################# Data segment #####################
	.data	
	msg1: 	.asciiz "Enter value of i "	
	msg2: 	.asciiz "\nEnter value of x "
	msg3:	.asciiz "\nResult "
	i: 	.word 0
	x: 	.word 0
	result:	.word 0

################# Code segment #####################
	.text
	.globl main		# can be referenced from other files
main:				# main program entry
	la $a0,msg1		
	li $v0,4
	syscall			# prompt user 

	la $s0,i		#obtain address of 'i'
	li $v0,5		# read integer value of 'i'
	syscall
	sw $v0,($s0)		#store value of 'i' in memory
	
	la $a0,msg2		
	li $v0,4
	syscall			# prompt user
	
	la $s1,x		# obtain address of 'x'
	li $v0,5		# read integer value of 'x'
	syscall
	sw $v0,($s1)		# store value of 'x' in memory
	
	lw $a0,i		# arg1 = i
	lw $a1,x		# arg2 = x
	
	jal Compute		# function calling
	
	sw $v0,result		# store the result in 'result' memory location
		
	add $a0,$zero,$v0
	li $v0,1
	syscall			# display result on console
	
	li $v0,10		# Exit program
	syscall

#end : main

#start : Compute function
Compute:
	subu $sp,$sp,12		# creating space in stack for return address and 2 args
	sw   $ra,0($sp)		# store return address on stack
	sw   $a0,4($sp)		# store 1st arg1 = 'i' on stack
	sw   $a1,8($sp)		# store 2nd arg2 = 'x' on stack
	
	bgtz $a1,Loop1		# $a1 = 'x'
	bgtz $a0,Loop2		# $a0 = 'i'
	li $v0,1
End:	lw $ra,($sp)		# obtaining return address from stack
	lw $a0,4($sp)		# obtaining arg1 from stack
	lw $a1,8($sp)		# obtaining arg2 from stack
	addi $sp,$sp,12		# incrementing stack pointer
	jr $ra
	
Loop1:	subi $a1,$a1,1		# x = x - 1
	jal Compute
	addi $v0,$v0,1		# Compute(i,x) + 1
	j End
	
Loop2:	subi $a0,$a0,1		# i = i - 1
	add $a1,$zero,$a0	# $a0 = i - 1	$a1 = i - 1
	jal Compute		
	addi $v0,$v0,5		# Compute(i,x) + 5
	j End
	
#end : Compute function
