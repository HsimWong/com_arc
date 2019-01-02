;*********** WINDLX Ex.3: Factorial		*************
;*********** (c) 1991 Günther Raidl		*************
;*********** Modified: 1992 Maziar Khosravipour *************
;--------------------------------------------------------------------------
; Program begin at symbol main
; requires module INPUT
; read a number from stdin and calculate the factorial (type: double)
; the result is written to stdout
;--------------------------------------------------------------------------

		.data
Prompt: 	.asciiz 	"An integer value >1 : "

PrintfFormat:	.asciiz 	"Factorial = %d\n\n"
		.align		2
PrintfPar:	.word		PrintfFormat
PrintfValue:	.word		4


		.text
		.global	main
main:
		;*** Read value from stdin into R1
		addi		r1,r0,Prompt
		jal		InputUnsigned
		
		;*** init values
		;movi2fp 	f10,r1		;R1 -> D0	D0..Count register
		;cvti2d		f0,f10
		;addi		r2,r0,1 	;1 -> D2	D2..result
		;movi2fp		f11,r2
		;cvti2d		f2,f11
		;movd		f4,f2		;1-> D4 	D4..Constant 1
		
		;*** Break loop if D0 = 1
		addi r2,r0,1
		add r4,r0,r2
Loop:		sub  r3,r1,r2
		beqz r3,Finish
		
		
		;*** Multiplication and next loop
		mult		r4,r4,r1
		sub		r1,r1,r2
		j		Loop

Finish: 	;*** write result to stdout
		;addi r5,r0,48
		;add r4,r4,r5
		sw		PrintfValue,r4
		addi		r14,r0,PrintfPar
		trap		5
				
		;*** end
		trap		0	
		
