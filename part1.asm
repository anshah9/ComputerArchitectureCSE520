
		.data
string:	.asciiz "HENA SHAH IS HERE"
	.text
	.globl  main

main:
        li $t1,0
	
loop:

	lb $t2,string($t1)	
	#slti $s0,$t2,0
	beq $t2,$0 endloop	
	slti $s0, $t2,0X60
	bne $s0, $0 endCase
	sgt $s0, $t2, 0X7B
	bne  $s0, $0 endCase      
	SUBI $t2,$t2, 0X20
endCase:
	sb $t2,string($t1)
	ADDI $t1,$t1,1
	j loop
	
endloop:
	move $a0,$t2
	li $v0,4
	la $a0,string
	syscall
#li $v0,10	

	
	

 
