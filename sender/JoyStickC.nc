#include <Msp430Adc12.h>

configuration JoyStickC {
  provides {
    interface Read<uint16_t> as JSX;
    interface Read<uint16_t> as JSY;
  }
}

implementation {
    components JoyStickP;
    components new AdcReadClientC() as AdcReadClientX;
    components new AdcReadClientC() as AdcReadClientY;

    JSX = AdcReadClientX.Read;
    JSY = AdcReadClientY.Read;

    AdcReadClientX.AdcConfigure -> JoyStickP.AdcConfigureX;
    AdcReadClientY.AdcConfigure -> JoyStickP.AdcConfigureY;
}
