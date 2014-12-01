// RunToSignal tab
// used with "to signal" mode
void runToSignal(){   // working on 3/18/14
        float addVol = 200*Area/160/pitch;    // determine volume added or withdrawn
     while(runState == true) {       //fill syringe until stop signal
         rotate(200); 
        ////// calculate uL added ///////

        readP();                                 // read sensor value
        Serial.print(addVol);
        Serial.print(",");
        Serial.print(sensorValue);
        Serial.print(",");
        Serial.println("0");  // command indicates mid-run  
        status2();
  //   HWREG(NVIC_APINT) = NVIC_APINT_VECTKEY | NVIC_APINT_SYSRESETREQ;   
     }
  }
