	.file	"MaddConstant.cpp"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	_Z12MaddConstantPfS_S_
	.type	_Z12MaddConstantPfS_S_, @function
_Z12MaddConstantPfS_S_:
	vmovaps	ymm0, YMMWORD PTR [rdi]
	vmovaps	ymm1, YMMWORD PTR _ZL1a[rip]
	vfmadd132ps	ymm0, ymm1, YMMWORD PTR [rsi]
	vmovups	XMMWORD PTR [rdx], xmm0
	vextractf128	XMMWORD PTR 16[rdx], ymm0, 0x1
	vzeroupper
	ret
	.size	_Z12MaddConstantPfS_S_, .-_Z12MaddConstantPfS_S_
	.section	.rodata
	.align 32
	.type	_ZL1a, @object
	.size	_ZL1a, 32
_ZL1a:
	.long	1065353216
	.long	1073741824
	.long	1077936128
	.long	1082130432
	.long	1084227584
	.long	1086324736
	.long	1088421888
	.long	1090519040
	.ident	"GCC: (GNU) 8.1.0"
	.section	.note.GNU-stack,"",@progbits
