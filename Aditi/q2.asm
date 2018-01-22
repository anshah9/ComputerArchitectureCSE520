# Filename:	q2.asm
# Date:		1/19/2018
# Description:	Arithmetic expressions
# Input:	2 integer numbers
# Output:	result of expression

################# Data segment #####################
	.data	
	#Each variable is of 32 bits
	u: .word
	v: .word
################# Code segment #####################
	.text
	.globl main
main:			# main program entry
	#u^2 + 5*u*v - 3*v^2 + 7 = Z
	
	li $v0,5		#read integer value from user
	syscall	
	sw $v0,u		#store value at location of u
	
	la $t2,u
	
	li $v0,5
	syscall
	sw $v0,4($t2)		#store value at location of v
	
	lw $s0,($t2)		# $s0 = u
	add $a0,$zero,$s0
	
	jal Square		#Jump and save return address in $ra	
	add $s2,$zero,$v0	# $s2 = u^2
			
	lw $s1,4($t2)		# $s1 = v
	add $a0,$zero,$s1
	
	jal Square		#Jump and save return address in $ra
	add $s3,$zero,$v0	# $s3 = v^2
	
	add $a0,$zero,$s0	#arg1 = u.		
	add $a1,$zero,$s1	#arg2 = v.
			
	jal Multiply		#Jump and save return address in $ra
	
	add $s4,$zero,$v1	# $s4 = u*v
		
	mul $s4,$s4,5		# $s4 = 5*u*v
	mul $s3,$s3,3		# $s3 = 3*v^2
	add $s2,$s2,$s4		# $s2 = u^2 + 5*u*v
	sub $s2,$s2,$s3		# $s2 = u^2 + 5*u*v - 3*v^2
	
	addi $s2,$s2,7		# $s2 = u^2 + 5*u*v - 3*v^2 + 7 
	
	add $a0,$zero,$s2
	li $v0,1		# $a0 has integer to print
	syscall
	
	li $v0,10		# Exit program
	syscall

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
	
	
	
