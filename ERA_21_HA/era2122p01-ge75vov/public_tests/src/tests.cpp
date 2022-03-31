// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#include "tests.hpp"

constexpr bool verbose = false;

#include <iostream>

void test_add(const csv::line_t l) {
  ++add_run;
  auto res = fix_add_asm(l[1], l[2]);
  if (res == l[3]) {
    ++add_succ;
    if (verbose)
    std::cout << "success: " << fix_t{l[1]} << " + " << fix_t{l[2]}
              << " = " << fix_t{res} << '\n';
  } else {
    ++add_fail;
    std::cout << "failure: " << fix_t{l[1]} << " + " << fix_t{l[2]}
              << " expected: " << fix_t{l[3]}
              << " actual: " << fix_t{res} << '\n';
  }
}

void test_mul(const csv::line_t l) {
  ++mul_run;
  auto res = fix_mul_asm(l[1], l[2]);
  if (res == l[3]) {
    ++mul_succ;
    if (verbose)
    std::cout << "success: " << fix_t{l[1]} << " * " << fix_t{l[2]}
              << " = " << fix_t{res} << '\n';
  } else {
    ++mul_fail;
    std::cout << "failure: " << fix_t{l[1]} << " * " << fix_t{l[2]}
              << " expected: " << fix_t{l[3]}
              << " actual: " << fix_t{res} << '\n';
  }
}

void test_sub(const csv::line_t l) {
  ++sub_run;
  auto res = fix_sub_asm(l[1], l[2]);
  if (res == l[3]) {
    ++sub_succ;
    if (verbose)
    std::cout << "success: " << fix_t{l[1]} << " - " << fix_t{l[2]}
              << " = " << fix_t{res} << '\n';
  } else {
    ++sub_fail;
    std::cout << "failure: " << fix_t{l[1]} << " - " << fix_t{l[2]}
              << " expected: " << fix_t{l[3]}
              << " actual: " << fix_t{res} << '\n';
  }
}

void test_vec_add(const csv::line_t l) {
  ++vec_add_run;
  fix_vec_t e1{l[1], l[2], l[3]};
  fix_vec_t e2{l[4], l[5], l[6]};
  fix_vec_t e3{l[7], l[8], l[9]};
  fix_vec_t res{};
  fix_vec_add_asm(&e1.el1.data, &e2.el1.data, &res.el1.data);
  if (res == e3) {
    ++vec_add_succ;
    if (verbose)
    std::cout << "success: " << e1 << " + " << e2
              << " = " << res << '\n';
  } else {
    ++vec_add_fail;
    std::cout << "failure: " << e1 << " + " << e2
              << " expected: " << e3 << " actual: " << res << '\n';
  }
}

void test_vec_cross(const csv::line_t l) {
  ++vec_cross_run;
  fix_vec_t e1{l[1], l[2], l[3]};
  fix_vec_t e2{l[4], l[5], l[6]};
  fix_vec_t e3{l[7], l[8], l[9]};
  fix_vec_t res{};
  fix_vec_cross_asm(&e1.el1.data, &e2.el1.data, &res.el1.data);
  if (res == e3) {
    ++vec_cross_succ;
    if (verbose)
    std::cout << "success: " << e1 << " X " << e2
              << " = " << res << '\n';
  } else {
    ++vec_cross_fail;
    std::cout << "failure: " << e1 << " X " << e2
              << " expected: " << e3 << " actual: " << res << '\n';
  }
}

void test_vec_dot(const csv::line_t l) {
  ++vec_dot_run;
  fix_vec_t e1{l[1], l[2], l[3]};
  fix_vec_t e2{l[4], l[5], l[6]};
  auto res = fix_vec_dot_asm(&e1.el1.data, &e2.el1.data);
  if (res == l[7]) {
    ++vec_dot_succ;
    if (verbose)
    std::cout << "success: " << e1 << " . " << e2
              << " = " << fix_t{res} << '\n';
  } else {
    ++vec_dot_fail;
    std::cout << "failure: " << e1 << " . " << e2
              << " expected: " << fix_t{l[7]}
              << " actual: " << fix_t{res} << '\n';
  }
}

void test_vec_sub(const csv::line_t l) {
  ++vec_sub_run;
  fix_vec_t e1{l[1], l[2], l[3]};
  fix_vec_t e2{l[4], l[5], l[6]};
  fix_vec_t e3{l[7], l[8], l[9]};
  fix_vec_t res{};
  fix_vec_sub_asm(&e1.el1.data, &e2.el1.data, &res.el1.data);
  if (res == e3) {
    ++vec_sub_succ;
    if (verbose)
    std::cout << "success: " << e1 << " - " << e2
              << " = " << res << '\n';
  } else {
    ++vec_sub_fail;
    std::cout << "failure: " << e1 << " - " << e2
              << " expected: " << e3 << " actual: " << res << '\n';
  }
}
