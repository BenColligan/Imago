SimpleUI ui;
PImage originalImg, liveImg;
int windowWidth = 800, windowHeight = 800;
String lastFileSelection;

// POINT PROCESSING FUNCTIONS
///////////////////////////////////////////////////////////////////////////////////////////
PImage darken(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < img.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      float r = red(clr)/255;
      float g = green(clr)/255;
      float b = blue(clr)/255;

      float newR = r * 0.9;
      float newG = g * 0.9;
      float newB = b * 0.9;
      
      returnImg.set(x, y, color(newR*255,newG*255,newB*255));
    }
  }
  
  return returnImg;
}

PImage brighten(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < img.width; x++) {    
    for (int y = 0; y < returnImg.height; y++) {
      color clr = returnImg.get(x,y);
      float r = red(clr)/255;
      float g = green(clr)/255;
      float b = blue(clr)/255;

      float newR = r * 1.10;
      float newG = g * 1.10;
      float newB = b * 1.10;
      
      returnImg.set(x, y, color(newR*255,newG*255,newB*255));
    }
  }
  
  return returnImg;
}

PImage greyscale(PImage img) {
  PImage returnImg = img;
  
  for (int x = 0; x < img.width; x++) {    
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
///////////////////////////////////////////////////////////////////////////////////////////

void settings() {
  size(windowWidth,windowHeight);
}

void setup() {
  ui = new SimpleUI();
  imageMode(CENTER);
  
  String[] fileMenuEntries = {"Open...", "Save...", "Revert changes"};
  ui.addMenu("File", 10, 10, fileMenuEntries);
  
  String[] effectsMenuEntries = {"Greyscale", "Brighten +10%", "Darken -10%"};
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
  if (uied.eventIsFromWidget("Greyscale")) liveImg = greyscale(liveImg);
  if (uied.eventIsFromWidget("Brighten +10%")) liveImg = brighten(liveImg);
  if (uied.eventIsFromWidget("Darken -10%")) liveImg = darken(liveImg);
  
  if (uied.eventIsFromWidget("fileLoadDialog")) {
    lastFileSelection = uied.fileSelection;
    originalImg = loadImage(uied.fileSelection);
    liveImg = originalImg;
  }
  
  if (uied.eventIsFromWidget("fileSaveDialog")) liveImg.save(uied.fileSelection);
  
  uied.print(3);
}
///////////////////////////////////////////////////////////////////////////////////////////
