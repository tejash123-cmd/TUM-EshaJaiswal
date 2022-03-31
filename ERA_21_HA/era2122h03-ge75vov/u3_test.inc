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
s_test_passed: db "Test passed: Color at %d, %d: %#X %#X %#X", 10, 0
s_test_failed: db "Test failed: Color at %d, %d: %#X %#X %#X Expected: %#X %#X %#X", 10, 0
s_test_finished: db 10, "Tests finished, %d / %d tests passed", 10, 10, 0

section .text
; this macro runs set_pixel with the given arguments and compares the display
; at the given offset
; param 1: x
; param 2: y
; param 3: color
; param 4: offset
%macro test_set_pixel 4
  mov eax, %1
  mov ebx, %2
  mov ecx, %3
  call set_pixel
  inc dword [i_tests_ran]
  mov edx, [display_start + %4]
  cmp ecx, edx
  jne %%.test_failed
  inc dword [i_tests_succeeded]
  mov eax, edx
  shr eax, 16
  and eax, 0xFF
  push eax
  mov eax, edx
  shr eax, 8
  and eax, 0xFF
  push eax
  and edx, 0xFF
  push edx
  push dword %2
  push dword %1
  push s_test_passed
  call printf
  add esp, 6*4
  jmp %%.test_continue
  %%.test_failed:
  inc dword [i_tests_failed]
  push dword (%4 >> 16) & 0xFF
  push dword (%4 >> 8) & 0xFF
  push dword %4 & 0xFF
  mov eax, edx
  shr eax, 16
  and eax, 0xFF
  push eax
  mov eax, edx
  shr eax, 8
  and eax, 0xFF
  push eax
  and edx, 0xFF
  push edx
  push dword %2
  push dword %1
  push s_test_failed
  call printf
  add esp, 9*4
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
%macro test_set_pixel 4
%endmacro
%endif ; era_secret_test

%endif ; era_test_inc
