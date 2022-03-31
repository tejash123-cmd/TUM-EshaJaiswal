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
%endif

%ifdef era_os_lin ; Linux
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

%endif ; era_test_inc
