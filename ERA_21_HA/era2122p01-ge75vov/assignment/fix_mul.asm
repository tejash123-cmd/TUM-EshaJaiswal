; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_mul_asm

;ASSIGNMENT START: fix_mul_asm
fix_mul_asm:

push ebp
mov ebp,esp
push ebx 
push ecx
push esi
push edi

mov ebx, dword [ebp+8];a
mov ecx, dword [ebp+12];b
mov esi, dword [ebp+16];c
mov edi, dword [ebp+20];d
mov ax, 0x02 ;al=0 for unsigned, al!= 0 for signed 
cmp ax,0
je both_unsigned 

;assume both numbers >=0
sub ax,ax 

;test ecx sign bit 
test ecx, 0x80000000
jz test_edi
;else found a negative number
;so do two's complement for ecx:ebx
inc ax
not ecx
not ebx
inc ebx
adc ecx,0

test_edi:
test edi, 0x80000000
jz both_unsigned
inc ax
not edi
not esi
inc esi
adc edi,0

both_unsigned:
push ax ;save the count of neg. numbers 
 
;a*d
mov eax,ebx
mul edi
push edx
push eax 
  
;b*c
mov eax,ecx
mul esi
push edx
push eax

;a*c
mov eax,ebx
mul esi
push edx
push eax 

;get b*d*0x10000000*0x10000000 + a*c to edx:ecx:ebx:eax 
mov eax,ecx
mul edi 
mov ecx,eax
pop eax
pop ebx
    
pop esi
pop edi
add ebx,esi ;sets carry flag if there is overflow 
adc ecx,edi ;adc propagates carry 
adc edx,0
        
pop esi
pop edi
add ebx,esi
adc edx,edi
adc edx,0 
            
pop si ;get count of neg. number 
test si,0x0001 ;odd count of neg. nubmers? 
jz all_done;nope 
not eax
not ebx
not ecx
not edx
inc eax 
adc ebx,0
adc ecx,0
adc edx,0 


;all 128 bit result in edx:ecx:ebx:eax but we need only least 64 bits in edx:eax 
;so we need to do some shift right/left and xor operation to get result in edx:eax 
;and we also need to move 26 bits on the right because of Festkommazahlen in Multiplication 
shr eax,26
mov esi,ebx
shl ebx,6
xor eax,ebx
shr esi,26
mov edx,ecx
shl edx,6
shr esi,26
xor edx,esi 


            
all_done: 


pop edi
pop esi
pop ecx
pop ebx
pop ebp

ret


;ASSIGNMENT END: fix_mul_asm

; Schreiben sie allen code der main funktion innerhalb von %ifndef %endif
%ifndef era_test
; Die main funktion stellt einen einfachen Beispielaufruf der zu
; implementierenden funktion dar.
global CMAIN
CMAIN:
  mov ebp, esp
  ; Sie können diese main funktion beliebig erweitern um eigene tests
  ; durchzuführen.
  ;calculate 13 * 2.5
  ;push 2.5
  push 0
  push 167772160
  ;push 13
  push 0
  push 872415232
  call fix_mul_asm
  add esp, 16
  ;value in edx:eax
  ;...do other stuff
  PRINT_HEX 4, edx
  NEWLINE
  PRINT_HEX 4, eax
  NEWLINE

  ;calculate 32 * 2.5
  ;push 2.5
  push 0
  push 167772160
  ;push 32
  push 0
  push 2147483648
  call fix_mul_asm
  add esp, 16
  PRINT_HEX 4, edx
  NEWLINE
  PRINT_HEX 4, eax
  NEWLINE

  ;calculate 64.25 * (-3)
  ;push (-3)
  push 0xffffffff
  push 11110100000000000000000000000000b
  ;push 64.5
  push 0x1
  push 0x1000000
  call fix_mul_asm
  add esp, 16
  PRINT_HEX 4, edx
  NEWLINE
  PRINT_HEX 4, eax
  NEWLINE

  ;calculate (-64) * (-3)
  ;push (-3)
  push 0xffffffff
  push 0xf4000000
  ;push (-64)
  push 0xffffffff
  push 0x0
  call fix_mul_asm
  add esp, 16
  PRINT_HEX 4, edx
  NEWLINE
  PRINT_HEX 4, eax
  NEWLINE


  ret
%endif ; era_test
