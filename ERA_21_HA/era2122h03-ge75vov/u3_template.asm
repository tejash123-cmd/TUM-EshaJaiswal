; ------------------------------------------------------------------------------
; TODO: copyright TUM etc
; ------------------------------------------------------------------------------

; Include von Boilerplate, etc
%include "u3_test.inc"

; Export des Symbols set_pixel
global set_pixel
global display_start

; Konstanten für die Größe des Displays
x_size: equ 1920
y_size: equ 1080
px_size: equ 4

section .bss
; Speicherreservierung für ein Display
display_start: resb x_size * y_size * px_size

section .text

; Implementieren Sie hier die Hausaufgabe 6b von dem Übungsblatt 3.
; Schreiben sie ein Unterprogramm, das das Pixel an der Koordinate (EAX, EBX)
; in dem display auf die Farbe in ECX setzt. Die Wertebereiche von X und Y
; müssen nicht überprüft werden.
;
; Eingabe:
;   EAX: X-Koordinate
;   EBX: Y-Koordinate
;   ECX: RGB-Wert
; Die folgenden Register müssen unverändert sein:
;   Alle, ausser EAX
; Schreiben sie ihre Implementation zwischen die markierten Stellen!
set_pixel:
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
  mov eax, 100 ; x = 100
  mov ebx, 200 ; y = 200
  mov ecx, 0x00bd6500 ; TUM blue 0, 101, 189
  call set_pixel
  ; Ausgabe der Ergebnisse
  PRINT_STRING "Pixel Wert an (100, 200): "
  NEWLINE
  ; red
  mov dl, [display_start + 1536400]
  PRINT_STRING "r: "
  PRINT_UDEC 1, dl
  NEWLINE
  ; green
  mov dl, [display_start + 1536401]
  PRINT_STRING "g: "
  PRINT_UDEC 1, dl
  NEWLINE
  ; blue
  mov dl, [display_start + 1536402]
  PRINT_STRING "b: "
  PRINT_UDEC 1, dl
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
  ; run tests, syntax: test_set_pixel X, Y, COLOR, OFFSET
  ; TODO
  test_set_pixel  100,  200, 0x00bd6500, 1536400
  test_set_pixel    0,    0, 0x00010101,       0
  test_set_pixel    0,    1, 0x00000001,    7680
  test_set_pixel    1,    0, 0x00010000,       4
  test_set_pixel 1919, 1079, 0x00FFFFFF, 8294396
  ret
