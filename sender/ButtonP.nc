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
    bool unpressed = call IOA.get();
    signal Button.pinvalueADone(unpressed);
  }
  command void Button.pinvalueB() {
    bool unpressed = call IOB.get();
    signal Button.pinvalueBDone(unpressed);
  }
  command void Button.pinvalueC() {
    bool unpressed = call IOC.get();
    signal Button.pinvalueCDone(unpressed);
  }
  command void Button.pinvalueD() {
    bool unpressed = call IOD.get();
    signal Button.pinvalueDDone(unpressed);
  }
  command void Button.pinvalueE() {
    bool unpressed = call IOE.get();
    signal Button.pinvalueEDone(unpressed);
  }
  command void Button.pinvalueF() {
    bool unpressed = call IOF.get();
    signal Button.pinvalueFDone(unpressed);
  }
}