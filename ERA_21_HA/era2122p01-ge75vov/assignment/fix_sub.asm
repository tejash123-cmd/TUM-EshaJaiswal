; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_sub_asm

;ASSIGNMENT START: fix_sub_asm
fix_sub_asm:
    push ebp
    mov ebp, esp 
    push ebx
    mov eax, [ebp+8]
    mov edx, [ebp+16]
    sub eax,edx 
    
   
    mov edx, [ebp+12]
    mov ebx, [ebp+20]
    
   
    sbb edx,ebx
    
   
    pop ebx
    pop ebp 
    
    ret
;ASSIGNMENT END: fix_sub_asm

; Schreiben sie allen code der main funktion innerhalb von %ifndef %endif
%ifndef era_test
; Die main funktion stellt einen einfachen Beispielaufruf der zu
; implementierenden funktion dar.
global CMAIN
CMAIN:
  mov ebp, esp
  ; Sie können diese main funktion beliebig erweitern um eigene tests
  ; durchzuführen.
  ;14.5 - 5
  ;push 5
  push 0
  push 335544320
  ;push 14.5
  push 0
  push 973078528
  call fix_sub_asm
  add esp, 16
  ;result in edx:eax
  cmp edx, 0
  jnz fail
  cmp eax, 637534208
  jnz fail

  push 00000000000000000000000000000001b
  push 00000000000000000000000000000000b

  push 0
  push 0
  call fix_sub_asm
  add esp, 16
  ;result in edx:eax
  cmp edx, 0
  jnz fail
  cmp eax, 0
  jnz fail
  PRINT_HEX 4, edx
  NEWLINE
  PRINT_DEC 4, eax
  NEWLINE
  PRINT_STRING "Success"
  ret
fail:
  PRINT_DEC 4, edx
  NEWLINE
  PRINT_DEC 4, eax
  NEWLINE
  PRINT_STRING "Failure"
  ret
%endif ; era_test
