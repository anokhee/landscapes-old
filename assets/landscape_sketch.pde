 int y_axis = 1;
 int i = 0;
 
 float r = random(0, 130);
 float g = random(0, 130);
 float b = random(0, 130);
 
 float rDeltaMax = random(140, 190);
 float rDeltaMin = rDeltaMax - random(350);

  skyColor2 = color(r + rDeltaMax, g + rDeltaMax, b + rDeltaMax/2, 255);
  skyColor1 = color(r + rDeltaMin, g + rDeltaMin, b + rDeltaMin/2, random(0, 255));

 float mountainsWidth = random(.025, .1);
 float mountainsHeight = random(10, 200);
  
 
 // initializes star count to 0
 int starCount = 0;
 

Sun sun = new Sun();
 
 Mountain m0 = new Mountain(0, .7, 0, mountainsHeight, .02, width * mountainsWidth); 
 Mountain m1 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .06, .025, width * mountainsWidth); 
 Mountain m2 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .15, .025, width * mountainsWidth);
 Mountain m3 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .24, .025, width * mountainsWidth); 
 Mountain m4 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .33, .025, width * mountainsWidth); 
 Mountain m5 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .41, .025, width * mountainsWidth);
 Mountain m6 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .47, .025, width * mountainsWidth);
 Mountain m7 = new Mountain(0, .7, 0, mountainsHeight - mountainsHeight * .53, .025, width * mountainsWidth);
 
 Mountain d0 = new Mountain(0, 3, 0, height, .003, width * .02); 
 Mountain d1 = new Mountain(0, 2.25, 0, height, .003, width * .02); 
 Mountain d2 = new Mountain(0, 1.75, 0, height, .003, width * .02);
 
void setup() {
   size(window.innerWidth, window.innerHeight/2);
   background(skyColor2);
   sun.draw();
   skyColor2 = color(r + rDeltaMax, g + rDeltaMax, b + rDeltaMax/5, 205);
   setGradient(0, 0, width, height, skyColor2, skyColor1, y_axis);
}

void draw() {
  noStroke();
     for (i = 0; i < width; i++){
     makeStars(random(300));
     fill(r + 125, g + 125, b + 100, 255);
     m7.draw();
     fill(r + 120, g + 120, b + 100, 255);
     m6.draw();
     fill(r + 100, g + 100, b + 80, 255);
     m5.draw();
     fill(r + 80, g + 80, b + 80, 255);
     m4.draw();
     fill(r + 60, g + 60, b + 60, 255);
     m3.draw();
     fill(r + 40, g + 40, b + 40, 255);
     m2.draw();
     fill(r + 20, g + 20, b + 20, 255);
     m1.draw();
     fill(r, g, b, 255);
     m0.draw();
     
     fill(r - 20, g - 20, b - 20);
     d2.draw();
     fill(r - 40, g - 40, b - 40);
     d1.draw();
     fill(r - 60, g - 60, b - 60);
     d0.draw();
     } 
}

class Mountain {
  float time = random(0, 99);
  float mLength, currentMin, currentMax, newMin, newMax, timeInterval, lengthInterval;
  Mountain(float cMin, float cMax, float nMin, float nMax, float tI, float lI){
    currentMin = cMin; 
    currentMax = cMax;
    newMin = nMin;
    newMax = nMax;
    timeInterval = tI; 
    lengthInterval = lI;
  }
  
  void draw(){
    rectMode(CENTER);
    time += timeInterval;
    mLength += lengthInterval; 
    float noiseValue = noise(time);
    float x = map(noiseValue, currentMin, currentMax, newMin, -height + newMax);
    
     if (mLength < width){
       rect(mLength, height, mountainsWidth * 125, x);
     } 
  }
}

class Star {
  int xPos, yPos;
  Star(int x, int y){
    xPos = x; 
    yPos = y;
  }
  
  void draw(){
    float randSize = random(3);
    fill(255, 255, 255, random(100, 255));
    rect(xPos, yPos, randSize, randSize);
  }
}

class Sun {
  float xPos, yPos, numPoints, radius, angle, offset;
  float randSize;
  int j; 
  
  Sun(){
    
    numPoints = 50;
    angle=TWO_PI/(float)numPoints;
    xPos = random(50, width * 8);
    yPos = random(height/2, height/2 + 100);
    radius = yPos/1.75; 
    offset = random(-radius * 4, radius * 4);
  }
  
  void draw(){
    noStroke();
    rectMode(CENTER);
    fill(250, 250, 250);
     for (j = 0; j < numPoints; j++){
       rect(xPos, yPos + radius * cos (angle * j), 2.15 * radius * sin (angle * j), radius/5);
     }
     fill(skyColor2);
     ellipse(xPos + offset, yPos, radius * 2, radius * 2);
     translate(0,0);
  }
  
}

void makeStars(int numStars){      
      if (starCount < numStars){
        Star s = new Star(int(random(width)), int(random(height/2)));
        s.draw();
      }
      starCount++;    
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
  noFill();
  if (axis == y_axis) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(skyColor1, skyColor2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
}
