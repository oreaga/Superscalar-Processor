#
# test.s
#
# program to demonstrate RiSC-16 core
# (uses all opcodes)
#
	lw	r1, r0, arg1
	lw	r3, r0, count
loop:	lw	r2, r4, arg2
	movi	r7, sub
	jalr	r7, r7
	addi	r3, r3, -1
	addi	r4, r4, 1
	bne	r3, 0, loop
exit:	sw	r1, r0, diff
	halt
#
# subtract function
#
sub:	nand	r2, r2, r2
	addi	r2, r2, 1
	add	r1, r1, r2
	jalr	r0, r7
#
# data:
#
# count is the number of items to subtract from arg1
# (in this case, 3: arg2 and two beyond it)
# diff is where the result is placed
#
count:	.fill	3
arg1:	.fill	8476
arg2:	.fill	2
	.fill	3
	.fill	4
	.fill	1
	.fill	345
diff:	.fill	0
