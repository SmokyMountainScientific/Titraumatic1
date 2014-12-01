// read_serial tab 
// TitraumaticGUI_1b 


 void  read_serial() {
//   println("in serial read");
  int whu = 0;   //not used in Wheestat, set to 1 at end of read
      if (serialPort.available () <= 0) {}
      if (serialPort.available() > 0) {                     
        sData3 = serialPort.readStringUntil(LINE_FEED);  // new JS11/22
     
  if(sData3 != null && p != 0) {           // different in WheeStat
   /*     print("p = ");
        print(p);
        print('\t');
        print("data = ");
        println(sData3); */ 
        logData(file1, sData3, true);       // not in WheeStat
        String[] tokens = sData3.split(",");

//    println(sData3);
    println(tokens);
    tokens = trim(tokens);  

    if (whu != 1)  {  
        xRead = Float.parseFloat(tokens[0]);  // added volume
        yRead = Float.parseFloat(tokens[1]);  // pH reading
        command = int(tokens[2]);             // use for determining end of injection delay
        pHRead = calSlope*yRead + calInt;
      //  xRead = round(xRead);
if(iDir == 0 && xRead != 99999) {
  fVol = -xRead/1000+fVol;      // if injecting, subtract xRead from current vol
  inVol = xRead/1000+inVol;      //initVol-fVol;
   }
   if(iDir == 1 && xRead != 99999) {
  fVol = xRead/1000+fVol;      // if withdrawing, add xRead from current vol
  inVol = -xRead/1000+inVol;
   }
//curVol = String.valueOf(fVol);

       if (xRead == 99999) // || cData == '@')   //  && yRead == 99999)  // signals end of run
        {
          run = false;    // stops program
           println("end the madness");
           gotparams = false;
          comPortTxtArea.setColor(#036C09);
          comPortTxtArea.setText("FINISHED");
          whu = 1;                // indicates end of run
          cData = 'a';   
 
         }
         else if (xData[0] == 0 && yData[0] == 0) {
          xData[0] = inVol; 
          yData[0] = pHRead;
         }
       else {  
         //xData = append(xData, xRead);
         xData = append(xData, inVol);
         yData = append(yData, pHRead);
           }   

         }
      }
         p +=1;
    } // end of if serial available > 0
  }

