.data
 uvalue: .asciiz "Enter the value of u:"
 vvalue: .asciiz "Enter the value of v:"
 ans: .asciiz "The answer is:"
.text
.globl main
main:
	la $a0,uvalue
	li $v0,4
	syscall
	li $v0, 5
	syscall
	add $s0,$v0,$0

	la $a0,vvalue
	li $v0,4
	syscall
	li $v0, 5
	syscall
	add $s1,$v0,$0
	
	add $a0,$s0,$0
	jal Square
	add $t0,$0,$v0
	add $a0,$s1,$0
	jal Square
	add $t1,$0,$v0
	add $a1,$s0,$0
	jal Multiply
	add $t3,$0,$v0
	mul $t1,$t1,3
	mul $t3,$t3,5
	addi $t0,$t0,7
	sub $t1,$t3,$t1
	la $a0,ans
	li $v0,4
	syscall
	add $a0,$t0,$t1
	li $v0,1
	syscall 
	li $v0,10
	syscall
Square: 
	mul $t2,$a0,$a0
	addu $v0,$t2,$0
	jr $ra
	
Multiply:
	mul $t2,$a0,$a1
	addu $v0,$t2,$0
	jr $ra

