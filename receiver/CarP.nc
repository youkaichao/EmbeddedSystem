#include <msp430usart.h>
#include "../include/Radio.h"

module CarP{
    provides interface Car;
    uses interface Resource;
    uses interface HplMsp430Usart;
    uses interface HplMsp430UsartInterrupts;
}

implementation {
  Message* global_pkg;
  uint8_t forward_commands[8] = {1, 2, 0, 0, 0, 0xff, 0xff, 0};
  uint8_t angle1_commands[8] = {1, 2, 0, 0, 0, 0xff, 0xff, 0};
  uint8_t angle2_commands[8] = {1, 2, 0, 0, 0, 0xff, 0xff, 0};
  uint8_t angle3_commands[8] = {1, 2, 0, 0, 0, 0xff, 0xff, 0};
  uint8_t* all_commands[4] = {forward_commands, angle1_commands, angle2_commands, angle3_commands}; 
  uint8_t current_pos;
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
    
  }
  command void Car.sendCommand()
  {
    atomic{
      if(current_pos <= 31)
      {
        call HplMsp430Usart.tx(all_commands[current_pos >> 3][current_pos & 7]);
      }
    }
  }
  async event void HplMsp430UsartInterrupts.txDone()
  {
    atomic{
      current_pos += 1;
    }
    call Car.sendCommand();
  }
  async event void HplMsp430UsartInterrupts.rxDone(uint8_t data)
  {
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