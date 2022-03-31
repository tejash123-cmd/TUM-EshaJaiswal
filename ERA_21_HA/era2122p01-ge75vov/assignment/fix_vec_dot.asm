; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_vec_dot_asm
; extern fix_mul_asm

;ASSIGNMENT START: fix_vec_dot
fix_vec_dot_asm:
  ret
;ASSIGNMENT END: fix_vec_dot

; Schreiben sie allen code der main funktion innerhalb von %ifndef %endif
%ifndef era_test

; Speicherplatz für test Vektoren
section .bss
  v1: resd 6
  v2: resd 6
section .text

; Die main funktion stellt einen einfachen Beispielaufruf der zu
; implementierenden funktion dar.
global CMAIN
CMAIN:
  mov ebp, esp
  ; Sie können diese main funktion beliebig erweitern um eigene tests
  ; durchzuführen.
  ; missing: set values in v1
  mov dword [v1], 67108864
  mov dword [v1+4], 0
  mov dword [v1+8], 67108864
  mov dword [v1+12], 0
  mov dword [v1+16], 67108864
  mov dword [v1+20], 0
  ; missing: set values in v2
  mov dword [v2], 4227858432
  mov dword [v2+4], 4294967295
  mov dword [v2+8], 4227858432
  mov dword [v2+12], 4294967295
  mov dword [v2+16], 4227858432
  mov dword [v2+20], 4294967295
  push dword v2
  push dword v1
  call fix_vec_dot_asm
  add esp, 8
  ;result in edx:eax
  PRINT_HEX 4, edx
  NEWLINE
  PRINT_HEX 4, eax
  ret
%endif ; era_test
