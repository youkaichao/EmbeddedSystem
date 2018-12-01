#include <Timer.h>
#include "Radio.h"

configuration RadioC {
}
implementation {
  components CarC;
  components MainC;
  components LedsC;
  components RadioP;
  components ActiveMessageC;
  components new TimerMilliC() as Timer;
  components new AMReceiverC(AM_RADIO);

  RadioP.Car -> CarC;
  RadioP.Boot -> MainC;
  RadioP.Leds -> LedsC;
  RadioP.Timer -> Timer;
  RadioP.AMControl -> ActiveMessageC;
  RadioP.Receive -> AMReceiverC;
}