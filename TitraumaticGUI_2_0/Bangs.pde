/////////////////////////////Bang's///////////////////////////////////////////////////////////
void setup_bangs() {
/*  cp5.addBang("Start_Run")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)
          .setColorActive(#06CB49)
            .setPosition(20, 430)
              .setSize(100, 40)
                .setTriggerEvent(Bang.RELEASE)
                  .setLabel("Start Run") //
                    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                      ;
*/
  cp5.addBang("Connect")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
          .setPosition(100, 8)
            .setSize(40, 20)
              .setTriggerEvent(Bang.RELEASE)
                .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                  ;
                  
 cp5.addBang("Save_run")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
          .setPosition(600, 10)
            .setSize(80, 20)
              .setTriggerEvent(Bang.RELEASE)
                .setLabel("Save Run")
                  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                    ;


}
/////////////////////bang programs ////////////////////////////////////////

public void Connect() {             // conect to com port bang
//   if(Comselected==false){
// try{
  serialPort = new Serial(this, comList[Ss], 9600);
  println(comList[Ss]);
  comPortTxtArea.setText("CONNECTED");
  Comselected = true;
// }
/* catch (Exception e){
   warning.show();
   warningtxt.setText("Some type of com port error");
   println("Some type of com port error. Restart program");
   comPortTxtArea.setText("COM ERROR");
 }
  }
   else{
   println("already connected");
   }
 */   }

/* public void Start_Run() {  // start run bang
// if (run == false && stop == true) {
if (run == false) {
    run = true;
  comPortTxtArea.setColor(#D8070E);
  comPortTxtArea.setText("RUNNING SCAN");
  }
    else {
    run = false;
    gotparams = false;
  comPortTxtArea.setColor(#D8070E);
  comPortTxtArea.setText("connected");
    }
} */

/////////////////////////////////////////////////group programs/////////////////////////////////

  

////////////////// Save run bang ///////////////////////////////                
                               

public void Save_run() {             // set path bang   
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    file2 = selection.getAbsolutePath();
    println("User selected " + file2);
   // myTextarea.setText(file2);
      ///////////////////////////////////////
  //  String file2 = "C:/Users/Ben/Documents/Voltammetry Stuff/log/data.txt";
  try{
  saveStream(file2,file1);
      }
      catch(Exception e){}              
            
          }}
 //////////////// button added 3/11/14 ////////////         
 // public void play() {
  void play() {

  if (run == true && stop == false) {
   run = false;
//   stop = true;
    gotparams = false;
      comPortTxtArea.setColor(#D8070E);
  comPortTxtArea.setText("Stopped");
     println("STOP");
     cData = '%';  // need to change cData to allow reading of info from LaunchPad  
     serialPort.write("%");  // signal to reset LaunchPad
     //  stopped = true;
  }
  else if (run == false && stop == true) {
    run = true;
    println("RUN");
      comPortTxtArea.setColor(#D8070E);
  comPortTxtArea.setText("RUNNING SCAN");
//  serialPort.write("&");  // added 10/22/14 to start run
  }
  else {
  println("sumpin funky goin on in bangs tab");
  }
 }

