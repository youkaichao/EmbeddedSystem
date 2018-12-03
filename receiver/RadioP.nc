#include <Timer.h>
#include "../include/Radio.h"

module RadioP {
  uses interface Car;
  uses interface Boot;
  uses interface Timer<TMilli> as Timer;
  uses interface Receive;
  uses interface SplitControl as AMControl;
}
implementation {
  event void Boot.booted() {
    call AMControl.start();
  }
  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer.startPeriodic(TIMER_PERIOD_MILLI);
    }
    else {
      call AMControl.start();
    }
  }
  event void AMControl.stopDone(error_t err) {
  }
  event void Timer.fired() {
  }
  event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len){
    if (len == sizeof(Message)) {
      Message* pkt = (Message*)payload;
      if(pkt->key != SECRET_KEY)
      {// maybe package of someone else
        return msg;
      }
      call Car.move(pkt);
    }
    return msg;
  }
}
