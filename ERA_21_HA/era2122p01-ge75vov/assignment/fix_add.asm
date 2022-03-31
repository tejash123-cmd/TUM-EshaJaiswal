; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%include "fix_era.inc"

section .text

global fix_add_asm

;
; This is how a possible solution looks like
;
fix_add_asm:
  push ebp
  mov ebp, esp
  push ebx
  mov eax, [ebp + 8]
  mov edx, [ebp + 16]

  add eax, edx

  mov edx, [ebp + 12]
  mov ebx, [ebp + 20]
  adc edx, ebx
  pop ebx
  pop ebp
  ret

; Schreiben sie allen code der main funktion innerhalb von %ifndef %endif
%ifndef era_test
; Die main funktion stellt einen einfachen Beispielaufruf der zu
; implementierenden funktion dar.
global CMAIN
CMAIN:
  mov ebp, esp
  ; Sie können diese main funktion beliebig erweitern um eigene tests
  ; durchzuführen.
  push dword 0
  push dword 6710
  push dword 0
  push dword 134217728
  call fix_add_asm
  add esp, 16
  cmp eax, 134224438
  jne .fail1
  cmp edx, 0
  jne .fail1

  push dword 1561628
  push dword 1073741824
  push dword 233408
  push dword 738197504
  call fix_add_asm      ; call test program
  add esp, 16
  cmp eax, 1811939328
  jne .fail2
  cmp edx, 1795036
  jne .fail2
  PRINT_STRING "Success"
  ret

.fail1:
  PRINT_STRING "Wrong result in test 1:"
  NEWLINE
  PRINT_DEC 4, edx
  NEWLINE
  PRINT_DEC 4, eax
  NEWLINE
  PRINT_STRING "Correct result:"
  NEWLINE
  PRINT_STRING "0"
  NEWLINE
  PRINT_STRING "134224438"
  NEWLINE
  ret

.fail2:
  PRINT_STRING "Wrong result in test 2:"
  NEWLINE
  PRINT_DEC 4, edx
  NEWLINE
  PRINT_DEC 4, eax
  NEWLINE
  PRINT_STRING "Correct result:"
  NEWLINE
  PRINT_STRING "1795036"
  ret
%endif ; era_test
