# c2goasm: C to Go Assembly 

## Introduction

This is a tool to convert assembly as generated by a C/C++ compiler into Golang assembly. It is meant to be used in combination with [asm2plan9s](https://github.com/minio/asm2plan9s) in order to automatically generate pure Go wrappers for C/C++ code (that may for instance take advantage of compiler intrinsics).



Mode of operation:
```
$ c2goasm /path/to/c-project/build/SimdAvx2Detection.cpp.s SimdAvx2Detection_amd64.s
$ asm2plan9s SimdAvx2Detection_amd64.s
```

Optionally you can nicely format the code using [asmfmt](https://github.com/klauspost/asmfmt):
```
$ asmfmt -w SimdAvx2Detection_amd64.s
```

This project has been developed as part of developing a Go wrapper around [Simd](https://github.com/ermig1979/Simd). However it should also work with other project and libraries.

## Invocation

```
$ c2goasm /path/to/c-project/build/SomeGreatCode.cpp.s SomeGreatCode_amd64.s
```

## Example

Here is a simple C function doing an AVX2 intrinsics computation:
```
void MultiplyAndAdd(float* arg1, float* arg2, float* arg3, float* result) {
    __m256 vec1 = _mm256_load_ps(arg1);
    __m256 vec2 = _mm256_load_ps(arg2);
    __m256 vec3 = _mm256_load_ps(arg3);
    __m256 res  = _mm256_fmadd_ps(vec1, vec2, vec3);
    Store<true>((__m256i*)(result), res);
}
```

Compiling into assembly gives the following
```
__ZN14MultiplyAndAddEPfS1_S1_S1_: ## @_ZN14MultiplyAndAddEPfS1_S1_S1_
## BB#0:
        push          rbp
        mov           rbp, rsp
        vmovups       ymm0, ymmword ptr [rdi]
        vmovups       ymm1, ymmword ptr [rsi]
        vfmadd213ps   ymm1, ymm0, ymmword ptr [rdx]
        vmovups       ymmword ptr [rcx], ymm1
        pop           rbp
        vzeroupper
        ret
```

Running `c2goasm` will generate the following Go assembly (eg. saved in `MultiplyAndAdd_amd64.s`)
```
//+build !noasm !appengine
// AUTO-GENERATED BY C2GOASM -- DO NOT EDIT

TEXT ·_MultiplyAndAdd(SB), 7, $0

	MOVQ arg1+0(FP), DI  // rdi = arg1
	MOVQ arg2+8(FP), SI  // rsi = arg2
	MOVQ arg3+16(FP), DX // rdx = arg3
	MOVQ arg4+24(FP), CX // rcx = arg4
	
	LONG $0x0710fcc5             // vmovups ymm0, [rdi]
	LONG $0x0e10fcc5             // vmovups ymm1, [rsi]
	LONG $0xa87de2c4; BYTE $0x0a // vfmadd213ps     ymm1, ymm0, [rdx]
	LONG $0x0911fcc5             // vmovups [rcx], ymm1
	
	VZEROUPPER
	RET
```

This should then be accompanied by the following Go code (in `MultiplyAndAdd_amd64.go`)
```
//go:noescape
func _MultiplyAndAdd(vec1, vec2, vec3, result unsafe.Pointer)

func MultiplyAndAdd(someObj Object) {

	_MultiplyAndAdd(someObj.GetVec1(), someObj.GetVec2(), someObj.GetVec3(), someObj.GetResult()))
}
```

## Internals

- Map function arguments from Golang calling convention into C calling convention
- Setup an (aligned) stack for the C code
- Get constants from Go assembly table to handle `rip`-based loads (PIC = position independent code) 

Caveats
- Arguments need to be 64-bit size (either a value or a pointer) 
- No `call` statements (i.e. inline your C code)

## Generate assembly from C/C++

See list of assembly targets
```
$ make help | grep "\.s"
```

See actual command
```
$ make -n  SimdAvx2BgraToGray.s
```

Additional arguments to aid in assembly generation
```
```

## Tested compilers

- clang on OSX
