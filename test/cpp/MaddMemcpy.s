	.file	"MaddMemcpy.cpp"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	_Z10MaddMemcpyPfS_S_iiS_
	.type	_Z10MaddMemcpyPfS_S_iiS_, @function
_Z10MaddMemcpyPfS_S_iiS_:
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, r9
	push	r14
	mov	r14, rsi
	mov	rsi, rdi
	push	r13
	mov	r13, rdx
	movsx	rdx, ecx
	push	r12
	mov	r12d, r8d
	push	rbx
	mov	rbx, rdi
	mov	rdi, r14
	and	rsp, -32
	call	memcpy@PLT
	movsx	rdx, r12d
	mov	rsi, rbx
	mov	rdi, r13
	call	memcpy@PLT
	vmovaps	ymm0, YMMWORD PTR [rbx]
	vmovaps	ymm1, YMMWORD PTR 0[r13]
	vfmadd132ps	ymm0, ymm1, YMMWORD PTR [r14]
	vmovups	XMMWORD PTR [r15], xmm0
	vextractf128	XMMWORD PTR 16[r15], ymm0, 0x1
	vzeroupper
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	_Z10MaddMemcpyPfS_S_iiS_, .-_Z10MaddMemcpyPfS_S_iiS_
	.ident	"GCC: (GNU) 8.1.0"
	.section	.note.GNU-stack,"",@progbits
