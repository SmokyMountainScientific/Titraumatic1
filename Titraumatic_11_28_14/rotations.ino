// Rotations tab
//////// Nov 12, 2014:  
//  Injection speed in uL / s, all units are in mm and seconds except pitch (which is in threads/cm).
//             usDelay = 10^6*Area*10/(2*pitch*speed*1600)  
//     for 15 mm diameter plunger, Area = 176 sq mm.
//     pitch currently set to 7.874 threads/cm
//     for 176 uL/s speed, requires 1 mm/s travel, 1/0.7874 rotations at 1600 usteps /  rotation
//     this gives 2032 steps/s, or 492 us/step.  Each microstep takes 2*usDelay:  usDelay = 246


void rotate(int msteps){ 
  msteps = abs(msteps);
  if (woi == 0)               // withdraw or inject
   {
    digitalWrite(dirPin,HIGH);   // output to direction pin
    }
  else  
   {
    digitalWrite(dirPin,LOW);
    }

  for(int i=0; i < msteps; i++)       // step through msteps
    {
    digitalWrite(stepPin, HIGH); 
    delayMicroseconds(usDelay); 
    digitalWrite(stepPin, LOW); 
    delayMicroseconds(usDelay); 
  }                                  // end of steps
  status();
////// calculate uL added ///////
/* float addVol = msteps*Area/160/pitch;    // determine volume added or withdrawn
 readP();                                 // read sensor value
 Serial.print(addVol);
 Serial.print(",");
 Serial.print(sensorValue);  */
}

