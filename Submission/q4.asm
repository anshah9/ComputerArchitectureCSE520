#TITLE: Project1 Part4			#FILENAME:q4.asm
#Description: Recursion Program		#Date:01/22/2019
#INPUT: Value of I and X
#OUPUT: Return Value
###############data segment###############
.data
First:	 .asciiz "Enter the number I: " 
Second: .asciiz "Enter the number X: " 
Result:	 .asciiz "Result is " 

###############Code segment############### 
.text
		.globl main
main:
		# STEP 1 -- get the first operand
		# Print a prompt asking user for input
		li $v0, 4   		# syscall number 4 will print string whose address is in $a0       
		la $a0, First      	# "load address" of the string
		syscall     		# actually print the string  

		# Now read in the first operand 
		li $v0, 5      		# syscall number 5 will read an int
		syscall        		# actually read the int
		move $t0, $v0  		#value x
		
		# STEP 2 -- repeat above steps to get the second operand
		# First print the prompt
		li $v0, 4      		# syscall number 4 will print string whose address is in $a0   
		la $a0, Second      	# "load address" of the string
		syscall        		# actually print the string

		# Now read in the second operand 
		li $v0, 5      		# syscall number 5 will read an int
		syscall        		# actually read the int
		move $t1,$v0		#value i
		move $a1,$t1		#passing X and I as arguments
		move $a0,$t0
		jal compute
		move $t2,$v0
		li $v0, 4   		# syscall number 4 will print string whose address is in $a0       
		la $a0, Result 		# "load address" of the string
		syscall     		# actually print the string 
		
		li $v0, 1         	# syscall number 1 -- print int
	        move $a0, $t2     	# print $t2
	        syscall
	        
	        li $v0, 10 		# Syscall number 10 is to terminate the program
		syscall     		# exit now    
		
#a0 has value of X, a1 has value of I
compute:     addi $sp,$sp,-12		#Making space in stack of size 12 bytes
	     sw   $ra, 0($sp)		#Store Return Address to stack
	
	     bgtz $a1,loop1		#Branch if greater than zero for value of X
	     bgtz $a0,loop2		#Brach if greater than zero for value of I			
	     li   $v0,1			#Load 1 to V0
	     lw   $ra, 0($sp)		#Load return address from stack
	     addi $sp, $sp, 12		#Increment stack pointer
	     jr   $ra 			#Jump to return address				
										
loop1:	     sw $a1,4($sp)		#Store value of x into stack
	     sw $a0,8($sp)		#Store value of I into stack
	     addi $a1,$a1,-1		#Decrement value of X
	     jal compute		#Jump and link to Compute
	     addi $v0,$v0,1		#Update value of V0 by 1
	     lw   $ra, 0($sp)		#Load return address from stack
	     addi $sp, $sp, 12		#Increment stack pointer
	     jr   $ra			#Jump to return address

loop2:	     sw $a1,4($sp)		#Store value of X into stack
	     sw $a0,8($sp)		#Store value of I into stack
	     addi $a0,$a0,-1		#Decrement value of I
	     move $a1,$a0		# Copy value of I to X
	     jal compute		#Jump and link to Compute	     	     
	     addi $v0,$v0,5		#Update value of V0 by 5
	     lw   $ra, 0($sp)		#Load return address from stack
	     addi $sp, $sp, 12		#Increment stack pointer
	     jr   $ra			#Jump to return address																						
														
																		
		
		
