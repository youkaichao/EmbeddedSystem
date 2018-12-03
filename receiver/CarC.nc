#include "../include/Radio.h"
configuration CarC{
  provides interface Car;
}

implementation{
  components CarP;
  components new Msp430Uart0C() as Uart;
  components HplMsp430Usart0C as Usart;

  Car = CarP.Car;
  CarP.Resource -> Uart.Resource;
  CarP.HplMsp430Usart -> Usart.HplMsp430Usart;
  CarP.HplMsp430UsartInterrupts -> Usart.HplMsp430UsartInterrupts;
}
