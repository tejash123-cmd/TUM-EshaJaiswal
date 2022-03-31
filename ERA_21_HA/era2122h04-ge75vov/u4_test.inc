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
s_test_rec_passed: db "Test passed: recursive", 9, 9, " %d! = %d", 10, 0
s_test_rec_failed: db "Test failed: recursive", 9, 9, " %d! = %d Expected: %d", 10, 0
s_test_non_rec_passed: db "Test passed: non recursive", 9, " %d! = %d", 10, 0
s_test_non_rec_failed: db "Test failed: non recursive", 9, " %d! = %d Expected: %d", 10, 0
s_test_finished: db 10, "Tests finished, %d / %d tests passed", 10, 10, 0

section .text
; this macro runs fac_rec and fac_non_rec with the given arguments and compares
; the results with the expected result
; param 1: n
; param 2: expected result
%macro test_fac 2
  ; test recursive version
  sub esp, 4
  push dword %1
  call fac_rec
  inc dword [i_tests_ran]
  mov eax, [esp + 4] ; result
  add esp, 8 ; cleanup stack
  cmp eax, %2
  jne %%.test_rec_failed
  inc dword [i_tests_succeeded]
  push eax
  push dword %1
  push s_test_rec_passed
  call printf
  add esp, 3*4
  jmp %%.test_rec_continue
  %%.test_rec_failed:
  inc dword [i_tests_failed]
  push dword %2
  push eax
  push dword %1
  push s_test_rec_failed
  call printf
  add esp, 4*4
  %%.test_rec_continue:
  ; test non recursive version
  sub esp, 4
  push dword %1
  call fac_non_rec
  inc dword [i_tests_ran]
  mov eax, [esp + 4] ; result
  add esp, 8 ; cleanup stack
  cmp eax, %2
  jne %%.test_non_rec_failed
  inc dword [i_tests_succeeded]
  push eax
  push dword %1
  push s_test_non_rec_passed
  call printf
  add esp, 3*4
  jmp %%.test_non_rec_continue
  %%.test_non_rec_failed:
  inc dword [i_tests_failed]
  push dword %2
  push eax
  push dword %1
  push s_test_non_rec_failed
  call printf
  add esp, 4*4
  %%.test_non_rec_continue:
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
%macro test_fac 2
%endmacro
%endif ; era_secret_test

%endif ; era_test_inc
