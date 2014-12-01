// reset_status tab

void status(){
   int endQ = digitalRead(endStop);          // read limit switch
   if (endQ == HIGH){
    runState = false;
    //   HWREG(NVIC_APINT) = NVIC_APINT_VECTKEY | NVIC_APINT_SYSRESETREQ; 
    Serial.println("99999,0,2");       // end signal added 10/22/14
  }
}

void status2(){
  boolean rsStatus;
  if(Serial.available()>0) {
    rsStatus = Serial.find("%");            // search for stop signal  %
  }
  int endQ = digitalRead(endStop);          // read limit switch
  if (rsStatus == true){
    runState = false;
    //   HWREG(NVIC_APINT) = NVIC_APINT_VECTKEY | NVIC_APINT_SYSRESETREQ; 
    Serial.println("99999,0,2");       // end signal added 10/22/14
  }
}
