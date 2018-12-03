#include <Timer.h>
#include "../include/Radio.h"

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
  //=================================== global variables ===========================================
  uint16_t counter;
  uint16_t x;
  uint16_t y;
  uint8_t buttons;
  message_t pkt;
  bool busy = FALSE;
  
  //=================================== boot code: start button, radio and timer ===========================================
  event void Boot.booted() {
    call Button.start();
  }
  event void Button.startDone(error_t error){
    if (error == SUCCESS) {
      buttons = 0;
      call AMControl.start();
    }
    else{
      call Button.start();
    }
  }
  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer.startPeriodic(TIMER_PERIOD_MILLI);
    }
    else {
      call AMControl.start();
    }
  }
  event void Timer.fired() {
    call Button.pinvalueA();
  }
  event void AMSend.sendDone(message_t* msg, error_t err) {
    if (&pkt == msg) {
      busy = FALSE;
    }
  }
  
  //=================================== button press function ===========================================
  event void Button.pinvalueADone(bool pressed){
    buttons &= (pressed << 0);
    call Button.pinvalueB();
  }
  event void Button.pinvalueBDone(bool pressed){
    buttons &= (pressed << 1);
    call Button.pinvalueC();
  }
  event void Button.pinvalueCDone(bool pressed){
    buttons &= (pressed << 2);
    call Button.pinvalueD();
  }
  event void Button.pinvalueDDone(bool pressed){
    buttons &= (pressed << 3);
    call Button.pinvalueE();
  }
  event void Button.pinvalueEDone(bool pressed){
    buttons &= (pressed << 4);
    call Button.pinvalueF();
  }
  event void Button.pinvalueFDone(bool pressed){
    buttons &= (pressed << 5);
    call JSX.read();
  }
  
  //=================================== joystick function ===========================================
  event void JSX.readDone(error_t result, uint16_t val){
    if (result == SUCCESS) {
      x = val;
    }else{
      x = 0;
    }
    call JSY.read();
  }
  event void JSY.readDone(error_t result, uint16_t val){
    if (result == SUCCESS) {
      y = val;
    }else{
      y = 0;
    }
    counter++;
    if (!busy) {
      Message* msg = (Message*)(call Packet.getPayload(&pkt, sizeof(Message)));
      if (msg == NULL) {
        return;
      }
      msg->key = SECRET_KEY;
      msg->x = x;
      msg->y = y;
      msg->buttons = buttons;
      msg->buttons |= (counter & 3) << 6;
      if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(Message)) == SUCCESS) {
        busy = TRUE;
      }
      if(counter & 1)
      {
        call Leds.led0Toggle();
      }
      if(counter & 2)
      {
        call Leds.led1Toggle();
      }
      if(counter & 4)
      {
        call Leds.led2Toggle();
      }
    }
  }
  
  //=================================== useless function ===========================================
  event void Button.stopDone(error_t error){
  }
  event void AMControl.stopDone(error_t err) {
  }
}
