// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#ifndef ERA_FIXED_POINT_PROJECT_PUBLIC_STUDENT_IMP
#define ERA_FIXED_POINT_PROJECT_PUBLIC_STUDENT_IMP

#include "definitions.hpp"

extern "C" fix_t_t fix_add_asm(fix_t_t a, fix_t_t b);
extern "C" fix_t_t fix_mul_asm(fix_t_t a, fix_t_t b);
extern "C" fix_t_t fix_sub_asm(fix_t_t a, fix_t_t b);
extern "C" void    fix_vec_add_asm(const fix_t_t *v1, const fix_t_t *v2, fix_t_t *o);
extern "C" void    fix_vec_cross_asm(const fix_t_t *v1, const fix_t_t *v2, fix_t_t *o);
extern "C" fix_t_t fix_vec_dot_asm(const fix_t_t *v1, const fix_t_t *v2);
extern "C" void    fix_vec_sub_asm(const fix_t_t *v1, const fix_t_t *v2, fix_t_t *o);

#endif // ERA_FIXED_POINT_PROJECT_PUBLIC_STUDENT_IMP
