   // Serial Input tab, Titraumatic_3_05_15
   // Mar 6, 14
   //  modify code to get all parameters in one run from GUI
   //  single call; setupRun
   //  readParam code from StellarisWheeStat5_0


void setupRun(){
int place[6]={100000,10000,1000,100,10,1};           /* {serial read conversions. 
                each incoming byte in multiplied by the corrosponding place value 
                then summed to get the original vlaue} */
int incomingByte[6] = {0,0,0,0,0,0};      // serial read variable. each incoming byte (multiplied by the place)
                                           // is stored here. later the get summed to obtain the correct number      

   boolean startread = false;
  while (startread == false) {
      if(Serial.available() <= 0) {
      }
      int starti = 0;
      if(Serial.available() > 0) {
      starti = Serial.read();

      if(starti == '&') {           // GUI transmits '&' charactor, $ (dollar sign)
      
        runState = true;
        startread = true;
      }
     }
  } 
  ///////////mode////////////
 if (runState == true){ 
  Serial.print(',');
  Serial.print("Mode");
  Serial.print(',');
  readParam();  
  fillmode=param;     
  delay(20);  
  
  ///////////Syringe Volume///////
 
  Serial.print("Syr Vol");
  Serial.print(',');
  readParam();  
  sVol =param;     
  delay(20);  
   ///////////Plunger diameter///////
 // dia = 5;
    Serial.print("diameter");
  Serial.print(',');
  readParam();  
  dia=param; 
  Area = dia*dia*3.14159/4;  // diameter in mm, area in square mm
  delay(20);  
 
  ///////////Addition Volume///////
  Serial.print("Addn Vol");
  Serial.print(',');
  readParam();  
    dispVol=param;
   injCyc = dispVol*pitch/Area/10;     //dispVol is in uL, area in sq mm
   steps = 1600*injCyc;        
  delay(20);  

  ///////////Direction////////////
  Serial.print("direction");
  Serial.print(',');
  readParam();  
    woi=param;      //direction
  delay(20);  
 
  ///////////Injection Speed///////

    Serial.print("speed");
  Serial.print(',');
  readParam();  
  spd=param; 
  fspd =10*spd;  
  delay(20);  
  usDelay = 3125*Area/pitch/spd;
 
  ///////////Number of Additions//////  
  Serial.print("No of Addns");
  Serial.print(',');
  readParam();  
    nAddns=param;    // additions
  delay(20);  

 ///////////Delay between steps//////
  Serial.print("Step delay");
  Serial.print(',');
  readParam();  
    adDelay=param;    // delay
  delay(20);  

/********************* print values for header ********************/
  Serial.print(',');
  Serial.print(fillmode);
  Serial.print(',');
  Serial.print(sVol);
  Serial.print(',');
  Serial.print(dia);
  Serial.print(',');
  Serial.print(dispVol);
  Serial.print(',');
  Serial.print(woi);
  Serial.print(',');
  Serial.print(spd); 
  Serial.print(',');
  Serial.print(nAddns);
  Serial.print(',');
  Serial.println(adDelay);
 //////// signal all params received //////// 
   Serial.println('&');  // changed from &
      analogWrite(RED_LED, LOW);
}
}

  /******************************  end setupRun *******************************/

/****************************** read Paramaters ****************************/
void readParam() {
  //void readParam(int number) {
  //void readParam(int number, float param) {
  long place[6]={
    100000,10000,1000,100,10,1  };           
  int incomingByte[6] = {
    0,0,0,0,0,0  };      // serial read variable. each incoming byte (multiplied by the place)
  int n=0;
  param = 0;
  delayMicroseconds(300);  
  while (Serial.available()<= 0) {
  }
  while (Serial.available() > 0){  
    incomingByte[n] = Serial.read()-48;
    delay(2);
    ++n;          
  }
   
  for(int n=0;n<6;++n){ 
    param = param + (place[n]*(incomingByte[n]));  
  }
}          

/******************end of Read Parameters ********************/

