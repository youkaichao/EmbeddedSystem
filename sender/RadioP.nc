#include <Timer.h>
#include "Radio.h"

module RadioP {
  uses interface Boot;
  uses interface Leds;
  uses interface Button;
  uses interface Packet;
  uses interface AMPacket;
  uses interface AMSend;
  uses interface Timer<TMilli> as Timer;
  uses interface SplitControl as AMControl;
  uses interface Read<uint16_t> as JSX;
  uses interface Read<uint16_t> as JSY;
}
implementation {
  uint16_t counter;
  message_t pkt;
  bool busy = FALSE;
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
    counter++;
    if (!busy) {
      Message* msg = (Message*)(call Packet.getPayload(&pkt, sizeof(Message)));
      if (msg == NULL) {
      	return;
      }
      msg->nodeid = TOS_NODE_ID;
      msg->counter = counter;
      if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(Message)) == SUCCESS) {
        busy = TRUE;
      }
    }
  }
  event void AMSend.sendDone(message_t* msg, error_t err) {
    if (&pkt == msg) {
      busy = FALSE;
    }
  }
  event void Button.startDone(){
  }
  event void Button.stopDone(){
  }
  event void Button.pinvalueADone(){
  }
  event void Button.pinvalueBDone(){
  }
  event void Button.pinvalueCDone(){
  }
  event void Button.pinvalueDDone(){
  }
  event void Button.pinvalueEDone(){
  }
  event void Button.pinvalueFDone(){
  }
  event void JSX.readDone(error_t result, uint16_t val){
  }
  event void JSY.readDone(error_t result, uint16_t val){
  }
}
