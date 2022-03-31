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
%ifdef era_lan_english
s_test_passed_dec: db "Test passed: %d %c pi = %d", 10, 0
s_test_passed_hex: db "Test passed: %#X %c pi = %#X", 10, 0
s_test_failed_dec: db "Test failed: %d %c pi = %d Expected: %d", 10, 0
s_test_failed_hex: db "Test failed: %#X %c pi = %#X Expected: %#X", 10, 0
test_finished: db 10, "Tests finished, %d / %d tests passed", 10, 10, 0
%else
s_test_passed_dec: db "Test bestanden: %d %c pi = %d", 10, 0
s_test_passed_hex: db "Test bestanden: %#X %c pi = %#X", 10, 0
s_test_failed_dec: db "Test fehlgeschlagen: %d %c pi = %d Erwartet: %d", 10, 0
s_test_failed_hex: db "Test fehlgeschlagen: %#X %c pi = %#X Erwartet: %#X", 10, 0
test_finished: db 10, "Tests beendet, %d / %d tests bestanden", 10, 10, 0
%endif
; TODO: print as fixpoint number

%ifdef print_as_hex
%define s_test_passed s_test_passed_hex
%define s_test_failed s_test_failed_hex
%else
%define s_test_passed s_test_passed_dec
%define s_test_failed s_test_failed_dec
%endif

section .text
; this macro runs mul_pi with the given arguments and compares it
; with the expected result
; param 1: input
; param 2: expected output
%macro test_mul_pi 2
  mov ax, %1
  call mul_pi
  inc dword [i_tests_ran]
  cmp ax, %2
  jne %%.test_failed
  inc dword [i_tests_succeeded]
  movzx eax, ax
  push eax
  push dword '*'
  push dword %1
  push s_test_passed
  call printf
  add esp, 4*4
  jmp %%.test_continue
  %%.test_failed:
  inc dword [i_tests_failed]
  push dword %2
  movzx eax, ax
  push eax
  push dword '*'
  push dword %1
  push s_test_failed
  call printf
  add esp, 4*5
  %%.test_continue:
%endmacro

; this macro runs duv_pi with the given arguments and compares it
; with the expected result
; param 1: input
; param 2: expected output
%macro test_div_pi 2
  mov ax, %1
  call div_pi
  inc dword [i_tests_ran]
  cmp ax, %2
  jne %%.test_failed
  inc dword [i_tests_succeeded]
  movzx eax, ax
  push eax
  push dword '/'
  push dword %1
  push s_test_passed
  call printf
  add esp, 4*4
  jmp %%.test_continue
  %%.test_failed:
  inc dword [i_tests_failed]
  push dword %2
  movzx eax, ax
  push eax
  push dword '/'
  push dword %1
  push s_test_failed
  call printf
  add esp, 4*5
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
  push test_finished
  call printf
  add esp, 12
  ret

%ifdef era_test
global CMAIN
CMAIN: jmp test_main
%endif

%else ; era_secret_test
%macro test_mul_pi 2
%endmacro
%macro test_div_pi 2
%endmacro
%endif ; era_secret_test

%endif ; era_test_inc
