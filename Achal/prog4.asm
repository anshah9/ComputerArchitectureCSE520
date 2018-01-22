.data
 ivalue: .asciiz "Enter the value of i:"
 xvalue: .asciiz "Enter the value of x:"
 ans: .asciiz "The answer is:"
.text
.globl main
main:
	la $a0,ivalue
	li $v0,4
	syscall
	li $v0, 5
	syscall
	move $t0,$v0

	la $a0,xvalue
	li $v0,4
	syscall
	li $v0, 5
	syscall
	move $a1,$v0
	move $a0,$t0
	jal compute
	move $s0,$v0
	la $a0,ans
	li $v0,4
	syscall
	move $a0,$s0
	li $v0,1
	syscall 
	
	
	li $v0,10 #exit
	syscall
	
compute:
	subi $sp,$sp,12
	sw $ra, 0($sp)
	bgtz $a1,loop1
	bgtz $a0,loop2
	lw $ra, 0($sp)
	li $v0,1
	addiu $sp,$sp,12
	jr $ra
	
	loop1:
		
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		subi $a1,$a1,1
		jal compute
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $ra, 0($sp)
		addiu $v0,$v0,1
		addiu $sp,$sp,12
		jr $ra
	 	
	 loop2:
	 	
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		subi $a0,$a0,1
		move $a1,$a0
		jal compute
	#	addiu $sp,$sp,12
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $ra, 0($sp)
		addiu $v0,$v0,5
		addiu $sp,$sp,12
		jr $ra
