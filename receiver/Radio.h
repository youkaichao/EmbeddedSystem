#ifndef RADIO_H
#define RADIO_H

enum {
  AM_RADIO = 6,
  TIMER_PERIOD_MILLI = 250
};

typedef nx_struct Message {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
} Message;

#endif
