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
    signal Button.startDone(SUCCESS);
  }
  command void Button.stop() {
  }
  command void Button.pinvalueA() {
    bool pressed = call IOA.get();
    signal Button.pinvalueADone(pressed);
  }
  command void Button.pinvalueB() {
    bool pressed = call IOB.get();
    signal Button.pinvalueBDone(pressed);
  }
  command void Button.pinvalueC() {
    bool pressed = call IOC.get();
    signal Button.pinvalueCDone(pressed);
  }
  command void Button.pinvalueD() {
    bool pressed = call IOD.get();
    signal Button.pinvalueDDone(pressed);
  }
  command void Button.pinvalueE() {
    bool pressed = call IOE.get();
    signal Button.pinvalueEDone(pressed);
  }
  command void Button.pinvalueF() {
    bool pressed = call IOF.get();
    signal Button.pinvalueFDone(pressed);
  }
}