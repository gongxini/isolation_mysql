//
// Created by yigonghu on 1/25/22.
//

#ifndef _rkdef_h
#define _rkdef_h

#include <vector>
#include <chrono>
#include <atomic>
#include <pthread.h>

using namespace std::chrono;

enum RecType { DOCMD, DOCMD_BGN, DOCMD_END, DLCK, DLCK_BGN, DLCK_END };

struct Rec {
  RecType rec_type;
  pthread_t tid;  // assume the pointer are different
  long long duration;
};

#define RKLOGMAX 10000000
extern std::atomic_size_t all_log_count;
extern std::vector<Rec> all_log;

inline void put_log(RecType r, pthread_t t, long long d) {
  size_t count = all_log_count++;
  if (count < RKLOGMAX) {
    all_log[count].rec_type = r;
    all_log[count].tid = t;
    all_log[count].duration = d;
  }
}

#endif //_rkdef_h
