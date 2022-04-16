PImage invert(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < img.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      int r = (int)red(clr);
      int g = (int)green(clr);
      int b = (int)blue(clr);
      
      returnImg.set(x, y, color(invertLUT[r], invertLUT[g], invertLUT[b]));
    }
  }
  
  return returnImg;
}

PImage darken(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < img.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      int r = (int)red(clr);
      int g = (int)green(clr);
      int b = (int)blue(clr);
      
      returnImg.set(x, y, color(darkenLUT[r], darkenLUT[g], darkenLUT[b]));
    }
  }
  
  return returnImg;
}

PImage brighten(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < returnImg.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      int r = (int)red(clr);
      int g = (int)green(clr);
      int b = (int)blue(clr);

      returnImg.set(x, y, color(brightenLUT[r], brightenLUT[g], brightenLUT[b]));
    }
  }
  
  return returnImg;
}

PImage greyscale(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < returnImg.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      float r = red(clr)/255;
      float g = green(clr)/255;
      float b = blue(clr)/255;

      float newR = (r*0.3 + g*0.59 + b*0.11);
      float newG = (r*0.3 + g*0.59 + b*0.11);
      float newB = (r*0.3 + g*0.59 + b*0.11);
      
      returnImg.set(x, y, color(newR*255,newG*255,newB*255));
    }
  }
  
  return returnImg;
}

PImage contrast(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < returnImg.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      int r = (int)red(clr);
      int g = (int)green(clr);
      int b = (int)blue(clr);

      returnImg.set(x, y, color(contrastLUT[r],contrastLUT[g],contrastLUT[b]));
    }
  }
  
  return returnImg;
}

PImage decontrast(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < returnImg.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      int r = (int)red(clr);
      int g = (int)green(clr);
      int b = (int)blue(clr);

      returnImg.set(x, y, color(decontrastLUT[r],decontrastLUT[g],decontrastLUT[b]));
    }
  }
  
  return returnImg;
}
