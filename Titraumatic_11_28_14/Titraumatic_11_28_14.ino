//////////////////////////////////////////////////////////////////
// Titraumatic Automatic Titrator
// First tab, Titraumatic_11_28_14
// incorporates status command.  when % transmitted by GUI, board reset
// reads voltage from pH electrode on pin 1.6, 
//  voltage from electrode is output to serial monitor
// stepper motor controll using easy driver
// initial code copied from Arduino ©2011 bildr  
// Released under the MIT License - Please reuse change and share
// 
// Button inputs vcc to pin PA_2 at syringe limits
// speed is given in uL/s - 
// Slower Speed == Stronger movement
// written by Angela Edwards & J Summers - 8/27/13
//
// Data written to GUI in the form; uL added, digital measurement from electrode, commmand
// command indicates where you are in the experiment

/////////////////////////////////////////////////////////////////

// Inputs;
//  syringe diameter              dia           mm
//  syringe volume                vTotal        mL
//  direction (fill or dispense)  InOut  
//  number of additions           nAddns
//  time between additions        adDelay       sec
//                                delayMin      min
//  volume per addition           dispVol       uL
//  screw pitch   (revolutions per cm of plunger displacement)
//                                pitch
//  3 modes;  fill, continuous run, or titration
///////////////////////////////////////////////////////////////////

#define dirPin PE_0         //output determines whether sample injected or removed
#define stepPin PF_0          //  outputs every time the stepper moves 1/8th step
                              //  200 steps per revolution
//#define SLEEP_PIN PB_2
//#define stop_Pin PB_5        //  stops the fill 
const int analogInPin = A8;  // Pin 6:  Analog input pin where the pH electrode connects
//#define refPin PB_5
int sensorValue = 0;        // value read from the electrode
#define endStop PB_5

unsigned long stepCount = 0;         // number of steps the motor has taken  
unsigned int rotations;

//int SLEEP; 
int dia;                      // 5 mm dia
unsigned int sVol;            //one mL syringe
int fillmode =0;   // run, fill, or titrate
boolean runState=false;      //0 is off, 1 is on
int nAddns;          // number of additions 
int adDelay;         //  seconds between each addition in seconds
float Area;
int woi;             // withdraw or infuse; 0 = infuse, 1 = withdraw
unsigned long steps;
float injCyc;       // cycles to inject
int dispVol;        // uL dispensed per addition
int spd;    
float fspd;         //injection speed, 
float usDelay;        // microseconds between pulses, frequency = 1/(2*usDelay)
float pitch = 7.874; // 20 thread per inch, in threads/cm plunger displacement
int param =0;      // paramater used in readParams routine in setup
int addedVol;               // volume of titrant added to reaction
int currentVol;             // volume of titrant currently in syringe

void setup() { 
//  pinMode(stop_Pin, INPUT);
  pinMode(RED_LED, OUTPUT);
  pinMode(dirPin, OUTPUT); 
  pinMode(stepPin, OUTPUT);
   pinMode(endStop, INPUT_PULLDOWN); 
//  pinMode(SLEEP, OUTPUT); // set pin P1_4 to output
  Serial.begin(9600);             //  begin serial comm. at 9600 baud
} 

void loop(){ 
if(runState == false){
  digitalWrite(RED_LED, HIGH);
  delay(500);

}
else{
digitalWrite(RED_LED, LOW);
}
//  digitalWrite(SLEEP, LOW);         // switch off the power to stepper

setupRun();
 if(fillmode==0) {
    runToSignal();
//    Serial.println("99999,0,2");       // end signal added 10/22/14
/*    Serial.print(",");
    Serial.print(00000);
    Serial.print(",");
    Serial.println("2"); */  
 }
 else if (fillmode==1) {
    runToVol();
//     runState = false;
//    Serial.println("99999,0,0");       // end signal added 10/22/14 
  //  Serial.println(",0,0");
//    Serial.println(00000);
   }
 else if (fillmode==2) {
    run_titration();
  //  Serial.println("99999,0,0");       // end signal added 10/22/14
 //   Serial.print(",");
 //   Serial.println(00000);
    }
    else{
//    run_pHAdjust();
    }
}
