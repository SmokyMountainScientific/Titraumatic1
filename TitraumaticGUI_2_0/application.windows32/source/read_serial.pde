void  read_serialCV() {
 
   
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
          float[] fData= float(sData);
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
