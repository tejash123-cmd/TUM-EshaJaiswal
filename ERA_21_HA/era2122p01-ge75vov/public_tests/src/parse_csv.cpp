// -----------------------------------------------------------------------------
// Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
// Fakultät für Informatik, Technische Universität München
// -----------------------------------------------------------------------------

#include "parse_csv.hpp"

#include <string>
#include <cstdlib>

#include <iostream>

csv::line_t csv::parse_line(std::istream &in) {
  line_t line{};
  std::string l;
  std::getline(in, l);
  //std::cout << l << std::endl;
  std::size_t last = 0;
  std::size_t next = 0;
  std::size_t id = 0;
  while ((next = l.find(";", last)) != std::string::npos) {
    fix_t_t i = std::atoll(l.substr(last, next-last).c_str());
    //std::cout << i << std::endl;
    line[id] = i;
    ++id;
    last = next + 1;
  }
  if (last < l.size()) {
    fix_t_t i = std::atoll(l.substr(last).c_str());
    //std::cout << i << std::endl;
    line[id] = i;
  }
  return line;
}
