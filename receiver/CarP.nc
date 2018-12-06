#include <msp430usart.h>
#include "../include/Radio.h"

module CarP{
    provides interface Car;
    uses interface Leds;
    uses interface Resource;
    uses interface HplMsp430Usart;

}

implementation {
  Message* global_pkg;
  uint8_t forward_commands[8] = {1, 2, 0, 2, 0, 0xff, 0xff, 0};
  uint8_t angle1_commands[8] = {1, 2, 1, 4000 / 256, 4000 % 256, 0xff, 0xff, 0};
  uint8_t angle2_commands[8] = {1, 2, 7, 4000 / 256, 4000 % 256, 0xff, 0xff, 0};
  uint8_t angle3_commands[8] = {1, 2, 8, 4000 / 256, 4000 % 256, 0xff, 0xff, 0};
  uint8_t* current_command; 
  uint8_t current_pos;
  int8_t x_status, y_status;
  msp430_uctl_t u0ctrl; 
  msp430_uart_union_config_t config = {
    {
      utxe: 1,
      urxe: 1,
      ubr: UBR_1MHZ_115200,
      umctl: UMCTL_1MHZ_115200,
      ssel: 0x02,
      pena: 0,
      pev: 0,
      spb: 0,
      clen: 1,
      listen: 0,
      mm: 0,
      ckpl: 0,
      urxse: 0,
      urxeie: 0,
      urxwie: 0,
      utxe: 1,
      urxe: 1
    }
  };
  command void Car.move(Message* pkt){
    error_t output = call Resource.request();
    // if ``output != SUCCESS``, we have already request it. donot change global_pkg.
    if(output == SUCCESS)
    {
      global_pkg = pkt;
    }
  }
  event void Resource.granted(){
    call HplMsp430Usart.setModeUart(&config);
    call HplMsp430Usart.enableUart();
    atomic {U0CTL &= ~SYNC;}
    call Car.prepareCommand();
    atomic{
      current_pos = 0;
    }
    call Car.sendCommand();
    call Resource.release();
  }
  command void Car.prepareCommand()
  {
      if(global_pkg->y <=500)
      {
        y_status = 1;
      }else if(global_pkg->y >= 1000 && global_pkg->y <= 3000)
      {
        y_status = 0;
      }else if(global_pkg->y >= 4000)
      {
        y_status = -1;
      }
      
      if(global_pkg->x <=500)
      {
        x_status = 1;
      }else if(global_pkg->x >= 1000 && global_pkg->x <= 3000)
      {
        x_status = 0;
      }else if(global_pkg->x >= 4000)
      {
        x_status = -1;
      }
      
      if(x_status == -1)
      {
        call Leds.led0Toggle();
      }
      if(x_status == 0)
      {
        call Leds.led1Toggle();
      }
      if(x_status == 1)
      {
        call Leds.led2Toggle();
      }
      
      if(y_status == 0 && x_status == 0)
      {
        forward_commands[2] = 6;
      }else if(y_status == 0 && x_status == -1)
      {
        forward_commands[2] = 4;
      }else if(y_status == 0 && x_status == 1)
      {
        forward_commands[2] = 5;
      }else if(y_status == 1 && x_status == 0)
      {
        forward_commands[2] = 2;
      }else if(y_status == -1 && x_status == 0)
      {
        forward_commands[2] = 3;
      }else{
        forward_commands[2] = 6;
      }

      if(global_pkg->buttons & 4)
      {
        current_command = angle1_commands;
      }else if(global_pkg->buttons & 16){
        current_command = angle2_commands;
      }else if(global_pkg->buttons & 32){
        current_command = angle3_commands;
      }else{
        current_command = forward_commands;
      }
  }
  command void Car.sendCommand()
  {
    while(1)
    {
      if(current_pos >= 8)
      {
        break;
      }
      if(call HplMsp430Usart.isTxEmpty())
      {
        call HplMsp430Usart.tx(current_command[current_pos]);
        current_pos += 1;
      }
    }
  }
  command error_t Car.turn(uint16_t value){
  }
  command error_t Car.forward(uint16_t value){
  }
  command error_t Car.back(uint16_t value){
  }
  command error_t Car.left(uint16_t value){
  }
  command error_t Car.right(uint16_t value){
  }
  command error_t Car.pause(){
  }

}