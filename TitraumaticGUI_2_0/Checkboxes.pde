 void checkBoxes()   { 
     PImage[] togs = {loadImage("tog_button3.png"),loadImage("tog_button2.png"),loadImage("tog_button1.png")};

     enableBox = cp5.addCheckBox("enableBox")     // enables pump and pH meter
                .setPosition(20, 35)  //35
                .setImages(togs[0],togs[1],togs[2])
                .setColorLabel(color(255))
                .setItemsPerRow(2)
                .setSpacingColumn(170)
                .setSpacingRow(2)
                .addItem("A", 1)
                .addItem("B", 2)
                ;
                

        
               
     directBox = cp5.addCheckBox("directBox")     // display these channels
                .setPosition(20, 50)
                .setImages(togs[0],togs[1],togs[2])
                .setColorLabel(color(255))
                .setSize(10, 10)
                .setItemsPerRow(1)
                .setSpacingColumn(30)
                .setSpacingRow(2)
                .addItem("Direction ", 1)
                .addItem("Initialize ", 2)          
                ;
                
   /*             iVolBox = cp5.addCheckBox("iVolBox")     // initialize volume
                //mofoBox = cp5.addCheckBox("mofoBox")     // initialize volume
                .setPosition(200, 100)
                .setImages(togs[0],togs[1],togs[2])
                .setColorLabel(color(255))
                .setItemsPerRow(1)
                .setSpacingColumn(170)
                .setSpacingRow(2)
                .addItem("mofo", 1)
//                .addItem("B", 2)  
                ;*/
     pHRec= cp5.addCheckBox("pHRec")
                .setPosition(202, 50)
                .setImages(togs[0],togs[1],togs[2])
                .setColorLabel(color(255))
                .setSize(20, 20)
                .setItemsPerRow(1)
                .setSpacingColumn(95)
                .setSpacingRow(15)
       
                .addItem("", 1)   //overlay
         //       .addItem("Calibrate ",10)          //mode
                                ;  

  }

 void keyPressed() {
  if (key==' ') {
//    enableBox.deactivateAll();
//    directBox.deactivateAll();
//    iVolBox.deactivateAll();
//    pHRec.deactivateAll();
  } 
  else {
    for (int i=0;i<1;i++) {
      // check if key 0-5 have been pressed and toggle
      // the checkbox item accordingly.
      if (keyCode==(48 + i)) { 
        // the index of checkbox items start at 0
        enableBox.toggle(i);
        directBox.toggle(i);
//        iVolBox.toggle(i);
        println("toggle "+enableBox.getItem(i).name());
        // also see 
        // checkbox.activate(index);
        // checkbox.deactivate(index);
      }
    }
  }
}


