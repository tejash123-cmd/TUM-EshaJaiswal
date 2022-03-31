; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_vec_sub_asm

;ASSIGNMENT START: fix_vec_sub
fix_vec_sub_asm:

    push ebp
    mov ebp,esp
    push ebx
    push eax 
    push ecx

    mov ebx, dword [ebp+8]
    mov eax, dword [ebx]
    mov ebx, dword [ebp+12]
    mov edx, dword [ebx]

    sub eax,edx 
    mov ecx, dword [ebp+16]
    mov dword [ecx],eax 
;v1 lower part substraction

    mov ebx, dword [ebp+8]
    mov eax, dword [ebx+4]
    mov ebx, dword [ebp+12]
    mov edx, dword [ebx+4]

    sbb eax,edx 
    mov dword [ecx+4],eax

;v1 upper part substraction

    mov ebx, dword [ebp+8]
    mov eax, dword [ebx+8]
    mov ebx, dword [ebp+12]
    mov edx, dword [ebx+8]

    sub eax,edx 
    mov dword [ecx+8],eax
;v2 lower part substraction 

    mov ebx, dword [ebp+8]
    mov eax, dword [ebx+12]
    mov ebx, dword [ebp+12]
    mov edx, dword [ebx+12]

    sbb eax,edx 
    mov dword [ecx+12],eax
;v2 upper part substraction

    mov ebx, dword [ebp+8]
    mov eax, dword [ebx+16]
    mov ebx, dword [ebp+12]
    mov edx, dword [ebx+16]

    sub eax,edx 
    mov dword [ecx+16],eax
;v3 lower part substraction 

    mov ebx, dword [ebp+8]
    mov eax, dword [ebx+20]
    mov ebx, dword [ebp+12]
    mov edx, dword [ebx+20]

    sbb eax,edx 
    mov dword [ecx+20],eax
;v3 upper part substraction

    pop ecx
    pop eax
    pop ebx
    pop ebp
    ret
;ASSIGNMENT END: fix_vec_sub

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
  ; missing: set values in v1
  ; missing: set values in v2
  push dword o
  push dword v2
  push dword v1
  call fix_vec_sub_asm
  add esp, 12
  ;o = v1 - v2
  ret
%endif ; era_test
