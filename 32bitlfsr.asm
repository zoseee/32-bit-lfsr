.data

seed: .word 0x55AAFF00
prompt: .asciiz "\n"
y: .word 0

.text
main: 

    lw  $t0, seed # calling function with seed
    jal lfsr32

    lw $a0, y #random number print
    li $v0, 36
    syscall

    li $v0, 4
    la $a0, prompt
    syscall

    li $t7, 0 #for loop
    
    forloop:
    bgt $t7, 9, endProgram
    li $t0, 0
    jal lfsr32

    move $a0, $v0
    li $v0, 36
    syscall
    
    li $v0, 4
    la $a0, prompt
    syscall
    
    addi $t7, $t7 1
    
    j forloop

endProgram:
    li $v0, 10
    syscall



		lfsr32:
		li $s1, 0 #cycle
		beqz $t0, notzero
		j function
		
		notzero:
		lw $t0, y
		j function
		
		function:		
		bgt $s1, 31, end
		
		srl $t3, $t0, 0 #lfsr >> 0
        
        	srl $t4, $t0, 10 ##lfsr >> 10
        	
        	xor $t5, $t3, $t4
        
        	srl $t3, $t0, 30 ##lfsr >> 30
        
        	srl $t4, $t0, 31 ##lfsr >> 31
        	
        	xor $t6, $t3, $t4
        	
        	xor $t1, $t5, $t6
        	andi $t1, $t1, 1
        	
        	srl $t6, $t0, 1
        	sll $t9, $t1, 31
        	
        	or $t0, $t6, $t9
		
		addi $s1, $s1, 1
		j function
		
		end:
		sw $t0, y
		move $v0, $t0
		jr $ra
		
		
		
		
		
		
		
		
		
		
		
