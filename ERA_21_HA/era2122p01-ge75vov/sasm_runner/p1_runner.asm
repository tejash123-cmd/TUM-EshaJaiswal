; ---------------------------------------------------------------------------------------------
; Written by Jade
; ---------------------------------------------------------------------------------------------

section .bss
  res_vec: resq 3

section .data
  test_vec_1: dq 1, 0, 0
  test_vec_2: dq 1, 0, 0

section .text

; space for student implementation ---------------------------------------------
student_implementation:
  ret

global _main

; only run one test at a time
_main:
  push ebp
  mov ebp, esp
  call test_add_sub_mul
  ;call test_vec_add_sub_cross
  ;call test_vec_dot
  pop ebp
  ret

test_add_sub_mul:
  push ebp
  mov ebp, esp
  push dword [test_vec_2 + 4]
  push dword [test_vec_2 + 0]
  push dword [test_vec_1 + 4]
  push dword [test_vec_1 + 0]
  call student_implementation
  nop ; set breakpoint here to look at result ----------------------------------
  mov esp, ebp
  pop ebp
  ret

test_vec_add_sub_cross:
  push ebp
  mov ebp, esp
  push res_vec
  push test_vec_2
  push test_vec_1
  call student_implementation
  nop ; set breakpoint here to look at result ----------------------------------
  mov esp, ebp
  pop ebp
  ret

test_vec_dot:
  push ebp
  mov ebp, esp
  push test_vec_2
  push test_vec_1
  call student_implementation
  nop ; set breakpoint here to look at result ----------------------------------
  mov esp, ebp
  pop ebp
  ret
