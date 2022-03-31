; ------------------------------------------------------------------------------
; Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
; Fakultät für Informatik, Technische Universität München
; ------------------------------------------------------------------------------

%ifndef era_underscore_helper
%define era_underscore_helper

%ifdef era_os_win
extern fix_add_asm
extern fix_sub_asm
extern fix_mul_asm
extern fix_vec_add_asm
extern fix_vec_sub_asm
extern fix_vec_dot_asm
extern fix_vec_cross_asm

global _fix_add_asm
global _fix_sub_asm
global _fix_mul_asm
global _fix_vec_add_asm
global _fix_vec_sub_asm
global _fix_vec_dot_asm
global _fix_vec_cross_asm

; this isn't pretty but it works, probably

_fix_add_asm: jmp fix_add_asm
_fix_sub_asm: jmp fix_sub_asm
_fix_mul_asm: jmp fix_mul_asm
_fix_vec_add_asm: jmp fix_vec_add_asm
_fix_vec_sub_asm: jmp fix_vec_sub_asm
_fix_vec_dot_asm: jmp fix_vec_dot_asm
_fix_vec_cross_asm: jmp fix_vec_cross_asm
%endif ; era_os_win

%endif ; era_underscore_helper
