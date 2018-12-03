#include "../include/Radio.h"
interface Car {
  command error_t turn(uint16_t value);
  command error_t forward(uint16_t value);
  command error_t back(uint16_t value);
  command error_t left(uint16_t value);
  command error_t right(uint16_t value);
  command error_t pause();
  command void move(Message* pkt);
  command void prepareCommand();
  command void sendCommand();
}