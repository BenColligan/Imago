float[][] edge_matrix = { { 0,  -2,  0 },
                          { -2,  8, -2 },
                          { 0,  -2,  0 } };

float[][] blur_matrix = { {0.1,  0.1,  0.1 },
                          {0.1,  0.2,  0.1 },
                          {0.1,  0.1,  0.1 } };

float[][] sharpen_matrix = { { 0, -1, 0 },
                             {-1, 5, -1 },
                             { 0, -1, 0 } };
                             
float[][] gaussianblur_matrix = { { 0.000,  0.000,  0.001, 0.001, 0.001, 0.000, 0.000},
                                  { 0.000,  0.002,  0.012, 0.020, 0.012, 0.002, 0.000},
                                  { 0.001,  0.012,  0.068, 0.109, 0.068, 0.012, 0.001},
                                  { 0.001,  0.020,  0.109, 0.172, 0.109, 0.020, 0.001},
                                  { 0.001,  0.012,  0.068, 0.109, 0.068, 0.012, 0.001},
                                  { 0.000,  0.002,  0.012, 0.020, 0.012, 0.002, 0.000},
                                  { 0.000,  0.000,  0.001, 0.001, 0.001, 0.000, 0.000} };

color convolution(int Xcen, int Ycen, float[][] matrix, int matrixsize, PImage sourceImage)
{
  float rtotal = 0.0, gtotal = 0.0, btotal = 0.0;
   //<>//
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      int xloc = Xcen + i - (matrixsize / 2);
      int yloc = Ycen + j - (matrixsize / 2);
      
      if( xloc < 0 || xloc >= sourceImage.width) continue;
      if( yloc < 0 || yloc >= sourceImage.height) continue;
      
      color col = sourceImage.get(xloc,yloc);
      rtotal += (red(col) * matrix[i][j]);
      gtotal += (green(col) * matrix[i][j]);
      btotal += (blue(col) * matrix[i][j]);
    }
  }

  return color(rtotal, gtotal, btotal);
}

PImage edgeDetect(PImage img) {
  PImage outputImage = createImage(img.width,img.height,RGB);
  img.loadPixels();

  for(int y = 0; y < img.height; y++){
    for(int x = 0; x < img.width; x++){
      color c = convolution(x, y, edge_matrix, 3, img);
      outputImage.set(x,y,c);   
    }
  }
  
  return outputImage;
}

PImage blur(PImage img) {
  PImage outputImage = createImage(img.width,img.height,RGB);
  img.loadPixels();

  for(int y = 0; y < img.height; y++){
    for(int x = 0; x < img.width; x++){
      color c = convolution(x, y, blur_matrix, 3, img);
      outputImage.set(x,y,c);   
    }
  }
  
  return outputImage;
}

PImage sharpen(PImage img) {
  PImage outputImage = createImage(img.width,img.height,RGB);
  img.loadPixels();

  for(int y = 0; y < img.height; y++){
    for(int x = 0; x < img.width; x++){
      color c = convolution(x, y, sharpen_matrix, 3, img);
      outputImage.set(x,y,c);   
    }
  }
  
  return outputImage;
}

PImage gaussianBlur(PImage img) {
  PImage outputImage = createImage(img.width,img.height,RGB);
  img.loadPixels();

  for(int y = 0; y < img.height; y++){
    for(int x = 0; x < img.width; x++){
      color c = convolution(x, y, gaussianblur_matrix, 7, img);
      outputImage.set(x,y,c);   
    }
  }
  
  return outputImage;
}
