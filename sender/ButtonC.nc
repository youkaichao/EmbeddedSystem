configuration ButtonC {
  provides interface Button;
}

implementation {
  components ButtonP;
  components HplMsp430GeneralIOC as IO;

  Button = ButtonP.Button;
  ButtonP.IOA -> IO.Port60;
  ButtonP.IOB -> IO.Port21;
  ButtonP.IOC -> IO.Port61;
  ButtonP.IOD -> IO.Port23;
  ButtonP.IOE -> IO.Port62;
  ButtonP.IOF -> IO.Port26;
}