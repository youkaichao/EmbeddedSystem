#ifndef RADIO_H
#define RADIO_H

enum {
  AM_RADIO = 6,
  TIMER_PERIOD_MILLI = 250
};

uint16_t SECRET_KEY = 0xef;

typedef nx_struct Message {
  nx_uint16_t key;
  nx_uint16_t x;
  nx_uint16_t y;
  nx_uint8_t buttons;
} Message;

#endif
