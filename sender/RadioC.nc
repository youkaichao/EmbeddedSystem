#include <Timer.h>
#include "../include/Radio.h"

configuration RadioC {
}
implementation {
  components MainC;
  components LedsC;
  components RadioP;
  components ButtonC;
  components ActiveMessageC;
  components JoyStickC;
  components new TimerMilliC() as Timer;
  components new AMSenderC(AM_RADIO);

  RadioP.Boot -> MainC;
  RadioP.Leds -> LedsC;
  RadioP.Timer -> Timer;
  RadioP.Button -> ButtonC;
  RadioP.AMSend -> AMSenderC;
  RadioP.Packet -> AMSenderC;
  RadioP.AMPacket -> AMSenderC;
  RadioP.AMControl -> ActiveMessageC;
  RadioP.JSX -> JoyStickC.JSX;
  RadioP.JSY -> JoyStickC.JSY;
}
