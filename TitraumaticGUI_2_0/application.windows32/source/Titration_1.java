import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import org.gicentre.utils.gui.TextPopup; 
import org.gicentre.utils.stat.*; 
import org.gicentre.utils.multisketch.*; 
import controlP5.*; 
import processing.serial.*; 
import java.io.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Titration_1 extends PApplet {

/**
 *GUI for running syringe pump. 
 * Based on BHickman work on potentiostat GUI
 * Jack Summers and Angela Edwards 
 * Compatible with Energia Step_mot4b program. 
 * Com port selection tool works
 */
 
///////////////////////////////////////// Imports/////////////////////////////////
 // for warning window
    // For chart classes.
 // for integration window


                        // this is needed for BufferedWriter
///////////////////////////////////////////////////////////////Classes///////////////
 
XYChart lineChart;  //new 7/31/13

ControlP5 cp5,cp5b,cp5c;
Serial serial;
Textarea myTextarea;   // com port and status window
Textarea myTextarea2;   // save file path window
//Textarea warningtxt;  // text for warning window commented out 8/14
Textfield Syringe_V, Disp_V, Syringe_Dia, n_Addns, ad_Delay, maxLength, Direction, Speed;
DropdownList ports, mode;              //Define the variable ports and mode as a Dropdownlist.
//////////////////////////////////variables//////////////////////
String Syringe_Vol;
String Disp_Vol;
String Syringe_D;
String n_Adds;
String ad_Del;
String maxL;
String Dir; 
String Spd;
char[] strtochar;
char cData;
String sData3 ="";
String[] sData = new String[3];  //String sData;
float[] V = {0};
float[] I1 = {0};
//float[] I2 = {0};

int Ss;                          //The dropdown list will return a float value, which we will connvert into an int. we will use this int for that).
String[] comList ;               //A string to hold the ports in.
String[] comList2;               // string to compare comlist to and update
boolean serialSet;               //A value to test if we have setup the Serial port.
boolean Comselected = false;     //A value to test if you have chosen a port in the list.
/*
int Modi; 
boolean Modesel = false;

String Modetorun;
int xacu;
int yacu;
float xspace;
float yspace;
ArrayList qdat;  
*/
boolean bool = false;           // start run at bang
float p1;
float p2;

String ComP;
int serialPortNumber;
/*String file1 = "logdata.txt";
String file2;
String file;
String[] sData = new String[3];  //String sData;
String sData2 = " ";
char cData;
// int logDelay = 1000;

String ASVmod = "1";
String CVmod = "2";
String TIMEDmod = "3";
String LOG_ASVmod = "4";
*/
String Go = "1";
String star = "*";
int i =0;
/*float[] V = {0};
float[] I1 = {0};
float[] I2 = {0};
float[] Idif = {0};
float[] newV = {0};
float[] newI1 = {0};
float[] newI2 = {0};
float[] newIdif = {0};
*/
//////////////font variables///////////////////////////////
  PFont font = createFont("arial", 20);
  PFont font2 = createFont("arial", 16);
  PFont font3 = createFont("arial",12); 
  PFont font4 = createFont("andalus",16);
/////////////// setup ////////////////////////////////////////
public void setup() {
 // charts_gic_setup();
  cp5_controllers_setup();
  setup_bangs();
    charts_gic_setup();
    frameRate(2000);
  size(850, 550); // (500, 550)
//  textFont(font2);
//  frame.setResizable(true);
//  charts_gic_setup();
 // cp5_controllers_setup();
//////////////////////////////////////////Dropdownlist////////////////////////////////////////
  ports = cp5.addDropdownList("list-1", 10, 30, 100, 84)
    .setBackgroundColor(color(200))
      .setItemHeight(10) 
        .setBarHeight(20) 
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              .setUpdate(true)
                ;
  ports.captionLabel().set("Select COM port");
  ports.captionLabel().style().marginTop = 3;
  ports.captionLabel().style().marginLeft = 3;
  ports.valueLabel().style().marginTop = 3;
  comList = serial.list(); 
  for (int i=0; i< comList.length; i++)
  {
    ports.addItem(comList[i], i);
  } 
 ///////////////////////////////////////text area//////////////////////////

 
  myTextarea2 = cp5.addTextarea("txt2")
    .setPosition(170, 5)
      .setSize(100, 20)
        .setFont(createFont("arial", 12)) //(font)
          .setLineHeight(10)
            .setColor(0xff030302)
              .setColorBackground(0xffCEC6C6)
                .setColorForeground(0xffAA8A16)//#CEC6C6                 
                    ;


}
///////////////////End Setup/////////////////////////////


public void draw() {

background(0);
//  background(58, 2, 67);  
 
/*  fill(58, 2, 67);
  noStroke();
  rect(0, 80, 780, 580);  
 fill(#EADFC9);//#FFFEFC);
 noStroke();    
 rect(200, 80, 580, 580);
 textFont(font4,18); 
*/ 
pushMatrix();
 fill(0xffDEC507);
text("Cullowhee",30,height-47);
 text("Scientific",58,height-23);
 popMatrix(); 
 pushMatrix();
 textFont(font,12);
// fill(#080606);
 fill(0xffDEC507);
 text("https://github.com/WheeSci",250,height-23);
 popMatrix(); 
 textFont(font2);

  fill(120);             //moved from potentiostat GUI
    textSize(16);
    text("Titration Data", 450, 50);
//   try{
 //   lineChart.setXAxisLabel("uL added titrant");
//   lineChart.setYAxisLabel("response (V)");
    lineChart.draw(400, 50, 400, 400);  //(400, 50, 600, 450);
    
/*    }
        catch(Exception e){
      if(V.length >2){
        V = subset(V,1);
        I1= subset(I1,1);
        I2= subset(I2,1);
        Idif = subset(Idif,1);
        println("exception");  
*/
if (bool == true) {        
    println("bool = true"); 
       Syringe_V();
       Disp_V();
       Syringe_Dia();
       nAddns();
       ad_Delay();
       maxLength();
       Direction();
       Speed();
       
    /*   V = newV;  //float[]
    I1 = newI1;
    I2 = newI2;
    Idif = newIdif;

//    if (Modetorun=="ASV") {  */

/*      End_Voltage();
      Scan_Rate();
      Delay_Time();
      serial.write(StartV);
      delay(100);
      serial.write(EndV);
      delay(100);
      serial.write(ScanR);
      delay(100);
      serial.write(DelayT);
      delay(100);
      serial.write(ASVmod);  // prg 1 for ASV
*/
//delay(100);
//serial.write(Go);
      println(Syringe_Vol);
      println(Disp_Vol);
      println(Syringe_D);
      println(n_Adds);
      println(ad_Del);
      println(Spd);
      println(Dir);  
      
      println(Go);      
      // moved up
      delay(100);
serial.write(Syringe_Vol);
delay(100);
serial.write(Syringe_D);
delay(100);
serial.write(Disp_Vol);
delay(100);
serial.write(Dir);  // got error here, NullPointerException--fixed in boolean above
delay(100);
serial.write(Spd);
delay(100);
serial.write(n_Adds);
delay(100);
serial.write(ad_Del);
delay(100);
serial.write(Go);      

/*      println(EndV);
      println(ScanR);
      println(DelayT);
      println(ASVmod);
      println(Go);
      read_serialASV();
*/    }



    bool=false;  }
    
//  }

/////////////////////////////Bang's///////////////////////////////////////////////////////////
public void setup_bangs() {
  cp5.addBang("Start_Run")
    .setColorBackground(0xffFFFEFC)//#FFFEFC 
        .setColorCaptionLabel(0xff030302) //#030302
          .setColorForeground(0xffAA8A16)
          .setColorActive(0xff06CB49)
            .setPosition(200, 380)
              .setSize(150, 40)
                .setTriggerEvent(Bang.RELEASE)
                  .setLabel("Start Run") //
                    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                      ;

  cp5.addBang("Connect")
    .setColorBackground(0xffFFFEFC)//#FFFEFC 
        .setColorCaptionLabel(0xff030302) //#030302
          .setColorForeground(0xffAA8A16)  
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
  myTextarea2.setColor(0xffD8070E);
  myTextarea2.setText("RUNNING SCAN");
}
/////////////////////////////////////////////////group programs/////////////////////////////////

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) 
  {
    if (theEvent.name().equals("list-1")) {//if (theEvent.getGroup().equals("list-1")) {

      float S = theEvent.group().value();
      Ss = PApplet.parseInt(S);
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


public void cp5_controllers_setup() {
 cp5 = new ControlP5(this);  //cp5 = new ControlP5(this);
  PFont font = createFont("arial", 20);
  PFont font2 = createFont("arial", 16);
  PFont font3 = createFont("arial",12); 
  
  
  Syringe_V = cp5.addTextfield("Syringe_V")
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6)//(#FFFEFC) 
        .setColorForeground(0xffAA8A16) 
          .setPosition(200, 100)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)                
                    .setText("1");
                      controlP5.Label svl = Syringe_V.captionLabel(); 
                        svl.setFont(font3);
                          svl.toUpperCase(false);
                            svl.setText("Syringe Volume (mL)");
  ;
  
    Disp_V = cp5.addTextfield("Disp_V")
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
       .setColorForeground(0xffAA8A16) 
         .setPosition(20, 100)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                   .setText("0200");
                      controlP5.Label evl = Disp_V.captionLabel(); 
                        evl.setFont(font3);
                          evl.toUpperCase(false);
                            evl.setText("Dispense Volume (uL)");
  ;

    Syringe_Dia = cp5.addTextfield("Syringe_Dia")
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
       .setColorForeground(0xffAA8A16) 
         .setPosition(200, 180)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                   .setText("05");
                      controlP5.Label srl = Syringe_Dia.captionLabel(); 
                        srl.setFont(font3);
                          srl.toUpperCase(false);
                            srl.setText("Syringe Diameter (mm)");
  ;
  
  n_Addns = cp5.addTextfield("n_Addns")
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
        .setColorForeground(0xffAA8A16) 
          .setPosition(20, 180)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                  .setText("10");
                      controlP5.Label dtl = n_Addns.captionLabel(); 
                        dtl.setFont(font3);
                          dtl.toUpperCase(false);
                            dtl.setText("Number of Additions (2 digits)");                    
  ;

ad_Delay = cp5.addTextfield("ad_Delay")
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
        .setColorForeground(0xffAA8A16) 
          .setPosition(20, 260)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                  .setText("005");
                      controlP5.Label invl = ad_Delay.captionLabel(); 
                        invl.setFont(font3);
                          invl.toUpperCase(false);
                            invl.setText("Delay Between Injections (s)");
  ;


  maxLength = cp5.addTextfield("maxLength")  // txt field
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
         .setColorForeground(0xffAA8A16) 
           .setPosition(200, 260)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                   .setText("60");
                      controlP5.Label fnlvl = maxLength.captionLabel(); 
                        fnlvl.setFont(font3);
                          fnlvl.toUpperCase(false);
                            fnlvl.setText("Length of Syringe");                    
  ;
  
     Direction = cp5.addTextfield("Direction")  // time txt field
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
        .setColorForeground(0xffAA8A16) 
          .setPosition(20, 420)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                    .setText("0");
                      controlP5.Label norl = Direction.captionLabel(); 
                        norl.setFont(font3);
                          norl.toUpperCase(false);
                            norl.setText("Direction (0 = withdraw, 1 = infuse)");                    
  ; 
  
      Speed = cp5.addTextfield("Speed")  // time based txt field
    .setColor(0xff030302) 
      .setColorBackground(0xffCEC6C6) 
        .setColorForeground(0xffAA8A16) 
          .setPosition(20, 340)
            .setSize(80, 32)
              .setFont(font2)
                .setFocus(false)
                    .setText("10");
                      controlP5.Label ril = Speed.captionLabel(); 
                        ril.setFont(font3);
                          ril.toUpperCase(false);
                            ril.setText("Injection Speed (0-10)");                    
  ;

  
}
//////////////////////////////////////text field programs////////////////////////////////

public void Syringe_V() {              //get syringe volume from text box
  Syringe_Vol = cp5.get(Textfield.class, "Syringe_V").getText();
 int iSyringe_V = round(1000*PApplet.parseFloat(Syringe_Vol));
  Syringe_Vol = nf(iSyringe_V, 5);   // make StartV have 4 digits. pad with zero if no digits
}

public void Disp_V() {              //get Dispensed volume from text box
  Disp_Vol = cp5.get(Textfield.class, "Disp_V").getText();
 int iDisp_V = round(PApplet.parseFloat(Disp_Vol));
  Disp_Vol = nf(iDisp_V, 4);   // make StartV have 4 digits. pad with zero if no digits
}
public void Syringe_Dia() {              //get Syringe diameter from text box
  Syringe_D = cp5.get(Textfield.class, "Syringe_Dia").getText();
 int iSyr_D = round(PApplet.parseFloat(Syringe_D));
  Syringe_D = nf(iSyr_D, 2);   // make StartV have 2 digits. pad with zero if no digits
}

public void nAddns() {              //number of Additions from text box
  n_Adds = cp5.get(Textfield.class, "n_Addns").getText();
 int iAdds = round(PApplet.parseFloat(n_Adds));
  n_Adds = nf(iAdds, 2);   // make StartV have 2 digits. pad with zero if no digits
}

public void ad_Delay() {              //Delay between additions from text box
  ad_Del = cp5.get(Textfield.class, "ad_Delay").getText();
 int iadDel = round(PApplet.parseFloat(ad_Del));
  ad_Del = nf(iadDel, 3);   //  3 digits. pad with zero if no digits
}

public void maxLength() {              //syringe length from text box
  maxL = cp5.get(Textfield.class, "maxLength").getText();
 int imaxL = round(PApplet.parseFloat(maxL));
  maxL = nf(imaxL, 3);   //  pad with zero if no digits
}

public void Speed() {              //inject or withdraw
  Spd = cp5.get(Textfield.class, "Speed").getText();
 int ispd = round(PApplet.parseFloat(Spd)); 
  Spd = nf(ispd, 2);   
}

public void Direction() {              //inject or withdraw
  Dir = cp5.get(Textfield.class, "Direction").getText();
  int iDir = round(PApplet.parseFloat(Dir));  //*2-1;
  Dir = nf(iDir,1);   // make StartV have 3 digits. pad with zero if no digits
//  Dir = nf(iDir, 2);   // make StartV have 3 digits. pad with zero if no digits
}
public void charts_gic_setup(){
  
              ////////////////////////////////gicentre charts///
  lineChart = new XYChart(this);
  lineChart.setData(new float[] {1, 2, 3}, new float[] {1, 2, 3});
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true);
  lineChart.setXAxisLabel("Added Titrant (uL)");
  lineChart.setYAxisLabel("Response (mV)"); 
  //lineChart.setMinY(0);   
  lineChart.setYFormat("##.##");  
  lineChart.setXFormat("##.##");       
  // Symbol colours
  lineChart.setPointColour(color(234, 28, 28));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);


  
}/////////////////////////////////////////////////end charts_gic_setup///////////////////////////////////////////////
public void logData( String fileName, String newData, boolean appendData)  //char//void logData( String fileName, String newData, boolean appendData)
{
  BufferedWriter bw=null;
  try { //try to open the file
    FileWriter fw = new FileWriter(fileName, appendData);
    bw = new BufferedWriter(fw);
    bw.write(newData);// + System.getProperty("line.separator"));
  } 
  catch (IOException e) {
  } 
  finally {
    if (bw != null) { //if file was opened try to close
      try {
        bw.close();
      } 
      catch (IOException e) {
      }
    }
  }
}

public void  read_serialCV() {
 
   
       for(int l=0;l<strtochar.length;l++){
      cData = strtochar[l];
      if (cData!='\n') { 
       sData3 = sData3+str(cData);
      }
      if (cData =='\n') {
        //int i =0;
        sData = split(sData3,"\t");     
        sData = trim(sData);
       // println("sDat "+sData.length);
        if (sData.length ==2) { //if(sData.length >1){
          float[] fData= PApplet.parseFloat(sData);
          boolean fcatch = false;
          /*if(fData[0] ==  || fData[1] == NaN){
          fcatch = true;
          } */
          if (i==0 && fcatch == false) {
            V[i] = fData[0];
            I1[i]=fData[1]; //    g1[i]=fmap[i];
          }
          if (i>0 && fcatch == false) {
            V = append(V, fData[0]);
            I1 = append(I1, fData[1]); //g1 = append(g1,fmap[i]);
          }
          //Idif[i] = I2[i]-I1[i];

          i +=1;// ++i;
         // sData3 = "";
        }   
        sData3 = " ";
      }
  }
   
 } 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "Titration_1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
