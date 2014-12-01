// get_Params tab
//////////////////////////////////////text field programs////////////////////////////////
public void getParams(){

////////////////get syringe volume from text box
  Syringe_Vol = cp5.get(Textfield.class, "Syringe_V").getText();
 int iSyringe_V = round(1000*float(Syringe_Vol));
  Syringe_Vol = nf(iSyringe_V, 6);   

//////////////get Dispensed volume from text box
  Disp_Vol = cp5.get(Textfield.class, "Disp_V").getText();
 int iDisp_V = round(float(Disp_Vol));
  Disp_Vol = nf(iDisp_V, 6);   

//////////////////get Syringe diameter from text box
  Syringe_D = cp5.get(Textfield.class, "Syringe_Dia").getText();
 int iSyr_D = round(float(Syringe_D));
  Syringe_D = nf(iSyr_D, 6);   

/////////////number of Additions from text box
  n_Adds = cp5.get(Textfield.class, "n_Addns").getText();
 int iAdds = round(float(n_Adds));
  n_Adds = nf(iAdds, 6);   

///////////////////////////Delay between additions from text box
  ad_Del = cp5.get(Textfield.class, "ad_Delay").getText();
 int iadDel = round(float(ad_Del));
  ad_Del = nf(iadDel, 6);   


/*public void maxLength() {              //syringe length from text box
  maxL = cp5.get(Textfield.class, "maxLength").getText();
 int imaxL = round(float(maxL));
  maxL = nf(imaxL, 6);   
}*/

//////////////////////////////            
  Spd = cp5.get(Textfield.class, "Speed").getText();
 int ispd = round(float(Spd)); 
  Spd = nf(ispd, 6);   


///////////////////////////          cut 11/10/14

/*  curVol = cp5.get(Textfield.class, "initialVol").getText();  // was currentVol
  fVol = float(curVol);
  println(fVol);  */
  
  
  int iDir = round(float(Dir));  //*2-1;
  Dir = nf(iDir,6);   

////////////////////////////////////////////////


}
