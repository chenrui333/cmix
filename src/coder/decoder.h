#ifndef DECODER_H
#define DECODER_H

#include <fstream>

#include "../predictor.h"

class Decoder {
 public:
  Decoder(std::ifstream* is, unsigned long long file_size);
  int Decode();  // Returns 0 or 1.

 private:
  int ReadByte();

  std::ifstream* is_;
  unsigned int x1_, x2_, x_;
  Predictor p_;
};

#endif