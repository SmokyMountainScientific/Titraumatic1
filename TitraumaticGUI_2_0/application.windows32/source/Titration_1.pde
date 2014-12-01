/**
 *GUI for running syringe pump. 
 * Based on BHickman work on potentiostat GUI
 * Jack Summers and Angela Edwards 
 * Compatible with Energia Step_mot4b program. 
 * Com port selection tool works
 */
 
///////////////////////////////////////// Imports/////////////////////////////////
import org.gicentre.utils.gui.TextPopup; // for warning window
import org.gicentre.utils.stat.*;    // For chart classes.
import org.gicentre.utils.multisketch.*; // for integration window
import controlP5.*;
import processing.serial.*;
import java.io.*;                        // this is needed for BufferedWriter
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
void setup() {
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
            .setColor(#030302)
              .setColorBackground(#CEC6C6)
                .setColorForeground(#AA8A16)//#CEC6C6                 
                    ;


}
///////////////////End Setup/////////////////////////////


void draw() {

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
 fill(#DEC507);
text("Cullowhee",30,height-47);
 text("Scientific",58,height-23);
 popMatrix(); 
 pushMatrix();
 textFont(font,12);
// fill(#080606);
 fill(#DEC507);
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

