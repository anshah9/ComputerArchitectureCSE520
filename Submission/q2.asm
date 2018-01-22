# Title:	Project 1 part 2
# Filename:	q2.asm
# Date:		1/19/2018
# Description:	Arithmetic expressions	: u^2 + 5*u*v - 3*v^2 + 7 = Z
# Input:	2 integer numbers
# Output:	result of expression

################# Data segment #####################
	.data	
	msg1:	.asciiz "Enter value of u "
	msg2:	.asciiz "Enter value of v "
	u: 	.word	0
	v: 	.word	0
################# Code segment #####################
	.text
	.globl main
main:				# main program entry
	la $a0,msg1		
	li $v0,4
	syscall			# prompt user 
	
	li $v0,5		
	syscall			# read integer value from user
	sw $v0,u		# store value at location of u

	la $a0,msg2		
	li $v0,4
	syscall			# prompt user 
	
	li $v0,5
	syscall			# read integer value from user
	sw $v0,v		# store value at location of v
	
	lw $s0,u		# $s0 = u
	add $a0,$zero,$s0
	jal Square		# calling Square function	
	
	add $s2,$zero,$v0	# $s2 = u^2
			
	lw $s1,v		# $s1 = v
	add $a0,$zero,$s1
	jal Square		# calling Square function 
	
	add $s3,$zero,$v0	# $s3 = v^2
	
	add $a0,$zero,$s0	#arg1 = u.		
	add $a1,$zero,$s1	#arg2 = v.
	jal Multiply		# calling Multiply function
	
	add $s4,$zero,$v1	# $s4 = u*v
		
	mul $s4,$s4,5		# $s4 = 5*u*v
	mul $s3,$s3,3		# $s3 = 3*v^2
	add $s2,$s2,$s4		# $s2 = u^2 + 5*u*v
	sub $s2,$s2,$s3		# $s2 = u^2 + 5*u*v - 3*v^2
	
	addi $s2,$s2,7		# $s2 = u^2 + 5*u*v - 3*v^2 + 7 
	
	add $a0,$zero,$s2
	li $v0,1		
	syscall			# display result
	
	li $v0,10		
	syscall			# Exit program

#end : main

#start : Square function
Square:
	mul $v0,$a0,$a0
	jr $ra
#end : square function

#start : Multiply function
Multiply:
	mul $v1,$a0,$a1
	jr $ra
#end : Multiply function
	
	
	
