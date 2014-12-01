 void dropdownSetup() {
   //////////////////////////////////////////Dropdownlist////////////////////////////////////////
  ports = cp5.addDropdownList("list-1", 10, 30, 80, 84)
    .setBackgroundColor(color(200))
      .setItemHeight(20) 
        .setBarHeight(20) 
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              .setUpdate(true)
                ;
  ports.captionLabel().set("Select port");
  ports.captionLabel().style().marginTop = 3;
  ports.captionLabel().style().marginLeft = 3;
  ports.valueLabel().style().marginTop = 3;
  comList = serial.list(); 
  for (int i=0; i< comList.length; i++)
  {
    ports.addItem(comList[i], i);
  } 
  
  mode = cp5.addDropdownList("list-2", 300, 30, 100, 84)     //Nov. 1, 2013
    .setBackgroundColor(color(200))
      .setItemHeight(20)
        .setBarHeight(20)
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              .setUpdate(true)
                ;
  mode.captionLabel().set("Pump Mode");
  mode.captionLabel().style().marginTop = 3;
  mode.captionLabel().style().marginLeft = 3;
  mode.valueLabel().style().marginTop = 3;
  mode.setScrollbarWidth(10);
  mode.addItem("To Signal",0);
  mode.addItem("To Volume",1);
  mode.addItem("pH Adjust",3);
  mode.addItem("Titration",2);
//   mode.addItem("yoMomma",3);
  
  
  
 }
