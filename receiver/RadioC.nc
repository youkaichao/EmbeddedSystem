#include <Timer.h>
#include "../include/Radio.h"

configuration RadioC {
}
implementation {
  components CarC;
  components MainC;
  components RadioP;
  components ActiveMessageC;
  components new TimerMilliC() as Timer;
  components new AMReceiverC(AM_RADIO);

  RadioP.Car -> CarC;
  RadioP.Boot -> MainC;
  RadioP.Timer -> Timer;
  RadioP.AMControl -> ActiveMessageC;
  RadioP.Receive -> AMReceiverC;
}
