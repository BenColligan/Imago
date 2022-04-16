SimpleUI ui;
PImage originalImg, liveImg;
int windowWidth = 800, windowHeight = 800, padding = 40;
int[] brightenLUT, darkenLUT, contrastLUT, decontrastLUT, invertLUT;
String lastFileSelection;

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
    float amount = 25.5;
    float factor = (259 * (amount + 255)) / (255 * (259 - amount));
    contrastLUT[n] = (int)(factor * (n - 128) + 128); // Increases the contrast by     
  }
  
  decontrastLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    float amount = -25.5;
    float factor = (259 * (amount + 255)) / (255 * (259 - amount));
    decontrastLUT[n] = (int)(factor * (n - 128) + 128); // Increases the contrast by    
  }
  
  invertLUT = new int[256];
  for (int n = 0; n < 256; n++) {
    invertLUT[n] = (int)255 - n;    
  }
  
  String[] fileMenuEntries = {"Open...", "Save...", "Revert Changes"};
  ui.addMenu("File", 10, 10, fileMenuEntries);
  
  String[] effectsMenuEntries = {"Greyscale", "Invert", "Edge Detect", "Blur", "Sharpen", "Gaussian Blur"};
  ui.addMenu("Effects", 110, 10, effectsMenuEntries);
  
  String[] adjustmentsMenuEntries = {"Brightness +10%", "Brightness -10%", "Contrast +10%", "Contrast -10%"};
  ui.addMenu("Adjustments", 210, 10, adjustmentsMenuEntries);
  
}

void draw() {
  background(200);
  
  if (liveImg != null) {
    if (liveImg.width > liveImg.height) {
      liveImg.resize(windowWidth - padding, 0);      
    } else {
      liveImg.resize(0, windowHeight - padding);    
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
  if (uied.eventIsFromWidget("Revert Changes")) liveImg = loadImage(lastFileSelection);
  
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
  
  if (uied.eventIsFromWidget("Edge Detect")) {
    float start = millis();
    liveImg = edgeDetect(liveImg);
    float end = millis();
    println("Edge detected image in " + (end - start) + " milliseconds");      
  }
  
  if (uied.eventIsFromWidget("Blur")) {
    float start = millis();
    liveImg = blur(liveImg);
    float end = millis();
    println("Blurred image in " + (end - start) + " milliseconds");      
  }
  
  if (uied.eventIsFromWidget("Sharpen")) {
    float start = millis();
    liveImg = sharpen(liveImg);
    float end = millis();
    println("Sharpened image in " + (end - start) + " milliseconds");      
  }
  
  if (uied.eventIsFromWidget("Gaussian Blur")) {
    float start = millis();
    liveImg = gaussianBlur(liveImg);
    float end = millis();
    println("Sharpened image in " + (end - start) + " milliseconds");      
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
