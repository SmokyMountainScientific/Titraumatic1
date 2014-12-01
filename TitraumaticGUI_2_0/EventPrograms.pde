void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) 
  {
    if (theEvent.name().equals("list-1")) {  // comm list dropdown

      float S = theEvent.group().value();
      Ss = int(S);
      Comselected = true;
    }
  if (theEvent.name().equals("list-2")) {  // mode select dropdown
      float Mod = theEvent.group().value(); 
//    Modi = int(Mod);
//      String [][] Modetype = mode.getListBoxItems(); //  String [] Modetype = theEvent.group().Items();
  //    Modetorun = Modetype[Modi][Modi];
      if (Mod == 0) {
      Modetorun = "toSignal";
      Modesel = true;
      }
      if (Mod == 1) {
      Modetorun = "toVol";
      Modesel = true;
      }
            if (Mod == 2) {
      Modetorun = "Titrate";
      Modesel = true;
      }
            if (Mod == 3) {
      Modetorun = "pHAdjust";
      Modesel = true;
      }

      println(Modetorun);
    } 
  }
//}  moved to end


  if (theEvent.isFrom(enableBox)) {
    iSel = 0;  // slect pH measure & pump
    print("got an event from "+enableBox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(enableBox.getArrayValue());
//    int col = 0;
    for (int i=0;i<enableBox.getArrayValue().length;i++) {
      int n = (int)enableBox.getArrayValue()[i];
      print(n);
      if(n==1) {
//        myColorBackground += channels.getItem(i).internalValue();
        iSel += enableBox.getItem(i).internalValue();   // internalValue = 2 for B
        }
      }
    println();   
   println(iSel);
//   iSel = 3-iSel;
  if (iSel == 0) {            //iSel determines whether pump and pH meter are enabled
      pmpEnTxt = "Pump disabled";
      mtrEnTxt = "pH meter disabled";
//      pHfield.hide();

      showPumpParams = false;
      pHBox = false;
       }
 else if (iSel == 1) {
      pmpEnTxt = "Pump enabled";
      mtrEnTxt = "pH meter disabled";
//      pHfield.hide();
//      colTxt = "direction: infuse";
  //    Dir = "000001";
      showPumpParams = true;
      pHBox = false;
      }
  else if (iSel ==2) {
      pmpEnTxt = "Pump disabled";
      mtrEnTxt = "pH meter enabled";
//      pHfield.show();
      pHBox = true;
//      colTxt = "dissabled";
      showPumpParams = false;
      }
  else {
      pmpEnTxt = "Pump enabled";
      mtrEnTxt = "pH meter enabled";
 //iVolBox     pHfield.show();
      pHBox = true;
 //     colTxt = "direction: withdraw";
   //   Dir = "000000";
      showPumpParams = true;
      }
  }
  if (theEvent.isFrom(directBox)) {
    iDir = 0;  // slect pH measure & pump
    print("got an event from "+directBox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(directBox.getArrayValue());
//    int col = 0;
    for (int i=0;i<directBox.getArrayValue().length;i++) {
      int n = (int)directBox.getArrayValue()[i];
      print(n);
      if(n==1) {
//        myColorBackground += channels.getItem(i).internalValue();
        iDir += directBox.getItem(i).internalValue();   // internalValue = 2 for B
        }
      }
    println();   
   println(iDir);
//   iSel = 3-iSel;
  if (iDir == 0) {
      dirTxt = "Direction: infuse";
      Dir = "000001";
      iVolTxt = "Initialize Volume";
      initialVol.hide();
      if (volInitialized == true) {
         curVol = cp5.get(Textfield.class, "initialVol").getText();  // was currentVol
         fVol = float(curVol);
         volInitialized = false;
      }
       }
 else if (iDir == 1) {
      dirTxt = "Direction: withdraw";
      Dir = "000000";
      iVolTxt = "Initialize Volume";
      initialVol.hide();
            if (volInitialized == true) {
         curVol = cp5.get(Textfield.class, "initialVol").getText();  // was currentVol
         fVol = float(curVol);
         initVol = fVol;
         volInitialized = false;
      }

      }
  else if (iDir ==2) {
      dirTxt = "Direction: infuse";
      Dir = "000001";
      iVolTxt = "Set Volume";
      initialVol.show();
      volInitialized = true;
//  curVol = cp5.get(Textfield.class, "initialVol").getText();  // was currentVol
  //fVol = float(curVol);
  //println(fVol);
      }
  else {
       dirTxt = "Direction: withdraw";
      Dir = "000000";
      iVolTxt = "Initialize Volume";
      initialVol.show();
      volInitialized = true;

      }
  }
    if (theEvent.isFrom(pHRec)) {
    iRecpH = 0;  // slect pH measure & pump  NEED TO FIX THIS
    print("got an event from "+pHRec.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(pHRec.getArrayValue());
//    int col = 0;
    for (int i=0;i<pHRec.getArrayValue().length;i++) {
      int n = (int)pHRec.getArrayValue()[i];
      print(n);
      if(n==1) {
//        myColorBackground += channels.getItem(i).internalValue();
        iRecpH += pHRec.getItem(i).internalValue();   // internalValue = 2 for B
        }
      }
    println();   
//   println(iDir);
//   iSel = 3-iSel;
  if (iRecpH == 0) {
      recTxt = "Don't record pH";
       }
 else if (iRecpH == 1) {
      recTxt = "Recording pH";
      }
  else if (iRecpH == 2) {
      recTxt = "Calibrate pH";
      }
  else  {
      recTxt = "Calibrate pH";
      }
/*  else if (iDir ==2) {
      recTxt = "Dont read pH";

      }
  else {
      recTxt = "Read and record pH";


      }*/
  }
/*      if (theEvent.isFrom(iVolBox)) {
    iVol = 0;  // what is this?
    print("got an event from "+iVolBox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(iVolBox.getArrayValue());
//    int col = 0;
    for (int i=0;i<iVolBox.getArrayValue().length;i++) {
      int n = (int)iVolBox.getArrayValue()[i];
      print(n);
      if(n==1) {
//        myColorBackground += channels.getItem(i).internalValue();
        iVol += iVolBox.getItem(i).internalValue();   // internalValue = 2 for B
        }
      }
    println();   
//   println(iDir);
//   iSel = 3-iSel;
  if (iVol == 0) {
      recTxt = "Set Initial Vol";
       }
 else {
      recTxt = "Set Volume";
      }


  }*/
  }
