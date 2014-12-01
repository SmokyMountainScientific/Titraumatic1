// RunToVolume tab
// used when run mode is "to volume"

void runToVol(){

  int jogs = steps/200;  
  float addVol = 200*Area/160/pitch;    // determine volume added or withdrawn
 


    while(runState == true) {
    for (int k = 0; k<jogs; k++) {
      rotate(200);
      readP();                                 // read sensor value
      Serial.print(addVol);
      Serial.print(",");
      Serial.print(sensorValue);
      if (k == jogs-1) {       // last rotation
        Serial.println(",1"); // 1 command indicates end of volume
        runState = false;
        Serial.println("99999,0,0"); 
        }
      else {
        Serial.println(",0"); // 0 command indicates middle of injection
        }
    }
  }
}


