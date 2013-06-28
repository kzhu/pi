import processing.opengl.*;

// Pi digits
String[] lines;

float ang = 0, ang2 = 0, ang3 = 0, ang4 = 0;
float px = 0, py = 0, pz = 0;
int renderCounter = 0;

//Define Sphere item size & Coordinates

float itemSize;
float radius = 100;
float theta = 0;
float phi = 0;

float thetaSpeed = PI/10;
float phiSpeed = PI/10;
int phiCounter;

Balls ba;

ArrayList items;

void setup() 
{
  size(600,600,OPENGL);
  frameRate(50);
  noStroke();
  
  //load pi digits from file
  String lines[] = loadStrings("pinumbers.txt");
  ballArray = new ArrayList();
  
  for (int i = 0; i < 400; i++)
  {   
   
   // Increment phi once 20 balls have been placed 
   if (phiCounter == 20)
   {
    phi += phiSpeed;
    phiCounter = 0;
   }
   // increment theta angle
    theta += thetaSpeed;
    phiCounter++; // counter for number of balls placed
   
   // add balls items array
    ballArray.add(new Balls(radius,theta,phi,lines[i]));
    
  }
}

void draw()
{
  // redraw background
   background(255);

  // define rotation increments
   px = sin(radians(ang3)) * 170;
   py = cos(radians(ang3)) * 300;
   pz = sin(radians(ang4)) * 500;
   translate(width/2 + px, height/2 + py, -700+pz);

   rotateX(sin(radians(ang2)) * 120);
   rotateY(sin(radians(ang2)) * 50);
   rotateZ(sin(radians(ang2)) * 65);
  
  // increment angle
  ang3 += 2.0;
   
   camera (px, py, pz, 250, 250, 250, 0, 1, 0);

   
   translate(height/2, width/2, height/2);
  
  for (int i = 0; i < 400; i++)
  {
    Balls ba = (Balls) ballArray.get(i); // Pull ball from arraylist
    ba.render(); // draw ball
  }
  
}

// Define the balls class

class Balls
{

  float radius ;
  float theta ;
  float phi ;
  float itemSize ;

  Balls(float r, float t, float p, float i)
  {
    radius = r;
    theta = t;
    phi = p;
    itemSize = i;
  }
  
  // Rendering the balls
  
  public void render()
  {
    //convert radial coords to cartesian
    float x = cos(theta) * sin(phi) * radius;
    float y = sin(theta) * sin(phi) * radius;
    float z = cos(phi) * radius;
    
     //Mark our 3d space
     pushMatrix();
     //Move to the position of this item
     translate(x,y,z);
     //Set the fill colour
     fill(0, 165, 153);
     noStroke();
     //Draw a circle
     ellipse(0,0,itemSize,itemSize);
     //Go back to our position in 3d space
     popMatrix();  
 }

}

