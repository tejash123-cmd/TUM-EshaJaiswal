; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; ignore this, this is just to check if symbol is properly linkable
section .text
extern mul_pi
extern div_pi
call mul_pi
call div_pi
