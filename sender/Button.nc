interface Button {
  command void start();
  event void startDone(error_t error);
  command void stop();
  event void stopDone(error_t error);
  command void pinvalueA();
  event void pinvalueADone(bool pressed);
  command void pinvalueB();
  event void pinvalueBDone(bool pressed);
  command void pinvalueC();
  event void pinvalueCDone(bool pressed);
  command void pinvalueD();
  event void pinvalueDDone(bool pressed);
  command void pinvalueE();
  event void pinvalueEDone(bool pressed);
  command void pinvalueF();
  event void pinvalueFDone(bool pressed);
}