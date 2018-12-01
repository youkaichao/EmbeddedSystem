module ButtonP {
  uses {
    interface HplMsp430GeneralIO as IOA;
    interface HplMsp430GeneralIO as IOB;
    interface HplMsp430GeneralIO as IOC;
    interface HplMsp430GeneralIO as IOD;
    interface HplMsp430GeneralIO as IOE;
    interface HplMsp430GeneralIO as IOF;
  }
  provides interface Button;
}

implementation {
  command void Button.start() {
    call IOA.clr();
    call IOB.clr();
    call IOC.clr();
    call IOD.clr();
    call IOE.clr();
    call IOF.clr();
    call IOA.makeInput();
    call IOB.makeInput();
    call IOC.makeInput();
    call IOD.makeInput();
    call IOE.makeInput();
    call IOF.makeInput();
    signal Button.startDone();
  }
  command void Button.stop() {
  }
  command void Button.pinvalueA() {
  }
  command void Button.pinvalueB() {
  }
  command void Button.pinvalueC() {
  }
  command void Button.pinvalueD() {
  }
  command void Button.pinvalueE() {
  }
  command void Button.pinvalueF() {
  }
}