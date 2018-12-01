interface Car {
  command error_t turn(uint16_t value);
  command error_t forward(uint16_t value);
  command error_t back(uint16_t value);
  command error_t left(uint16_t value);
  command error_t right(uint16_t value);
  command error_t pause();
}