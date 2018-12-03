interface Button {
  command void start();
  event void startDone(error_t error);
  command void stop();
  event void stopDone(error_t error);
  command void pinvalueA();
  event void pinvalueADone(bool unpressed);
  command void pinvalueB();
  event void pinvalueBDone(bool unpressed);
  command void pinvalueC();
  event void pinvalueCDone(bool unpressed);
  command void pinvalueD();
  event void pinvalueDDone(bool unpressed);
  command void pinvalueE();
  event void pinvalueEDone(bool unpressed);
  command void pinvalueF();
  event void pinvalueFDone(bool unpressed);
}