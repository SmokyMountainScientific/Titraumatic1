/* TitraumaticGUI_1 in Public Processing Sketches
 * on JSS laptop
 *GUI for running syringe pump. 
 * Based on BHickman work on potentiostat GUI
 * Jack Summers and Angela Edwards 
 * Compatible with Energia Step_mot4b program. 
 * Com port selection tool works
 */
 
///////////////////////////////////////// Imports/////////////////////////////////
import org.gicentre.utils.gui.TextPopup; // for warning window
import org.gicentre.utils.stat.*;    // For chart classes.
//import org.gicentre.utils.multisketch.*; // for integration window
import controlP5.*;
import processing.serial.*;
import java.io.*;                        // this is needed for BufferedWriter
///////////////////////////////////////////////////////////////Classes///////////////
 
XYChart lineChart;  
CheckBox enableBox, directBox, pHRec, iVolBox, mofoBox;     //, chanDisp;
ControlP5 cp5,cp5b,cp5c;
Serial serial;
Serial serialPort; // 11/25
//Textarea myTextarea;   
Textarea comPortTxtArea;   // com port and status window
Textfield Syringe_V, Disp_V, Syringe_Dia, n_Addns, ad_Delay, maxLength, Speed, initialVol;  //pHfield, Direction, cut
DropdownList ports, mode;              //Define the variable ports and mode as a Dropdownlist.
//////////////////////// move boxes down
int movPar = 60;     // moving boxes down parameter

//////////////////////////////////variables//////////////////////
String Syringe_Vol;
String Disp_Vol;
String Syringe_D;
String n_Adds;
String ad_Del;
//String maxL;
String Dir = "000001"; 
String Spd;
char[] strtochar;
char cData;
int iSel = 3;  // variable for selecting pump & direction
int iDir = 0;   
int iRecpH = 0;  // variable for selecting to record pH
int iVol = 0;
int command;     // read variable from LaunchPad for status info

 String pmpEnTxt = "Pump disabled";     //pump enabled text
 String mtrEnTxt = "pH meter disabled";  //pH meter enabled text
 String recTxt = "Don't record pH";      // record pH text
 String colTxt = "Pump dissabled"; // string to print in response to selection of iSel
 String pHTxt = "No input";
 String curVol = "10.0";
 float fVol;                              //volume from text box converted to float 
 float inVol;                             // volume dispensed
 float initVol;                        // initial volume in syringe
 String dirTxt = "Direction: infuse";
 String pHval = "no input";    // text for pH box
 String iVolTxt = "Initialize Volume";
 float pHRead;
 ///////  Vernier pH probe calibration values //////
 float calSlope = -0.0032234;     // reported slope = -250 mV / pH unit, 
                       //    m = -3300 mV full scale / (4095 digits full scale * 250 mV / pH unit)
 float calInt =  14;                // Reported value of 1.75 volts at pH 7
                       //  b = 3500 mV at zero * 4095 digits full scale / 
 
boolean showPumpParams = false;
boolean pHBox = false;        // display pH box
boolean volInitialized = false;
int Ss;                          //The dropdown list will return a float value, which we will connvert into an int. we will use this int for that).
String[] comList ;               //A string to hold the ports in.
String[] comList2;               // string to compare comlist to and update
boolean serialSet;               //A value to test if we have setup the Serial port.
boolean Comselected = false;     //A value to test if you have chosen a port in the list.
String runTxt;
String Modetorun;                //Nov 11, 2013
float Mod;
boolean Modesel = false;         //Nov 11, 2013  

String toSignal = "0";
String toVol = "1";
String Titrate = "2";

int overlay = 0;
float[] nullData = {0};
float[] nullY = {0};

boolean stop = true;
boolean run = false;           // start run at bang
float p1;
float p2;
 ////////////// the next 6 lines are all in current WheeStat //////////

//String Go = "1";
//String star = "*";

///////////////Added 11/25/13/////////////
String sData3; // 11/25
int LINE_FEED = 10; 
//String tab ="\t";
float[] xData = {0};   
float[] yData = {0};
float xRead;   
float yRead;
boolean gotparams = false;

String ComP;
int serialPortNumber;
String file1 = "logdata.txt";
String file2;                  // save file path
String[] sData = new String[3];  //String sData;
String sData2 = " ";
char cData2;
int i =0;
int p = 0;           //stop signal
/////////////////////////////////////////
//////////////font variables///////////////////////////////
  PFont font = createFont("arial", 20);
  PFont font2 = createFont("arial", 16);
  PFont font3 = createFont("arial",12); 
  PFont font4 = createFont("andalus",16);
/////////////// setup ////////////////////////////////////////
void setup() {
 // charts_gic_setup();
  size(850, 550); // (500, 550)
  if(frame!= null){
    frame.setResizable(true);
  }
 cp5_controllers_setup();
 setup_bangs();
 charts_gic_setup();
 dropdownSetup();
   checkBoxes();
    frameRate(2000);

 

 ///////////////////////////////////////text area//////////////////////////

 
 comPortTxtArea = cp5.addTextarea("txt2")          // serial port connected text area
    .setPosition(170, 5)
      .setSize(100, 20)
        .setFont(createFont("arial", 12)) //(font)
          .setLineHeight(10)
            .setColor(#030302)
              .setColorBackground(#CEC6C6)
                .setColorForeground(#AA8A16)//#CEC6C6                 
                    ;  

 initialVol.hide();
}
///////////////////End Setup/////////////////////////////

 void draw() {
 background(#162181);  
  stroke(255);
  noFill();
  
textFont(font2);
fill(255);
text(pmpEnTxt, 35,45);          // enable pump 
text(mtrEnTxt, 220, 45);        // enable pH meter
    textFont(font);
//     text(curVol, 200,180);


   if (showPumpParams == false){
     frame.setSize(500,200);       // size window for no syringe parameters
     Syringe_V.hide(); 
     Disp_V.hide();
     Syringe_Dia.hide();
     n_Addns.hide();
     ad_Delay.hide();
     Speed.hide();
     mode.hide();
     directBox.hide();
     }

  else {
    text("Current Vol (mL):", 20,100);
    showParams();
    directBox.show();
    Syringe_V.show();

     Syringe_Dia.show();

     Speed.show();
     mode.show();
       noFill();
     rect (12,70+movPar,160,85);     // originally 12,50
     rect (12,163+movPar,160,85);
   
//  }

  if (Modetorun == "toVol"){
    frame.setSize(850,550);
    Disp_V.show();
    ad_Delay.hide();
    n_Addns.hide();
     }

  else if (Modetorun == "Titrate"){
   frame.setSize(850,550);  // specifies the size of the window to display
     n_Addns.show();
     ad_Delay.show();
     Disp_V.show();
       rect (12,256+movPar,160,85);
       textFont(font2);
       fill(250,250,250);             //Chart heading color
       textSize(16);
       text("Multiple Injections", 20, 276+movPar);
  //////////////////Chart stuff ///////// 
       fill(#EADFC9);               // background color
       rect(380, 50, 445, 420);    // chart background
       fill(250,250,250);             //Chart heading color
       textSize(16);
       lineChart.draw(400, 50, 400, 400);    //early lineChart
       }  // end of titration specific draw commands
       
  else {
        frame.setSize(450,550);
           Disp_V.hide();
           ad_Delay.hide();
           n_Addns.hide();
         }
   }  // end of if showPumpParams == true commands
 
  if (pHBox == false){   
       pHRec.hide();  
       }
       else {
         textSize(24);
         text("Measured pH", 210,100);
         text(pHRead,210,125);
//         text("7.00", 210, 125);
         textSize(16);
         text(recTxt, 220, 60);
         pHRec.show();
       }
 

   if (run == true) {
      runTxt = "Stop";
      stop = false;
      }
   else { 
      stop = true;
      runTxt = "Run";
      } 

  textFont(font4,18);
/*pushMatrix();
 fill(#DEC507);
text("Smoky Mountain",30,height-30);
 text("Scientific",58,height-12);
  textFont(font,18);
  fill(255);
  text(runTxt, 75, height-90);
  popMatrix();    
 pushMatrix();
 textFont(font,12);
// fill(#080606);
 fill(#DEC507);
 text("https://github.com/SmokyMountainScientific",250,height-23);
 popMatrix();   */



/////////////////////// Start run ///////////////////////

if (run == true)
  {
    
    if(gotparams == false)   // added to update chart in real time BH
    {
//      if (yData.length != 0 && overlay == 0) {
        if (yData.length != 0 ) {   // copied from WheeStat-Oct30,14
  xData = nullData;  /// Clear X and Y data to redraw chart
  yData = nullY;
  inVol = 0;
 // xData[0] = 0;  //shows up in the final graph when in SerialRead.
     }
      getParams();
        delay(100);
        serialPort.write("&");            //
        println("run = true"); 
      delay(100);
      if (Modetorun == "toSignal"){
          serialPort.write("000000");
          println("mode to run = toSignal");
         }
      if (Modetorun == "toVol"){   
         serialPort.write("000001");
          println("mode to run = toVol");  
         }
      if (Modetorun == "Titrate"){
         serialPort.write("000002");
         println("mode to run = Titrate");
         }
      if (Modetorun == "pHAdjust"){
         serialPort.write("000003");
         println("mode to run = pHAdjust");
         }
      println(Syringe_Vol);
         delay(100);
         serialPort.write(Syringe_Vol);
      println(Syringe_D);
        delay(100);
        serialPort.write(Syringe_D);
      println(Disp_Vol);
        delay(100);
        serialPort.write(Disp_Vol);
      println(Dir);   
        delay(100);
        serialPort.write(Dir);  // got error here, NullPointerException--fixed in boolean above
      println(Spd);
        delay(100);
        serialPort.write(Spd);
      println(n_Adds);
        delay(100);
        serialPort.write(n_Adds);

      println(ad_Del);
        delay(100);
        serialPort.write(ad_Del);
  //    writeParams();
      p=0;                    // reset counter for serial read
      println("begin run");   // shows up in bottom window
     delay(100);
//    serialPort.write('2');     // cut 3-7-14, value of 2 added to prevent non-specific trigger
//      println(165);           // gets to here
      
      logData(file1, "", false);     // log data to file 1, do not append, start new file
      
      ////////read parameter input until LaunchPad transmits '&'/////////
      while (cData!='&'&& cData !='@')  { // @ symbol not used, line cut 10/23/14 
           
          if (serialPort.available () <= 0) {}
          if (serialPort.available() > 0)
          {
            cData =  serialPort.readChar();     // cData is character read from serial comm. port
            sData2 = str(cData);            //sData2  is string of cData 
  /*          if (cData =='@') {
              println("end of acquisition, line 239");
                         gotparams = false;
          comPortTxtArea.setColor(#036C09);
          comPortTxtArea.setText("FINISHED");
//          whu = 1;
          cData = 'a';   
            }  */
            logData(file1, sData2, true);   // at this point we are logging the parameters
             println(sData2);               // added 10/23, from WheeStat GUI
            if (cData == '&')               //  Launchpad sends & char at end of serial write
            {
              println("parameters received");
              gotparams = true;
              
              logData(file1,"\r\n",true);  // added 6/13-from Ben, what does this do?
            }
            }

           }
//      }
      

println("line 274");  //gets to here as long as reset pushed between runs.
 
  }            // end of "if (gotparams is false) loop
    
 

      //////////// graph data //////////////////////////////////////////////
//  if (Modetorun == "Titrate" || Modetorun == "toVol" || Modetorun == "toSignal") {        // only collect data for titration
          read_serial();
       
        if (xData.length>3 && xData.length==yData.length)
        {
          float yMinVal = min(yData);
          if (yMinVal > 4) {
            yMinVal = 4;
            }
          float yMaxVal = max(yData);
           if (yMaxVal < 10) {
            yMaxVal = 10;
            }
         
          lineChart.setMaxX(max(xData));
          lineChart.setMaxY(yMaxVal);
          lineChart.setMinX(min(xData));
          lineChart.setMinY(yMinVal);
          lineChart.setData(xData, yData);

  //        updatechart = i;
        }                   // End of if xData length stuff
  }                          // end of if(run == true) loop
}                            // end of draw loop

public void showParams() {

  textFont(font2);
  fill(250,250,250);             //Chart heading color
  textSize(16);
//////text for headings ////////
  text("Syringe Parameters", 20, 90+movPar);
  text("Injection", 20, 183+movPar);
  text(dirTxt,35, 60);
  text(iVolTxt,35,75);
  textSize(24);
 // text(curVol, 30,125);  
  text(fVol, 30,125);
}



