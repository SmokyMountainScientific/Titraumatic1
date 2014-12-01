/////////////////////////////Bang's///////////////////////////////////////////////////////////
void setup_bangs() {
  cp5.addBang("Start_Run")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)
          .setColorActive(#06CB49)
            .setPosition(200, 380)
              .setSize(150, 40)
                .setTriggerEvent(Bang.RELEASE)
                  .setLabel("Start Run") //
                    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                      ;

  cp5.addBang("Connect")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
          .setPosition(120, 15)
            .setSize(40, 20)
              .setTriggerEvent(Bang.RELEASE)
                .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                  ;


}
/////////////////////bang programs ////////////////////////////////////////

public void Connect() {             // conect to com port bang
//   if(Comselected==false){
// try{
  serial = new Serial(this, comList[Ss], 9600);
  println(comList[Ss]);
  myTextarea2.setText("CONNECTED");
  Comselected = true;
// }
/* catch (Exception e){
   warning.show();
   warningtxt.setText("Some type of com port error");
   println("Some type of com port error. Restart program");
   myTextarea2.setText("COM ERROR");
 }
  }
   else{
   println("already connected");
   }*/   }

public void Start_Run() {  // start run bang
  bool = true;
  myTextarea2.setColor(#D8070E);
  myTextarea2.setText("RUNNING SCAN");
}
/////////////////////////////////////////////////group programs/////////////////////////////////

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) 
  {
    if (theEvent.name().equals("list-1")) {//if (theEvent.getGroup().equals("list-1")) {

      float S = theEvent.group().value();
      Ss = int(S);
      Comselected = true;
    }
 /*   if (theEvent.name().equals("list-2")) {
      float Mod = theEvent.group().value(); 
      Modi = int(Mod);
      String [][] Modetype = mode.getListBoxItems(); //  String [] Modetype = theEvent.group().Items();
      Modetorun = Modetype[Modi][Modi];
      Modesel = true;
      println(Modetorun);
    }*/
  }
}


