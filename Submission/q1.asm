#TITLE: Project1 Part1			#FILENAME:q1.asm
#Description: String Handling Program		#Date:01/22/2019
#INPUT: String given in data sagment
#OUPUT: Converted String
###############data segment###############
.data
string:	.asciiz "Welcome to Computer Architecture Class!"

###############Code segment###############
.text
.globl  main

main:
        li $t1,0
	
loop:

	lb $t2,string($t1)	#Load the byte from memory space	
	beq $t2,$0 endloop	#Branch if the last element of string is NULL	
	slti $s0, $t2,0X60	#Set S0 if the byte is less than or equal 0X60
	bne $s0, $0 endCase	#Branch if S0 not equal to 1
	sgt $s0, $t2, 0X7B	#Set S0 if the byte is greater than or equal 0X60
	bne  $s0, $0 endCase    #Branch if S0 not equal to 1  
	subi $t2,$t2, 0X20	#Subtract ASCII value of byte by 20
endCase:
	sb $t2,string($t1)	#Store byte into memory space
	addi $t1,$t1,1		#Increment t1
	j loop			#Branch to loop
	
endloop:
	move $a0,$t2		#Move value in t0 to a0
	li $v0,4		# syscall number 4 will print string whose address is in $a0
	la $a0,string		# "load address" of the string
	syscall			# actually print the string
	
  	li $v0, 10  		# Syscall number 10 is to terminate the program
	syscall     		# exit now  
	
	

 
