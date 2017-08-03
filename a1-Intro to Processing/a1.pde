/** Assignment 1: Introduction to Processing */

void setup() {
  size(800, 800);
}

void draw() {
  //these are RGB colors
  background(#abd1d6);

  //drawing table
  fill(#0082c6);
  noStroke();
  rect(0, 600, 800, 200);

  //drawing table shadow
  fill(#0064b0);
  noStroke();
  rect(0, 725, 800, 100); //rect(x, y, width, height) 

  //drawing computer
  //Monitor
  fill(#414549);
  noStroke();
  rect(250, 375, 300, 200, 20);

  //Screen
  fill(#d65d46);
  noStroke();
  rect(275, 400, 250, 150);
  
  //Nav Bar
  fill(#dfd3d0);
  noStroke();
  rect(285, 410, 150, 80, 5);

  //Page
  fill(#46ab6c);
  noStroke();
  rect(285, 420, 150, 100);
  
  //Page words
  textSize(20);
  fill(#ffffff);
  text("CS 324E ", 315, 450); 
  
  //Folder1
  fill(#abd1d6);
  noStroke();
  rect(480, 420, 30, 22); 
  
  //Folder2
  fill(#abd1d6);
  noStroke();
  rect(480, 455, 30, 22); 
   
  //drawing ears
  //Ear1
  fill(#f7c1b2);
  noStroke();
  ellipse(325, 600, 40, 40);
  //Ear2
  fill(#f7c1b2);
  noStroke();
  ellipse(475, 600, 40, 40); 

  //drawing hair
  stroke(#3e231e);
  strokeWeight(1);
  fill(#502f29);
  rect(325, 500, 150, 500, 100);

  //drawing chair
  fill(#363a3e);
  noStroke();
  rect(275, 650, 250, 150, 30);
  
  //drawing mouse
  stroke(#e8e5e4); //this is a stroke color
  strokeWeight(4);
  fill(#f3f0ef);
  rect(550, 650, 35, 55, 9);
   
  //drawing picture frame
  stroke(#48585f); //this is a stroke color
  strokeWeight(10);
  fill(#dee1e0);
  rect(144, 95, 160, 210);

  //drawing picture of overlapping, transparent mountains
  //Mountain 1 
  //blendMode(MULTIPLY);
  fill(#1ca699, 100); //2nd # makes shape transparent 
  noStroke();
  triangle(200, 200, 245, 300, 150, 300);

  //Mountain 2  
  fill(#1d9466, 100);
  noStroke();
  triangle(250, 200, 300, 300, 200, 300);
  
  //drawing cup
  fill(#4d3e85);
  noStroke();
  quad(140, 575, 200, 575, 190, 650, 150, 650);
  
  //drawing handles
  //translate(width/4, height/4);
  //shearX(PI/4.0);
  stroke(#4d3e85);
  strokeWeight(10);
  noFill();
  rect(130, 590, 20, 45, 20);
  
  //drawing sticky notes
  fill(#ca728b);
  noStroke();
  rect(425, 220, 50, 50);

  fill(#e4d325);
  noStroke();
  rect(500, 170, 50, 50);  

  fill(#e4d325);
  noStroke();
  rect(500, 240, 50, 50);
  
  fill(#ca728b);
  noStroke();
  rect(575, 220, 50, 50);


  
}