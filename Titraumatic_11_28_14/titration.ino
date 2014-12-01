// titration tab
//  multiple possible scenarios:
//              1.  Simple injections based on time
//              2.  Injected volumes based on change in pH
//              3.  Delay injections based on pH stability.
//  03/10/14  transmit injection number to GUI
//   GUI will calculate volume added from known values

void run_titration() {

 /* int pHval[] = {0};               // set up an array of pH values
  int uLadded = 0;                 
  int delta;
  int threshold;    */               // move on when pH stabilizes; change less than threshold
  while(runState == true) {
    /*
  readP();                          // read 16 pH values and get average
     pHval[0] = sensorValue;   //initial pH     
     //Serial.print("sensor = " );                       
     Serial.print("0,");               // zero titrant added
     Serial.println(sensorValue);      //print measured pH to output
     */

    /*
 while (delta >= threshold) {
     
     readP();
     pHval[1] = sensorValue;
     delay(100);
     readP();
     pHval[2] = sensorValue;
     delta = abs(pHval[2] - pHval[1]);
     status();
     }   
     */
    //  runToVol();
    int jogs = steps/200;  //steps/200;
    float addVol = steps*Area/160/pitch;    // determine total volume added or withdrawn
    
    //// initial read ///////////
   readP();
   Serial.print("0,");
   Serial.print(sensorValue);
   Serial.println(",0"); 
  //////////////////   begin nAddns loop /////////////////////
    for (int i =1; i<=nAddns; ++i){     //jss change 8-15-13
          
    for (int k = 1; k<=jogs; k++) {
      rotate(200);            
      }
      status2();       // read for stop signal from GUI
      
   
    ////////////// read every 200 ms during delay /////////      
    for (int k = 0; k<5*adDelay; k++) {
      readP();  
      if (k == 0) {
        Serial.print(addVol);
        Serial.print(",");
      }
      else {
        Serial.print("0,");
      }

      Serial.print(sensorValue);
      if (k == 5*adDelay-1) {
        Serial.println(",2");        // command "2" at end of addition delay
      }
      else {
        Serial.println(",0");          // command "0" at start and interior of delay
      } 
      delay(200);
    }    
     }  //////////// end of nAddns loop ///////////////
     runState=false;
     Serial.println("99999,0,0");       // end signal 
  }
} 



