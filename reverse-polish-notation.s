.data
espression: .word 18, 25, 10, 7, -2, -3, -1, 13, -2
tab: .word division, multiplication, subtraction, sum
endTab:
printString: .asciiz "The result is: "
.text
.globl main
.ent main

main:
subu $sp $sp 4
sw $ra ($sp)
la $a0, espression
li $a1 9
jal calcRevPolishNotation

move $t0 $v0
li $v0 4
la $a0 printString
syscall
li $v0 1
move $a0 $t0 
syscall

lw $ra ($sp)
addu $sp $sp 4
jr $ra
.end main

#$a0 operator, $a1 first operand, $a2 second operand. It executes the operations and returns the value in $v0
.ent execOperation
execOperation:
move $t0, $a0
mul $t0 $t0 4
lw $t1 endTab($t0)
jr $t1
sum: addu $v0 $a1 $a2
j endExec
subtraction: subu $v0 $a1 $a2
j endExec
multiplication: mulou $v0 $a1 $a2
j endExec
division: divu $v0 $a1 $a2
j endExec
endExec: jr $ra
.end execOperation

.ent calcRevPolishNotation
calcRevPolishNotation:
  addi $sp $sp -20
  sw $ra 16($sp)
  sw $s3 12($sp)
  sw $s2 8($sp)
  sw $s1 4($sp)
  sw $s0 0($sp)
  
  move $s0 $a0 #ind array
  move $s1 $a1 #dim
  
  li $s2 0 #i
  
  #pass all the elements. If it is an operation executes it, if it is not add the value to the stack
  loop:
    beq $s2 $s1 endCalc
    
    lw $s3 0($s0)
    
    blt $s3 $0 operation
    
    addi $sp $sp -4
    sw $s3 0($sp)
      
    
  endLoop:
    addi $s2 $s2 1
    addi $s0 $s0 4
    j loop

endCalc:
  lw $v0 0($sp)
  lw $s0 4($sp)
  lw $s1 8($sp)
  lw $s2 12($sp)
  lw $s3 16($sp)
  lw $ra 20($sp)  
  addi $sp $sp 24
  
  jr $ra
  
  
#prepares the call of execOperation
operation:
  move $a0 $s3 #operator
  lw $a1 4($sp) #first operand
  lw $a2 0($sp) #second operand
  addi $sp $sp 8
  
  jal execOperation
  
  #stores the results in the stack
  addi $sp $sp -4
  sw $v0 0($sp)
    
  j endLoop
  
.end calcRevPolishNotation