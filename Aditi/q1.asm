# Filename: 	q1.asm
# Date: 	1/19/2018
# Description: 	String handling
# Input:	None
# Output:	Uppercase string

################# Data segment #####################
	.data
		string: .asciiz "Welcome to Computer Architecture Class!"
################# Code segment #####################
	.text
	.globl main
main:			# main program entry
	la $t0,string	#load address of string in $t0 registerr
Loop:			#start of loop
	lb $a0,($t0)	#load char at address contained in $t0
	beqz $a0,EndLoop# value at $t0 equals zero at the end of the string
	
	blt $a0, 'A', upper
	bgt $a0, 'Z', lower	
	j upper		#that is char is in upper case
lower:
	blt $a0, 'a', upper
	bgt $a0, 'z', upper
	#that is char is in lower case
	subi $a0,$a0,0x20	#change to upper case

upper:			#display string
	li $v0,11	#service code to print. '11' = char & '1' = ascii value
	syscall		#print each char
	addi $t0,$t0,0x01#add 1 byte to the existing address so it points to next character
	j Loop		#jump to iterate over loop
EndLoop:
	li $v0,10
	syscall		# Exit program


