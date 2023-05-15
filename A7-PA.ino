extern "C"
{
  void SPI_MAX7219_init();
  void MAX7219_disp_text();
  void HC_SR04_sensor();
}
//---------------------------------------
void setup()
{

  HC_SR04_sensor();
}
//---------------------------------------
void loop(){}