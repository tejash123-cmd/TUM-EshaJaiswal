; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

; ignore this, this is just to check if symbol is properly linkable
section .text
extern fac_rec
extern fac_non_rec
call fac_rec
call fac_non_rec
