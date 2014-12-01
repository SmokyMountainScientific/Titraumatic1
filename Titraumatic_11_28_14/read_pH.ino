void readP() {
    sensorValue = 0;
  for (int j = 0; j<16; j++) {
  sensorValue += analogRead(analogInPin);   //added for measurement         
  }
  sensorValue = sensorValue/16; 
  } 
