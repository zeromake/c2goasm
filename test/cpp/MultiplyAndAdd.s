	.file	"MultiplyAndAdd.cpp"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	_Z14MultiplyAndAddPfS_S_S_
	.type	_Z14MultiplyAndAddPfS_S_S_, @function
_Z14MultiplyAndAddPfS_S_S_:
	vmovaps	ymm0, YMMWORD PTR [rdi]
	vmovaps	ymm1, YMMWORD PTR [rdx]
	vfmadd132ps	ymm0, ymm1, YMMWORD PTR [rsi]
	vmovups	XMMWORD PTR [rcx], xmm0
	vextractf128	XMMWORD PTR 16[rcx], ymm0, 0x1
	vzeroupper
	ret
	.size	_Z14MultiplyAndAddPfS_S_S_, .-_Z14MultiplyAndAddPfS_S_S_
	.ident	"GCC: (GNU) 8.1.0"
	.section	.note.GNU-stack,"",@progbits
