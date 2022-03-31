; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; Include von Boilerplate, etc
%include "u5_test.inc"

; Export des Symbols mirror
global mirror

section .text

; TODO Aufgabenstellung
; ebx: display address
mirror:
; Start ------------------------------------------------------------------------

; Ende -------------------------------------------------------------------------
ret

; Example Displays
section .data
display_beispiel: dd 0x08F080F8, 0x00708808
display_0: dd 0x84844830, 0x30488484
display_1: dd 0x20A06020, 0xF8202020
display_2: dd 0x04242418, 0x7C201008
display_3: dd 0x38044438, 0x38440408
display_4: dd 0x48282818, 0x0808FC48
display_5: dd 0x7840407C, 0x38440444
display_6: dd 0x78402018, 0x38444444
display_7: dd 0x1008047E, 0x20202010
display_8: dd 0x38484830, 0x38444444
display_9: dd 0x1C242418, 0x18242404

display_0_r: dd 0x2121120C, 0x0C122121
display_1_r: dd 0x04050604, 0x1F040404
display_2_r: dd 0x20242418, 0x3E040810
display_3_r: dd 0x1C20221C, 0x1C222010
display_4_r: dd 0x12141418, 0x10103F12
display_5_r: dd 0x1E02023E, 0x1C222022
display_6_r: dd 0x1E020418, 0x1C222222
display_7_r: dd 0x0810207E, 0x04040408
display_8_r: dd 0x1C12120C, 0x1C222222
display_9_r: dd 0x38242418, 0x18242420

section .text

; Schreiben sie allen code der main funktion innerhalb von %ifndef %endif
%ifndef era_test

; Die main funktion stellt einen einfachen Beispielaufruf der zu
; implementierenden funktion dar.
global CMAIN
CMAIN:
  mov ebp, esp
  ; Sie können diese main funktion beliebig erweitern um eigene tests
  ; durchzuführen.

  ; Ausgabe des Displays vor Aufruf
  mov ebx, display_beispiel
  call print_display

  ; Parameterübergabe und Funktionsaufruf
  mov ebx, display_beispiel
  call mirror

  ; Ausgabe der Ergebnisse
  PRINT_STRING "Gespiegeltes Display: "
  mov eax, [display_beispiel]
  mov ecx, [display_beispiel + 4]
  PRINT_HEX 4, eax
  PRINT_HEX 4, ecx
  NEWLINE

  ; Ausgabe des Displays nach Aufruf
  mov ebx, display_beispiel
  call print_display

  NEWLINE
  NEWLINE

  ; Aufruf der öffentlichen Tests
  call test_main
  ret

%endif

; Öffentliche Tests / Public Tests
; Diese Tests rufen ihr implementiertes Unterprogramm auf und vergleichen ob
; das Ergebnis mit dem erwarteten Ergebnis übereinstimmt. Ihre Implementation
; _muss_ diese Aufrufe _korrekt_ erfüllen um Hausaufgaben Punkte in dieser
; Hausaufgabe zu erhalten.
; Diese Tests stellen nicht alle tests dar, die durchgeführt werden, sondern nur
; das Minimum erfüllter Tests um Punkte zu erhalten. Um volle Punktzahl zu
; erhalten muss ihre implementation für alle validen Eingaben das korrekte
; Ergebnis produzieren.
tests:
  ; run tests, syntax: test_mirror display address,
  ;                                1st Dword of expcected result,
  ;                                2nd Dword of expcected result
  test_mirror display_0, 0x2121120C, 0x0C122121
  test_mirror display_1, 0x04050604, 0x1F040404
  test_mirror display_2, 0x20242418, 0x3E040810
  test_mirror display_3, 0x1C20221C, 0x1C222010
  test_mirror display_4, 0x12141418, 0x10103F12
  test_mirror display_5, 0x1E02023E, 0x1C222022
  test_mirror display_6, 0x1E020418, 0x1C222222
  test_mirror display_7, 0x0810207E, 0x04040408
  test_mirror display_8, 0x1C12120C, 0x1C222222
  test_mirror display_9, 0x38242418, 0x18242420
  test_mirror display_0_r, 0x84844830, 0x30488484
  test_mirror display_1_r, 0x20A06020, 0xF8202020
  test_mirror display_2_r, 0x04242418, 0x7C201008
  test_mirror display_3_r, 0x38044438, 0x38440408
  test_mirror display_4_r, 0x48282818, 0x0808FC48
  test_mirror display_5_r, 0x7840407C, 0x38440444
  test_mirror display_6_r, 0x78402018, 0x38444444
  test_mirror display_7_r, 0x1008047E, 0x20202010
  test_mirror display_8_r, 0x38484830, 0x38444444
  test_mirror display_9_r, 0x1C242418, 0x18242404
  ret
