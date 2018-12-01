#include <msp430usart.h>

module CarP{
    provides interface Car;
    uses interface Resource;
    uses interface HplMsp430Usart;
}

implementation {
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
  event void Resource.granted(){
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