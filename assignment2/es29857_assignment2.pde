/** Assignment 2: Image Manipulation */

PImage img;
PImage img2;

void setup() {
  
  //functionality for loading image
  //flexible to load images of multiple size, but window should map to size of any given image
  surface.setResizable(true); 
  img = loadImage("sunflower.jpg");
  surface.setSize(img.width, img.height);
  
  img2 = createImage(img.width, img.height, ARGB);
  img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
}

void draw() {
  image(img2, 0, 0);

  //GRAYSCALE - user presses 1
    //average across all color channels on per-pixel basis and assign that value 
    //across all three color channels
  if ((keyPressed == true) && (key == '1')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    img2.loadPixels();
    //loop through every pixel column
    for (int x = 0; x < width; x++) {
      //loop through every pixel row
      for (int y = 0; y < height; y++) {
        //use formula to find 1D location
        int loc = x + y * width;
      
        //the functions red(), green() and blue() pull out the 3 color components from a pixel
        float r = red(img2.pixels[loc]);
        float g = green(img2.pixels[loc]);
        float b = blue(img2.pixels[loc]);
      
        //average across all color channels
        //change float to (int)
        int gray = (int)(r+g+b)/3;
      
        //set pixel to new grayscale color
        img2.pixels[loc] = color(gray);
      }
    }
    img2.updatePixels();
  }
  

  //CONTRAST - user presses 2
    //calculate brigtness (value) of each pixel
    //Experiment to find good threshold value (or multiple values)
    //choose brightness to be added/subtracted based on result of experiement
  int threshold = 80;

  if ((keyPressed == true) && (key == '2')) {
    colorMode(HSB);
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    
    img2.loadPixels();
    //loop through every pixel column
    for (int x = 0; x < width; x++) {
      //loop through every pixel row
      for (int y = 0; y < height; y++) {
        //use formula to find 1D location
        int loc = x + y * width;
      
        //the functions red(), green() and blue() pull out the 3 color components from a pixel
        float h = hue(img2.pixels[loc]);
        float s = saturation(img2.pixels[loc]);
        float b = brightness(img2.pixels[loc]);
      
        if (b > threshold) { //if pixel's brigthness above threshold value, additional brightness added
          b += 20;
        }
        else if (b < threshold) { //below threshold, subtract brightness
          b -= 20;
        }
        h = constrain(h, 0, 100);
        s = constrain(s, 0, 100);
        b = constrain(b, 0, 100);
        
        //set pixel to new grayscale color
        img2.pixels[loc] = color(h, s, b);
      }
    }
    img2.updatePixels();
    colorMode(RGB);
  }
  
  //NO FILTER - press 0
    //image returns to original form
    //create additional PIamge buffer to hold original image in memory
    //then swap into place of the displaying image (which has filters applied) 
    //when user requests original display
  if ((keyPressed == true) && (key == '0')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
  }


  //KERNEL/CONVOLUTION MATRIX
    //apply to all pixels when filters requriing neighborhood info are called
    //handle edge pixels; black border no allowed (solutions in slides)
    //account for possibility of matrix outputting negative values
    
  //GAUSSIAN BLUR - user presses 3
  //Rely on kernel/convolution matrix to extract and manipulate pixels
  //buffer updated image to prevent changse to image from influencing neighbors
  //parameters of 0.25, 0.125, and 0.0625
  if ((keyPressed == true) && (key == '3')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    PImage buffer = loadImage("sunflower.jpg");
    //image(img2, 0, 0);
    
    buffer.loadPixels();
    img2.loadPixels();
    
    //try matrix size = {3, 11, 21}
    //try sigma = {1, 10, 100}
    float[][] matrix = {
    {0.0625, 0.125, 0.0625}, {0.125, 0.25, 0.125}, {0.0625, 0.125, 0.0625}
    };

    //loop through every pixel column
    for (int x = 1; x < width - 1; x++) {
      //loop through every pixel row
      for (int y = 1; y < height - 1; y++) {
        float red = 0.0;
        float green = 0.0;
        float blue = 0.0;
        if ((x > 0) && (y > 0) && (x < img2.width - 1) && (y < img2.height - 1)) {
          //Code to access individual pixel location (x, y)
          for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              int index = (x + i - 1) + img2.width*(y + j - 1);
              
              //Perform convolution on red, green and blue color channels
              red += red(img2.pixels[index]) * matrix[i][j];
              green += green(img2.pixels[index]) * matrix[i][j];
              blue += blue(img2.pixels[index]) * matrix[i][j];
            }
          }
        }
        //Clamp red, green and blue values
        red = constrain(abs(red), 0, 255);
        green = constrain(abs(green), 0, 255);
        blue = constrain(abs(blue), 0, 255);
          
        //use formula to find 1D location
        int loc = x + y * width;
        buffer.pixels[loc] = color(red, green, blue);
      }
    }
    buffer.updatePixels();
    img2.copy(buffer, 0, 0, buffer.width, buffer.height, 0, 0, img2.width, img2.height);
    
    image(buffer, 0, 0);
  }

  //Possible gaussian approximation -- use weight of 0.25 on current pixel
  //0.125 on cardinal neighboring pixels (NE, NW, SE, SW)
  //As long as it resembles gaussian drop off (most weight on current pixel, total
  //weight equals 1, and cardinal neighbors weighed more heavily than 'distant' diagonal neighbors
  
  //EDGE DETECTION - press 4
  //Use sobel operators when 4 pressed
  //require neighborhood knowledge of pixels, and use kernle
  //need to buffer updated image 
  //2 sobel operators: horizontal and vertical
  //combine operators by determining each pixel's updated value in both vertical and horizontal directions
  //Then take mangitude and assign value to final pixel output
  //take magnitude by taking square root of added squared convolution values
  if ((keyPressed == true) && (key == '4')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    PImage buffer = loadImage("sunflower.jpg");
    //image(img2, 0, 0);
    
    buffer.loadPixels();
    img2.loadPixels();

    float[][] matrixH = {
    {-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}
    };
    
    float[][] matrixV = {
    {-1, -2, -1}, {0, 0, 0}, {1, 2, 1}
    };

    //loop through every pixel column
    for (int x = 1; x < width - 1; x++) {
      //loop through every pixel row
      for (int y = 1; y < height - 1; y++) {
        float redV = 0.0;
        float greenV = 0.0;
        float blueV = 0.0;
        
        float redH = 0.0;
        float greenH = 0.0;
        float blueH = 0.0; 
        
        if ((x > 0) && (y > 0) && (x < img2.width - 1) && (y < img2.height - 1)) {
          //Code to access individual pixel location (x, y)
          for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              int index = (x + i - 1) + img2.width*(y + j - 1);
              
              //Perform convolution on red, green and blue color channels
              redV += red(img2.pixels[index]) * matrixV[i][j];
              greenV += green(img2.pixels[index]) * matrixV[i][j];
              blueV += blue(img2.pixels[index]) * matrixV[i][j];

              //Perform convolution on red, green and blue color channels
              redH += red(img2.pixels[index]) * matrixH[i][j];
              greenH += green(img2.pixels[index]) * matrixH[i][j];
              blueH += blue(img2.pixels[index]) * matrixH[i][j];
            }
          }
        }
        
        //Clamp red, green and blue values
        redV = constrain(abs(redV), 0, 255);
        greenV = constrain(abs(greenV), 0, 255);
        blueV = constrain(abs(blueV), 0, 255);
 
        redH = constrain(abs(redH), 0, 255);
        greenH = constrain(abs(greenH), 0, 255);
        blueH = constrain(abs(blueH), 0, 255); 
        
        //Gradient magnitude calculations
        float redNew = sqrt(pow(redV, 2) + pow(redH, 2));
        float greenNew = sqrt(pow(greenV, 2) + pow(greenH, 2));
        float blueNew = sqrt(pow(blueV, 2) + pow(blueH, 2));
          
        //use formula to find 1D location
        int loc = x + y * width;
        buffer.pixels[loc] = color(redNew, greenNew, blueNew);
      }
    }
    buffer.updatePixels();
    img2.copy(buffer, 0, 0, buffer.width, buffer.height, 0, 0, img2.width, img2.height);
    
    image(buffer, 0, 0);
  }
}
 