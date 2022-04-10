SimpleUI ui;
PImage originalImg, liveImg;
int windowWidth = 800, windowHeight = 800;
int[] brightenLUT, darkenLUT, contrastLUT, decontrastLUT, invertLUT;
String lastFileSelection;

// POINT PROCESSING FUNCTIONS
///////////////////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////////////////

void settings() {
  size(windowWidth,windowHeight);
}

void setup() {
  ui = new SimpleUI();
  imageMode(CENTER);
  
  darkenLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    darkenLUT[n] = (int)(n * 0.90); // Increase/decrease the darken amount here  
  }
  
  brightenLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    brightenLUT[n] = (int)(n * 1.1); // Increase/decrease the brighten amount here  
  }
  
  contrastLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    contrastLUT[n] = (int)((2.31 * (n - 128)) + 128);    
  }
  
  decontrastLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    decontrastLUT[n] = (int)((0.43 * (n - 128)) + 128);    
  }
  
  invertLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    invertLUT[n] = (int)255 - n;    
  }
  
  String[] fileMenuEntries = {"Open...", "Save...", "Revert changes"};
  ui.addMenu("File", 10, 10, fileMenuEntries);
  
  String[] effectsMenuEntries = {"Greyscale", "Invert", "Brightness +10%", "Brightness -10%", "Contrast +10%", "Contrast -10%"};
  ui.addMenu("Effects", 110, 10, effectsMenuEntries);
  
}

void draw() {
  background(200);
  
  if (liveImg != null) {
    if (liveImg.width >= windowWidth || liveImg.height >= windowHeight) {
      if (liveImg.width > liveImg.height) liveImg.resize(windowWidth - 40, 0);
      else liveImg.resize(0, windowHeight - 40);
    }
    
    image(liveImg, windowWidth/2, windowHeight/2);
  }
  
  ui.update();
}

// HANDLING UI EVENTS
///////////////////////////////////////////////////////////////////////////////////////////
void handleUIEvent(UIEventData uied) {
  if (uied.eventIsFromWidget("Open...")) ui.openFileLoadDialog("Open an image");
  if (uied.eventIsFromWidget("Save...")) ui.openFileSaveDialog("Save an image");
  if (uied.eventIsFromWidget("Revert changes")) liveImg = loadImage(lastFileSelection);
  
  if (uied.eventIsFromWidget("Greyscale")) {
    float start = millis();
    liveImg = greyscale(liveImg);
    float end = millis();
    print("Applied greyscale to image in " + (start - end) + "milliseconds");
    
  }
  
  if (uied.eventIsFromWidget("Brightness +10%")) {
    float start = millis();
    liveImg = brighten(liveImg);
    float end = millis();
    println("Brightened image in " + (end - start) + " milliseconds");
  }
  
  if (uied.eventIsFromWidget("Brightness -10%")) {
    float start = millis();
    liveImg = darken(liveImg);
    float end = millis();
    println("Darkened image in " + (end - start) + " milliseconds");
  }
  
  if (uied.eventIsFromWidget("Contrast +10%")) {
    float start = millis();
    liveImg = contrast(liveImg);
    float end = millis();
    println("Contrasted image in " + (end - start) + " milliseconds");      
  }
  
  if (uied.eventIsFromWidget("Contrast -10%")) {
    float start = millis();
    liveImg = decontrast(liveImg);
    float end = millis();
    println("Contrasted image in " + (end - start) + " milliseconds");      
  }
  
  if (uied.eventIsFromWidget("Invert")) {
    float start = millis();
    liveImg = invert(liveImg);
    float end = millis();
    println("Inverted image in " + (end - start) + " milliseconds");      
  }
  
  if (uied.eventIsFromWidget("fileLoadDialog")) {
    lastFileSelection = uied.fileSelection;
    originalImg = loadImage(uied.fileSelection);
    liveImg = originalImg;
  }
  
  if (uied.eventIsFromWidget("fileSaveDialog")) liveImg.save(uied.fileSelection);
  
  // uied.print(3);
}
///////////////////////////////////////////////////////////////////////////////////////////
