; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_vec_add_asm

;ASSIGNMENT START: fix_vec_add
fix_vec_add_asm:

push ebp
mov ebp,esp
push ebx
push eax 
push ecx

mov ebx, dword [ebp+8]
mov eax, dword [ebx]
mov ebx, dword [ebp+12]
mov edx, dword [ebx]

add eax,edx 
mov ecx, dword [ebp+16]
mov dword [ecx],eax 
;v1 lower part addition

mov ebx, dword [ebp+8]
mov eax, dword [ebx+4]
mov ebx, dword [ebp+12]
mov edx, dword [ebx+4]

adc eax,edx 
mov dword [ecx+4],eax

;v1 upper part addition

mov ebx, dword [ebp+8]
mov eax, dword [ebx+8]
mov ebx, dword [ebp+12]
mov edx, dword [ebx+8]

add eax,edx 
mov dword [ecx+8],eax
;v2 lower part addition 

mov ebx, dword [ebp+8]
mov eax, dword [ebx+12]
mov ebx, dword [ebp+12]
mov edx, dword [ebx+12]

adc eax,edx 
mov dword [ecx+12],eax
;v2 upper part addition

mov ebx, dword [ebp+8]
mov eax, dword [ebx+16]
mov ebx, dword [ebp+12]
mov edx, dword [ebx+16]

add eax,edx 
mov dword [ecx+16],eax
;v3 lower part addition 

mov ebx, dword [ebp+8]
mov eax, dword [ebx+20]
mov ebx, dword [ebp+12]
mov edx, dword [ebx+20]

adc eax,edx 
mov dword [ecx+20],eax
;v3 upper part addition

pop ecx
pop eax
pop ebx
pop ebp
ret
;ASSIGNMENT END: fix_vec_add

; Schreiben sie allen code der main funktion innerhalb von %ifndef %endif
%ifndef era_test

; Speicherplatz für test Vektoren
section .bss
  v1: resd 6
  v2: resd 6
  o: resd 6
section .text

; Die main funktion stellt einen einfachen Beispielaufruf der zu
; implementierenden funktion dar.
global CMAIN
CMAIN:
  mov ebp, esp
  ; Sie können diese main funktion beliebig erweitern um eigene tests
  ; durchzuführen.
  ;set v1
  mov dword [v1], 67108864
  mov dword [v1+4], 0
  mov dword [v1+8], 67108864
  mov dword [v1+12], 0
  mov dword [v1+16], 67108864
  mov dword [v1+20], 0
  ;set v2
  mov dword [v2], 4227858432
  mov dword [v2+4], 4294967295
  mov dword [v2+8], 4227858432
  mov dword [v2+12], 4294967295
  mov dword [v2+16], 4227858432
  mov dword [v2+20], 4294967295
  push dword o
  push dword v2
  push dword v1
  call fix_vec_add_asm
  add esp, 12
  cmp dword [o],0
  jne fail
  cmp dword [o+4], 0
  jne fail
  cmp dword [o+8],0
  jne fail
  cmp dword [o+12], 0
  jne fail
  cmp dword [o+16],0
  jne fail
  cmp dword [o+20], 0
  jne fail
  PRINT_STRING "Success"
  NEWLINE

  mov ebp, esp; for correct debugging
  ;set v1
  mov dword [v1], 0
  mov dword [v1+4], 0
  mov dword [v1+8], 0
  mov dword [v1+12], 0
  mov dword [v1+16], 0
  mov dword [v1+20], 0
  ;set v2
  mov dword [v2], 0
  mov dword [v2+4], 0
  mov dword [v2+8], 0
  mov dword [v2+12], 0
  mov dword [v2+16], 0
  mov dword [v2+20], 0
  push dword o
  push dword v2
  push dword v1
  call fix_vec_add_asm
  add esp, 12
  cmp dword [o],0
  jne fail
  cmp dword [o+4], 0
  jne fail
  cmp dword [o+8],0
  jne fail
  cmp dword [o+12], 0
  jne fail
  cmp dword [o+16],0
  jne fail
  cmp dword [o+20], 0
  jne fail
  PRINT_STRING "Success"
  ret
  fail:
  PRINT_STRING "Test failed"
  ret
%endif ; era_test
