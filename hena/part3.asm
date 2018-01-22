.data
	array:	.word   0 : 10	    # array of 5 words
	size:	.word  10            # size of array 
Result:	 .asciiz "Sum of all 10 numbers in the array is " 

.text
	.globl main
main:
	la $s1,array
	lb $t0,size
	#subi $t0,$t0,1
	li $t1,0
	#li $t3,2
	
loop:	ble $t0,$t1,entry
	addi $t2,$t1,1
	add  $t2,$t2,$t2
	sw $t2,0($s1)
	addi $t1,$t1,1
	addi $s1,$s1,0X04
	j loop
	
entry:	
	la $s1,array
	li,$t1,0
	subi $t0,$t0,1
	lb $t3,0($s1)
	
	addi $t4,$t3,0
	
sum:
	ble $t0,$t1,end
	addi $s1,$s1,0X04
	lb $t3,0($s1)
	add $t4,$t3,$t4
	addi $t1,$t1,1
	j sum
	
end: 
	li $v0, 4      			# syscall number 4 -- print string
        la $a0, Result   
	syscall       			# actually print the string   
	 # Then print the actual sum
	 li $v0, 1         		# syscall number 1 -- print int
	 move $a0, $t4     		# print $s2
	 syscall 
	 
	li $v0, 10  # Syscall number 10 is to terminate the program
	syscall     # exit now
       
	
