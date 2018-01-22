.data

First:	 .asciiz "Enter the number X: " 
Second: .asciiz "Enter the number I: " 
Result:	 .asciiz "Result is " 
strCR:		 .asciiz "\n" 
.text
		.globl main
main:
		# STEP 1 -- get the first operand
		# Print a prompt asking user for input
		li $v0, 4   			# syscall number 4 will print string whose address is in $a0       
		la $a0, First      	# "load address" of the string
		syscall     			# actually print the string  

		# Now read in the first operand 
		li $v0, 5      			# syscall number 5 will read an int
		syscall        			# actually read the int
		move $t0, $v0  			#value x

		# STEP 2 -- repeat above steps to get the second operand
		# First print the prompt
		li $v0, 4      			# syscall number 4 will print string whose address is in $a0   
		la $a0, Second      	# "load address" of the string
		syscall        			# actually print the string

		# Now read in the second operand 
		li $v0, 5      			# syscall number 5 will read an int
		syscall        			# actually read the int
		move $t1,$v0			#value i
		li $t2,0
		#li $t3,0
		
		jal sum
		
		li $v0, 4   			# syscall number 4 will print string whose address is in $a0       
		la $a0, Result 		     	# "load address" of the string
		syscall     			# actually print the string 
		
		li $v0, 1         		# syscall number 1 -- print int
	        move $a0, $t2     		# print $s2
	        syscall
	        
	        li $v0, 10  # Syscall number 10 is to terminate the program
		syscall     # exit now    
		
#t0 value x,it1value 
sum:         addi $sp,$sp,-12
	     sw   $ra, 0($sp)
	
	     bgtz $t0,step1
	     bgtz $t1,step2				
	     li $t2,1
	     lw   $ra, 0($sp)
	     addi $sp, $sp, 12
	     jr   $ra 						
										
step1:	     sw $t0,4($sp)
	     sw $t1,8($sp)
	     addi $t0,$t0,-1
	     jal sum
	     addi $t2,$t2,1
	     lw   $ra, 0($sp)
	     addi $sp, $sp, 12
	     jr   $ra

step2:	     sw $t0,4($sp)
	     sw $t1,8($sp)
	     addi $t1,$t1,-1
	     move $t0,$t1
	     jal sum	     	     
	     addi $t2,$t2,5
	     lw   $ra, 0($sp)
	     addi $sp, $sp, 12
	     jr   $ra																							
														
																		
		
		
