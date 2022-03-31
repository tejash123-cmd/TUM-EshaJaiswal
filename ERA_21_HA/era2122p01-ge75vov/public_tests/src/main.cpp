// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#include "definitions.hpp"
// #include "generate.hpp"
#include "parse_csv.hpp"
#include "student_imp.hpp"
#include "tests.hpp"

#include <iostream>
#include <random>
#include <fstream>

int main(int argc, char **argv) {
  std::string fname{"test_data.csv"};
  if (argc > 1) fname = argv[1];
  auto in = std::ifstream(fname);
  if (!in) {
    std::cout << "Failed opening file \"" << fname << "\"" << std::endl;
    return -1;
  }
  fix_t_t type = 0;
  do {
    auto l = csv::parse_line(in);
    if (type != l[0]) std::cout << std::endl;
    type = l[0];
    switch (type) {
      case 1: test_add(l); break;
      case 2: test_mul(l); break;
      case 3: test_sub(l); break;
      case 4: test_vec_add(l); break;
      case 5: test_vec_cross(l); break;
      case 6: test_vec_dot(l); break;
      case 7: test_vec_sub(l); break;
    }
    // for (const auto i : l) std::cout << i << ";";
    // std::cout << std::endl;
  } while (type != 0);

  std::cout << std::dec << std::endl;
  std::cout << "fix_add:       " << add_succ << "/" << add_run << " passed\n";
  std::cout << "fix_mul:       " << mul_succ << "/" << mul_run << " passed\n";
  std::cout << "fix_sub:       " << sub_succ << "/" << sub_run << " passed\n";
  std::cout << "fix_vec_add:   " << vec_add_succ << "/" << vec_add_run
            << " passed\n";
  std::cout << "fix_vec_cross: " << vec_cross_succ << "/" << vec_cross_run
            << " passed\n";
  std::cout << "fix_vec_dot:   " << vec_dot_succ << "/" << vec_dot_run
            << " passed\n";
  std::cout << "fix_vec_sub:   " << vec_sub_succ << "/" << vec_sub_run
            << " passed" << std::endl;

  return 0;
}
