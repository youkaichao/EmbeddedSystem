#include "../include/Radio.h"
interface Car {
  command void move(Message* pkt);
  command void prepareCommand();
  command void sendCommand();
}