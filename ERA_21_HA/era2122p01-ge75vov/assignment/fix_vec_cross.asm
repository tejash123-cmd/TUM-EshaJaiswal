; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_vec_cross_asm
; extern fix_mul_asm

;ASSIGNMENT START: fix_vec_cross
fix_vec_cross_asm:
  ret
;ASSIGNMENT END: fix_vec_cross

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
  ; write your own test code here
  ; missing: set values in v1
  ; missing: set values in v2
  push dword o
  push dword v2
  push dword v1
  call fix_vec_cross_asm
  add esp, 12
  ;o = v1 x v2
  ret
%endif ; era_test
