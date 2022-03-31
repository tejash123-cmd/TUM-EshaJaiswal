; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; ignore this, this is just to check if symbol is properly linkable
section .text
extern set_pixel
extern display_start
call set_pixel
mov dword [display_start], display_start
