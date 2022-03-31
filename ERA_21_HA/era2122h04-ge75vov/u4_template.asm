; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; Include von Boilerplate, etc
%include "u4_test.inc"

; Export der Symbole fac_rec und fac_non_rec
global fac_rec
global fac_non_rec

section .text

; Implementieren Sie hier die Hausaufgabe 6.1 von dem Übungsblatt 4.
; Schreiben sie ein Unterprogramm, dass _rekursiv_ die Fakultät einer über
; den Stack übergebenen Zahl 'n' berechnet. Das Ergebnis soll hierbei auf dem
; Stack zurückgegeben werden.
;
; Eingabe:
;   1. Stack Parameter: n
;   2. Stack Parameter: Platz für Rückgabewert
; Ausgabe:
;   2. Stack Parameter: n!
; Folgende Register müssen nach Unterprogrammsende wiederhergestellt sein:
;   EAX, EBX, ECX, EDX, ESI, EDI, EBP, ESP
; Schreiben sie ihre Implementation zwischen die markierten Stellen!
fac_rec:
; Start ------------------------------------------------------------------------
push ebp
mov ebp,esp
;ruckgabewert: [ebp+12]
;n: [ebp+8]
push ebx
push eax

mov eax, [ebp+8] ;eax<-n

cmp eax, 1 
jg fac ;if n>1 => fac_rec 

;if n<=1 
mov eax,1
jmp fac_ret  ;retrun


fac:

mov ebx, eax 
dec eax 
sub esp, 4
push eax 
call fac 
add esp, 4 
push eax 
call fac_rec
add esp, 4
pop eax
 imul eax, ebx 
 
 fac_ret: 
 mov [ebp+12], eax 
 pop eax
  pop ebx 
  pop ebp
; Ende -------------------------------------------------------------------------
  ret

; Implementieren Sie hier die Hausaufgabe 6.2 von dem Übungsblatt 4.
; Schreiben sie ein Unterprogramm, dass _nicht rekursiv_ die Fakultät einer über
; den Stack übergebenen Zahl 'n' berechnet. Das Ergebnis soll hierbei auf dem
; Stack zurückgegeben werden.
;
; Eingabe:
;   1. Stack Parameter: n
;   2. Stack Parameter: Platz für Rückgabewert
; Ausgabe:
;   2. Stack Parameter: n!
; Folgende Register müssen nach Unterprogrammsende wiederhergestellt sein:
;   EAX, EBX, ECX, EDX, ESI, EDI, EBP, ESP
; Schreiben sie ihre Implementation zwischen die markierten Stellen!
fac_non_rec:
; Start ------------------------------------------------------------------------

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
    sub esp, 4 ; space for return value
    push dword 6
    call fac_non_rec
    ; Ausgabe der Ergebnisse / Printing out the results
    PRINT_STRING "non-recursive: 6! = "
    add esp, 4
    pop eax
    PRINT_UDEC 4, eax
    NEWLINE
    NEWLINE

    sub esp, 4 ; space for return value
    push dword 6
    call fac_rec
    ; Ausgabe der Ergebnisse / Printing out the results
    PRINT_STRING "recursive: 6! = "
    add esp, 4
    pop eax
    PRINT_UDEC 4, eax
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
tests:
  ; run tests, syntax: test_fac n, Expected_result
  test_fac  0,         1
  test_fac  1,         1
  test_fac  2,         2
  test_fac  3,         6
  test_fac  4,        24
  test_fac  5,       120
  test_fac  6,       720
  ret
