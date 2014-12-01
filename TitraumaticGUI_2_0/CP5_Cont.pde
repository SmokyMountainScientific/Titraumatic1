// CP5_Cont tab

void cp5_controllers_setup() {
  
int xSize = 45;
int ySize = 20;
int x1 = 20;
int x2 = 100;
int y1 = 100 + movPar;    // syringe parameters box y position
int y2 = 193 + movPar;      // injection parameters y position
int y3 = 286 + movPar;      // multi-injection parameters y position

 cp5 = new ControlP5(this);  //cp5 = new ControlP5(this);
  PFont font = createFont("arial", 16);
  PFont font2 = createFont("arial", 24);
  PFont font3 = createFont("arial",12); 
  
PImage[] imgs = {loadImage("run_button1.png"),loadImage("run_button2.png"),loadImage("run_button3.png")};
PImage[] img2 = {loadImage("stop_button1.png"),loadImage("stop_button2.png"),loadImage("stop_button3.png")};
//if (Modetorun == "Titrate"){
  cp5.addButton("play")
     .setValue(128)
     .setPosition(20,430)
     .setImages(imgs)
     .updateSize()
     ;
/*}
else {       // play button at higher position
  cp5.addButton("play")
     .setValue(128)
     .setPosition(20,330)
     .setImages(imgs)
     .updateSize()
     ;}
     */
     run = false;
     stop = true;
     
  Syringe_V = cp5.addTextfield("Syringe_V")
    .setColor(#030302) 
      .setColorBackground(#CEC6C6)//(#FFFEFC) 
        .setColorForeground(#AA8A16) 
          .setPosition(x1, y1)
            .setSize(xSize, ySize)
              .setFont(font)
                .setFocus(false)                
                    .setText("10");
                      controlP5.Label svl = Syringe_V.captionLabel(); 
                        svl.setFont(font3);
                          svl.toUpperCase(false);
                            svl.setText("Volume (mL)");
  ;

  
    Disp_V = cp5.addTextfield("Disp_V")
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
       .setColorForeground(#AA8A16) 
         .setPosition(x1, y2)
            .setSize(xSize, ySize)
              .setFont(font)
                .setFocus(false)
                   .setText("0200");
                      controlP5.Label evl = Disp_V.captionLabel(); 
                        evl.setFont(font3);
                          evl.toUpperCase(false);
                            evl.setText("Volume (uL)");
  ;

    Syringe_Dia = cp5.addTextfield("Syringe_Dia")
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
       .setColorForeground(#AA8A16) 
         .setPosition(x2, y1)
            .setSize(xSize, ySize)
              .setFont(font)
                .setFocus(false)
                   .setText("15");
                      controlP5.Label srl = Syringe_Dia.captionLabel(); 
                        srl.setFont(font3);
                          srl.toUpperCase(false);
                            srl.setText("Diam. (mm)");
  ;
  
  n_Addns = cp5.addTextfield("n_Addns")
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(x1, y3)
            .setSize(xSize, ySize)
              .setFont(font)
                .setFocus(false)
                  .setText("10");
                      controlP5.Label dtl = n_Addns.captionLabel(); 
                        dtl.setFont(font3);
                          dtl.toUpperCase(false);
                            dtl.setText("Number");                    
  ;

ad_Delay = cp5.addTextfield("ad_Delay")
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(x2, y3)
            .setSize(xSize, ySize)
              .setFont(font)
                .setFocus(false)
                  .setText("005");
                      controlP5.Label invl = ad_Delay.captionLabel(); 
                        invl.setFont(font3);
                          invl.toUpperCase(false);
                            invl.setText("Delay (s)");
  ;
  
    initialVol = cp5.addTextfield("initialVol")  // time txt field
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(200, 200)
            .setSize(100, 35)
              .setFont(font2)
                .setFocus(false)
                    .setText(curVol);
                      controlP5.Label norl = initialVol.captionLabel(); 
                        norl.setFont(font3);
                          norl.toUpperCase(false);
                            norl.setText("Initial Volume (mL)");                    
  ; 
  
      Speed = cp5.addTextfield("Speed")  // time based txt field
    .setColor(#030302) 
      .setColorBackground(#CEC6C6) 
        .setColorForeground(#AA8A16) 
          .setPosition(x2, y2)
            .setSize(xSize, ySize)
              .setFont(font)
                .setFocus(false)
                    .setText("300");
                      controlP5.Label ril = Speed.captionLabel(); 
                        ril.setFont(font3);
                          ril.toUpperCase(false);
                            ril.setText("Speed (uL/s)");                    
  ;

  
}





