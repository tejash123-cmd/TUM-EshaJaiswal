; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; Note:
; Sie brauchen den Code in dieser Datei nicht zu verstehen. Dies ist nur
; boilerplate und macro code damit die Tests richtig funktionieren.
;
; You don't need to understand anything within this file. This file contains a
; lot of boilerplate and macros to make the tests work properly

%ifndef era_test_inc
%define era_test_inc

%ifdef era_secret_test
  %define era_test
  %undef era_os_win
%endif

%ifdef era_os_win ; Windows
  %ifndef CMAIN
    %define CMAIN _main
  %endif

  %macro import_extern 1
    extern _%1
    %ifndef %1
    %define %1 _%1
    %endif
  %endmacro

%else ; Linux
  %ifndef CMAIN
    %define CMAIN main
  %endif

  %macro import_extern 1
    extern %1
  %endmacro
%endif ; era_os_win

section .text
import_extern printf

%ifdef era_os_win ; Windows
  %ifndef era_test
    %include "io_win.inc"
  %endif
%else ; Linux
  %ifndef era_test
    %include "io_lin.inc"
  %endif
%endif ; era_os_win

%ifndef era_secret_test

section .data
i_tests_ran: dd 0
i_tests_succeeded: dd 0
i_tests_failed: dd 0
s_print_charset: db " ", 0, 0, 0, "#", 0, 0, 0
s_display_line: db "%c%c%c%c%c%c%c%c", 10, 0
s_test_passed: db "Test passed: %#X %#X", 10, 0
s_test_failed: db "Test failed: %#X %#X Expected %#X %#X", 10, 0
s_compare_line: db "%c%c%c%c%c%c%c%c : %c%c%c%c%c%c%c%c", 10, 0
s_test_finished: db 10, "Tests finished, %d / %d tests passed", 10, 10, 0

section .text

; print display ----------------------------------------------------------------
; ebx: display address
print_display:
  push eax
  push ecx
  %assign i 0
  %rep 8
    mov al, [ebx + i]
    call print_line
    %assign i i+1
  %endrep
  ; leave
  pop ecx
  pop eax
  ret

; prints a single line of a display
print_line:
  xor ecx, ecx
  %rep 8
    mov cl, al
    and cl, 1
    push dword [s_print_charset + 4*ecx]
    shr al, 1
  %endrep
  push s_display_line
  call printf
  add esp, 4*9
  ret

; print display comparison -----------------------------------------------------
; esi: display 1
; edi: display 2
print_display_compare:
  push eax
  push ebx
  push ecx
  %assign i 0
  %rep 8
    mov al, [esi + i]
    mov bl, [edi + i]
    call print_compare_line
    %assign i i+1
  %endrep
  ; leave
  pop ecx
  pop ebx
  pop eax
  ret

; prints a single line of a display comparison
print_compare_line:
  xor ecx, ecx
  %rep 8
    mov cl, bl
    and cl, 1
    push dword [s_print_charset + 4*ecx]
    shr bl, 1
  %endrep
  %rep 8
    mov cl, al
    and cl, 1
    push dword [s_print_charset + 4*ecx]
    shr al, 1
  %endrep
  push s_compare_line
  call printf
  add esp, 4*17
  ret

; test macro -------------------------------------------------------------------
; param 1: display address to be mirrored
; param 2: first half of expected result
; param 3: second half of expected result
%macro test_mirror 3
  mov ebx, %1
  call mirror
  inc dword [i_tests_ran]
  cmp dword [%1], %2
  jne %%.test_failed
  cmp dword [%1 + 4], %3
  jne %%.test_failed
  inc dword [i_tests_succeeded]
  push dword [%1 + 4]
  push dword [%1]
  push s_test_passed
  call printf
  add esp, 4*3
  call print_display
  jmp %%.test_continue
  %%.test_failed:
  inc dword [i_tests_failed]
  push dword %3
  push dword %2
  push dword [%1 + 4]
  push dword [%1]
  push s_test_failed
  call printf
  add esp, 4
  mov esi, %1 ; display 1
  lea edi, [esp + 8] ; reference display on stack
  call print_display_compare
  add esp, 4*4
  %%.test_continue:
%endmacro

; run the tests and print the success rate
test_main:
  mov ebp, esp
  ; run the tests
  call tests
  ; print success rate
  push dword [i_tests_ran]
  push dword [i_tests_succeeded]
  push s_test_finished
  call printf
  add esp, 12
  ret

%ifdef era_test
global CMAIN
CMAIN: jmp test_main
%endif

%else ; era_secret_test
%macro test_mirror 3
%endmacro
%endif ; era_secret_test

%endif ; era_test_inc
