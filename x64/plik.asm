  var1:  .byte     'A', 0x21, 0x2A, 0x2B, 0x35, 0x4A, '\n'
  var2:  .half     0x21F, 0xABC, 0x7A, 0x1111
  var3:  .word     0234, 0021, 0001, 09999, 0103, 0152
  var4:  .float    12.3, -0.1
  var5:  .double   1.5e-10
  str1:  .ascii    "i love mips\n"
  str2:  .asciiz   "zero-finished string"
  array: .space    100
  	 .globl main
.text
mai0x21n:
  	addiu $s1, $zero, 0x123
  	addiu $s1, $zero, -0x2A1
  	#0x43
  	beq $s1, 0x41, end
e0x6Ed:	
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 10
	syscall
	
# A tu masz jeszcze kilka przykladow
0x21, 0x1
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F
0060, 0061, 0062, 0063, 0064, 0065, 0066, 0067, 0070, 0071, 0072, 0073, 0074, 0075, 0076, 0077

0x, 0x0, 0104, 0x0000, 0xFFFF, 0x3FF
00, 000, 00001, 0x30, 01111, 0011