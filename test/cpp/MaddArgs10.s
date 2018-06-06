	.file	"MaddArgs10.cpp"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	_Z10MaddArgs10PfS_S_S_S_S_S_S_S_S_
	.type	_Z10MaddArgs10PfS_S_S_S_S_S_S_S_S_, @function
_Z10MaddArgs10PfS_S_S_S_S_S_S_S_S_:
	vmovaps	ymm0, YMMWORD PTR [rdi]
	vmovaps	ymm2, YMMWORD PTR [r8]
	push	rbp
	vmovaps	ymm1, YMMWORD PTR [rdx]
	vfmadd132ps	ymm0, ymm1, YMMWORD PTR [rsi]
	vfmadd132ps	ymm0, ymm2, YMMWORD PTR [rcx]
	mov	rbp, rsp
	mov	rdx, QWORD PTR 16[rbp]
	mov	rcx, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 40[rbp]
	vmovaps	ymm3, YMMWORD PTR [rdx]
	mov	rdx, QWORD PTR 32[rbp]
	vfmadd132ps	ymm0, ymm3, YMMWORD PTR [r9]
	vmovaps	ymm4, YMMWORD PTR [rdx]
	vfmadd132ps	ymm0, ymm4, YMMWORD PTR [rcx]
	vmovups	XMMWORD PTR [rax], xmm0
	vextractf128	XMMWORD PTR 16[rax], ymm0, 0x1
	vzeroupper
	pop	rbp
	ret
	.size	_Z10MaddArgs10PfS_S_S_S_S_S_S_S_S_, .-_Z10MaddArgs10PfS_S_S_S_S_S_S_S_S_
	.ident	"GCC: (GNU) 8.1.0"
	.section	.note.GNU-stack,"",@progbits
