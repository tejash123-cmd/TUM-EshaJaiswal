// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#ifndef ERA_FIXED_POINT_PROJECT_PUBLIC_TESTS
#define ERA_FIXED_POINT_PROJECT_PUBLIC_TESTS

#include "definitions.hpp"
#include "parse_csv.hpp"
#include "student_imp.hpp"

inline std::size_t add_run = 0, add_succ = 0, add_fail = 0;
inline std::size_t mul_run = 0, mul_succ = 0, mul_fail = 0;
inline std::size_t sub_run = 0, sub_succ = 0, sub_fail = 0;
inline std::size_t vec_add_run = 0, vec_add_succ = 0, vec_add_fail = 0;
inline std::size_t vec_cross_run = 0, vec_cross_succ = 0, vec_cross_fail = 0;
inline std::size_t vec_dot_run = 0, vec_dot_succ = 0, vec_dot_fail = 0;
inline std::size_t vec_sub_run = 0, vec_sub_succ = 0, vec_sub_fail = 0;

void test_add(const csv::line_t line);
void test_mul(const csv::line_t line);
void test_sub(const csv::line_t line);
void test_vec_add(const csv::line_t line);
void test_vec_cross(const csv::line_t line);
void test_vec_dot(const csv::line_t line);
void test_vec_sub(const csv::line_t line);

#endif // ERA_FIXED_POINT_PROJECT_PUBLIC_TESTS
