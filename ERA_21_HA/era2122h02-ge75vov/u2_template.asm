; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; Ausgabe der Testergebnisse in Dezimal oder Hexadezimal
;%define print_as_hex ; Verwenden sie dies für hexadezimale Ausgaben
%define print_as_dec ; Verwenden sie dies für dezimale Ausgaben

; Include von Boilerplate, etc
%include "u2_test.inc"

; Export der Symbole mul_pi & div_pi
global mul_pi
global div_pi

section .text

; Implementieren Sie hier die Hausaufgabe 5.2a von dem Übungsblatt 2.
; Schreiben sie ein Unterprogramm, dass eine 8.8 Festkommazahl in AX mit
; PI (3.141592) multipliziert und das Ergebnis in AX zurückgibt.
;
; Eingabe:
;   AX: eine vorzeichenlose 8.8 Festkomma Zahl
; Ausgabe:
;   AX: eine vorzeichenlose 8.8 Festkomma Zahl
; Die folgenden Register müssen unverändert sein:
;   EBP, ESP
; Schreiben sie ihre Implementation zwischen die markierten Stellen!
mul_pi:
push ebp 
push esp


mov ebx, 0 

mov bx, 804
mul bx
mov al, ah 
mov ah,dl

 
pop esp 
pop ebp 
; Start ------------------------------------------------------------------------
; Ende -------------------------------------------------------------------------
  ret

; Implementieren sie hier die Hausaufgabe 5.2b von dem Übungsblatt 2.
; Schreiben sie ein Unterprogramm, dass eine 8.8 Festkommazahl in AX durch
; PI (3.141592) dividiert und das Ergebnis in AX zurückgibt.
;
; Eingabe:
;   AX: eine vorzeichenlose 8.8 Festkomma Zahl
; Ausgabe:
;   AX: eine vorzeichenlose 8.8 Festkomma Zahl
; Die folgednen Register müssen unverändert sein:
;   EBP, ESP
; Schreiben sie ihre Implementation zwischen die markierten Stellen!
div_pi:
push ebp 
push esp 
 



; Start -------------------------------------------------------------------
mov dx, 0 

mov bx, 804 
div bx 
mov ah,al 
mov al, dl

 ;mov al,0 

pop esp 
pop ebp 


; Ende -------------------------------------------------------------------------
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

  ; Parameterübergabe und Funktionsaufruf
  mov ax, 1000 ; 3.90625
  call mul_pi
  ; Ausgabe der Ergebnisse
  PRINT_STRING "1000 (03.E8) * pi ="
  NEWLINE
  PRINT_STRING "Dezimal Ergebnis : "
  PRINT_DEC 2, ax
  NEWLINE
  PRINT_STRING "Hex Ergebnis     : 0x"
  PRINT_HEX 2, ax
  NEWLINE
  NEWLINE

  ; Parameterübergabe und Funktionsaufruf
  mov ax, 3141 ; 12.26953125
  call div_pi
  ; Ausgabe der Ergebnisse
  PRINT_STRING "3141 (0C.45) / pi ="
  NEWLINE
  PRINT_STRING "Dezimal Ergebnis : "
  PRINT_UDEC 2, ax
  NEWLINE
  PRINT_STRING "Hex Ergebnis     : 0x"
  PRINT_HEX 2, ax
  NEWLINE
  NEWLINE

  ; Aufruf der öffentlichen Tests
  call test_main
  ret

%endif

; Öffentliche Tests
; Diese Tests rufen ihr implementiertes Unterprogramm auf und vergleichen ob
; das Ergebnis mit dem erwarteten Ergebnis übereinstimmt. Ihre Implementation
; _muss_ diese Aufrufe _korrekt_ erfüllen um Hausaufgaben Punkte in dieser
; Hausaufgabe zu erhalten.
; Diese Tests stellen nicht alle tests dar, die durchgeführt werden, sondern nur
; das Minimum erfüllter Tests um Punkte zu erhalten. Um volle Punktzahl zu
; erhalten muss ihre implementation für alle validen Eingaben das korrekte
; Ergebnis produzieren.
;
tests:
  ; Syntax: test_mul_pi INPUT, EXPECTED_RESULT
  test_mul_pi    0,    0 ; 0.0 * 3.141592 = 0.0
  test_mul_pi 1000, 3140 ; 3.90625 * 3.141592 = 12.265625
  test_mul_pi 3141, 9864 ; 12.26953125 * 3.141592 = 38.53125
  ; Syntax: test_div_pi INPUT, EXPECTED_RESULT
  test_div_pi    0,    0 ; 0.0 / 3.141592 = 0.0
  test_div_pi 3141, 1000 ; 12.26953125 / 3.141592 = 3.90625
  test_div_pi 9867, 3141 ; 38.54296875 / 3.141592 = 12.26953125
  ret
