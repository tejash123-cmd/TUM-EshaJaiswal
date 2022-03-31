// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#include "definitions.hpp"

#include <ios>

namespace {
double to_double(fix_t f) {
  return double(f.data) / (1 << frac);
}
}

std::ostream &operator<<(std::ostream &strm, fix_t f) {
  strm << "[0x" << std::hex << static_cast<ufix_t_t>(f.data) << " = "
       << to_double(f) << "]";
  return strm;
}

std::ostream &operator<<(std::ostream &strm, fix_vec_t v) {
  strm << "{" << v.el1 << ";" << v.el2 << ";" << v.el3 << "}";
  return strm;
}
