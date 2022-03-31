// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#ifndef ERA_FIXED_POINT_PROJECT_PUBLIC_PARSE_CSV
#define ERA_FIXED_POINT_PROJECT_PUBLIC_PARSE_CSV

#include "definitions.hpp"

#include <array>
#include <istream>

namespace csv {
using line_t = std::array<fix_t_t, 10>;

line_t parse_line(std::istream &in);

}

#endif // ERA_FIXED_POINT_PROJECT_PUBLIC_PARSE_CSV
