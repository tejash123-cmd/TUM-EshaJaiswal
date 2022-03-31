// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#ifndef ERA_FIXED_POINT_PROJECT_PUBLIC_DEFINITIONS
#define ERA_FIXED_POINT_PROJECT_PUBLIC_DEFINITIONS

#include <cstddef>
#include <cstdint>
#include <ostream>

constexpr std::size_t frac = 26;
constexpr std::size_t upper_frac = 64 - frac;

using fix_t_t = std::int64_t;
using ufix_t_t = std::uint64_t;

struct fix_t {
  fix_t_t data;
};

struct fix_vec_t {
  fix_t el1, el2, el3;
};

constexpr bool operator!=(fix_t a, fix_t b) {
  return a.data != b.data;
}

constexpr bool operator==(fix_t a, fix_t b) {
  return a.data == b.data;
}

constexpr bool operator!=(fix_vec_t v1, fix_vec_t v2) {
  return v1.el1 != v2.el1 || v1.el2 != v2.el2 || v1.el3 != v2.el3;
}

constexpr bool operator==(fix_vec_t v1, fix_vec_t v2) {
  return v1.el1 == v2.el1 && v1.el2 == v2.el2 && v1.el3 == v2.el3;
}

std::ostream &operator<<(std::ostream &strm, fix_t f);
std::ostream &operator<<(std::ostream &strm, fix_vec_t v);

#endif // ERA_FIXED_POINT_PROJECT_PUBLIC_DEFINITIONS
