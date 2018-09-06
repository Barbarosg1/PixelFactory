

import processing.sound.*;


/*************************************************************************************/
/*************************************************************************************/
/**********************ARC SPHERE VARIABLES************************************/
/*************************************************************************************/
// Trig lookup tables borrowed from Toxi; cryptic but effective.
float sinLUT[];
float cosLUT[];
float SINCOS_PRECISION=1.0;
int SINCOS_LENGTH= int((360.0/SINCOS_PRECISION));
 
// System data
boolean dosave=false;
int num;
float pt[][];
int style[];


/*************************************************************************************/
/*************************************************************************************/
/**********************OTHER VARIABLES************************************/
/*************************************************************************************/

SoundFile sfile;
PixelFactory pf; 
PixelFactoryPrj pfPrj; //Self Reference
ParticleSystem ps, ps1, ps2, ps3, ps4, ps5; //Pixel Products
PShape hierl1, hiearl2_1, hierl2_2; //Director and manager Spheres
PImage directtex, managertex, backgroundtex;
int PARTICLE_DENSITY;
Organization pfOrg;
CWindow custPict;
boolean initialized_before = false;
boolean theme_changed =false;


final int IMG_WIDTH = 960, IMG_HEIGHT = 1024;


void settings()
{
  size(IMG_WIDTH, IMG_HEIGHT, P3D);

  //SET ORGANIZATION TYPE
  pfOrg = new Organization();
  pfOrg.orgType = ORG_TYPE_HIERARCHY;
  pfPrj = this;  //Set Self Reference
  
}

void setup() 
  {
  if (initialized_before == false)
    {
      //First time initialization tasks
      noStroke();
      background(0);
      custPict = new CWindow();
      pf = new PixelFactory();

      //Cretae Texture for Director and Manager Spheres and for background
      directtex = CreateTexture(0xff, 0x42, 0x0e, 25);
      directtex.filter(BLUR, 12);
      managertex = CreateTexture(0x37, 0x5e, 0x97, 22);      //0x89, 0xda, 0x59, 25);  //0x37, 0x5e, 0x97, 16);
      managertex.filter(BLUR, 10);
      backgroundtex = CreateTexture(0xe0, 0xe5, 0xe5, 8);

      noStroke();
      fill(255);

      //Cretae Director and Manager Spheres
      hierl1 = createShape(SPHERE, 150);
      hierl1.setTexture(directtex); //directtex);  
      
      hiearl2_1 = createShape(SPHERE, 75);
      hiearl2_1.setTexture(managertex);  
    
      hierl2_2 = createShape(SPHERE, 75);
      hierl2_2.setTexture(managertex);  

      initialized_before = true;
    }
  
  if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
    {
    setupForHieararchy();
    }
  else
    {
    setupForSociocracy();
    }
theme_changed = true;
} 




void draw () {

if (theme_changed == false)
  {
    theme_changed = true;
    println("in main draw" + theme_changed);
    sfile.stop();
    sfile = null;
    if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
              {
              pfOrg.orgType = ORG_TYPE_SOCIOCRACY;
              setupForSociocracy();
              }
          else
            {
            pfOrg.orgType = ORG_TYPE_HIERARCHY;
            setupForHieararchy();
            }
    //return;
    //setup();
  }
  
  color c1;
  background(0x00091c);


//Initiate and display 
    ps.update();
    ps.display();
    ps1.update();
    ps1.display();
    ps2.update();
    ps2.display();
    ps3.update();
    ps3.display();
    ps4.update();
    ps4.display();
    ps5.update();
    ps5.display();

    // Disabling writing to the depth mask so the 
    // background image doesn't occludes any 3D object.
    hint(DISABLE_DEPTH_MASK);
     image(backgroundtex, 0, 0, width, height);
    hint(ENABLE_DEPTH_MASK);

  if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
  {
   fill(255);
    c1 = pf.ask_to_boss();
    ps.setEmitter(220,620,c1 );
    c1= pf.ask_to_boss();
    ps1.setEmitter(80,620, c1);
    c1= pf.ask_to_boss();
    ps2.setEmitter(340,620, c1);
    c1= pf.ask_to_boss();
    ps3.setEmitter(635,620, c1);
    c1= pf.ask_to_boss();
    ps4.setEmitter(765,620, c1);
    c1= pf.ask_to_boss();
    ps5.setEmitter(895,620, c1);
   
  
    pushMatrix();
  
    //translate(width/2, height/5, -600);  
    pushMatrix();
    translate(width/2+(random(0, 15)-7), height/22+(random(0, 15)-7), -600);  
    rotateY(PI * frameCount / 500);
    shape(hierl1);
    popMatrix();
  
    translate(width/2-width/3, height/22+height/4, -600);  
    pushMatrix();
    rotateY(PI * frameCount / 500);
    shape(hiearl2_1);
    popMatrix();
  
    translate(width/3*2, 0, 0);  
    pushMatrix();
    rotateY(PI * frameCount / 500);
    shape(hierl2_2);
    popMatrix();
  

  
    popMatrix();
  
    int index=0;
    translate(60, 600, 0);
   
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(0, index, i, 0, 0);
    }
    
  
    translate(130, 0, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(1, index, i, 0, 0);
    }
  
  
    translate(130, 0, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(2, index, i, 0, 0);
    }
  
    translate(295, 0, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(3, index, i, 0, 0);
    }
  
    translate(130, 0, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(4,index, i, 0, 0);
    }
  
    translate(130, 0, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(5, index, i, 0, 0);
    }
  }
  else 
  {
    fill(255);
    c1 = custPict.tellmeLastColor();
    ps.setEmitter(184,263,c1 );
    c1= custPict.tellmeLastColor();
    ps1.setEmitter(526,132, c1);
    c1= custPict.tellmeLastColor();
    ps2.setEmitter(784,338, c1);
    c1= custPict.tellmeLastColor();
    ps3.setEmitter(754,690, c1);
    c1= custPict.tellmeLastColor();
    ps4.setEmitter(438,838, c1);
    c1= custPict.tellmeLastColor();
    ps5.setEmitter(136,628, c1);
   
  
    int index=0;
    translate(184+10, 263, 0);
  
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(0, index, i, 0, 0);
    }
    
  
  translate(526-184, 132-263, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(1, index, i, 0, 0);
    }
  
  
  translate(784-526, 338-132, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(2, index, i, 0, 0);
    }
  
   translate(754-784, 690-338, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(3, index, i, 0, 0);
    }
  
   translate(438-754, 838-690, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(4,index, i, 0, 0);
    }
  
     translate(136-438+20, 628-838-4, 0);
    index = 0;
    for (int i = 0; i < num; i++) {
      index = drawArcCircle(5, index, i, 0, 0);
    }
  
  }
 
}

void mousePressed() {
  println("mousePressed in primary window");
}  


PImage CreateTexture(int red, int green, int blue, int n_perlin){
PImage tmpImg;

  // The clouds texture will "move" having the values of its u
  // texture coordinates displaced by adding a constant increment
  // in each frame. This requires REPEAT wrapping mode so texture 
  // coordinates can be larger than 1.
  //PTexture.Parameters params2 = PTexture.newParameters();
  //params2.wrapU = REPEAT;
  tmpImg = createImage(512, 256, ARGB);

  // Using 3D Perlin noise to generate a clouds texture that is seamless on
  // its edges so it can be applied on a sphere.
  tmpImg.loadPixels();
  Perlin perlin = new Perlin();
  for (int j = 0; j < tmpImg.height; j++) {
    for (int i = 0; i < tmpImg.width; i++) {
      // The angle values corresponding to each u,v pair:
      float u = float(i) / tmpImg.width;
      float v = float(j) / tmpImg.height;
      float phi = map(u, 0, 1, TWO_PI, 0); 
      float theta = map(v, 0, 1, -HALF_PI, HALF_PI);
      // The x, y, z point corresponding to these angles:
      float x = cos(phi) * cos(theta);
      float y = sin(theta);            
      float z = sin(phi) * cos(theta);      
      float n = perlin.noise3D(x, y, z, 1.2, 2, n_perlin);
      tmpImg.pixels[j * tmpImg.width + i] = color(red, green,  blue, 255 * n * n);
    }
  }  
  tmpImg.updatePixels();
  
return tmpImg;
};


// Get blend of two colors
int colorBlended(float fract,
float r, float g, float b,
float r2, float g2, float b2, float a) {
 
  r2 = (r2 - r);
  g2 = (g2 - g);
  b2 = (b2 - b);
  return color(r + r2 * fract, g + g2 * fract, b + b2 * fract, a);
}
 
int drawArcCircle(int arcgroupno, int index, int i, int x, int y)
{
    pushMatrix();
 
    rotateX(pt[index++][arcgroupno]);
    rotateY(pt[index++][arcgroupno]);
 
    if(style[i*2+1]==0) {
      stroke(style[i*2]);
      noFill();
      strokeWeight(1);
      arcLine(x,y, pt[index++][arcgroupno],pt[index++][arcgroupno],pt[index++][arcgroupno]);
    }
    else if(style[i*2+1]==1) {
      fill(style[i*2]);
      noStroke();
      arcLineBars(x,y, pt[index++][arcgroupno],pt[index++][arcgroupno],pt[index++][arcgroupno]);
    }
    else {
      fill(style[i*2]);
      noStroke();
      arc(x,y, pt[index++][arcgroupno],pt[index++][arcgroupno],pt[index++][arcgroupno]);
    }
 
    // increase rotation
    pt[index-5][arcgroupno]+=pt[index][arcgroupno]/10;
    pt[index-4][arcgroupno]+=pt[index++][arcgroupno]/20;
 
    popMatrix();
    
    return index;
}
 
// Draw arc line
void arcLine(float x,float y,float deg,float rad,float w) {
  int a=(int)(min (deg/SINCOS_PRECISION,SINCOS_LENGTH-1));
  int numlines=(int)(w/2);
 
  for (int j=0; j<numlines; j++) {
    beginShape();
    for (int i=0; i<a; i++) { 
      vertex(cosLUT[i]*rad+x,sinLUT[i]*rad+y);
    }
    endShape();
    rad += 2;
  }
}
 
// Draw arc line with bars
void arcLineBars(float x,float y,float deg,float rad,float w) {
  int a = int((min (deg/SINCOS_PRECISION,SINCOS_LENGTH-1)));
  a /= 4;
 
  beginShape(QUADS);
  for (int i=0; i<a; i+=4) {
    vertex(cosLUT[i]*(rad)+x,sinLUT[i]*(rad)+y);
    vertex(cosLUT[i]*(rad+w)+x,sinLUT[i]*(rad+w)+y);
    vertex(cosLUT[i+2]*(rad+w)+x,sinLUT[i+2]*(rad+w)+y);
    vertex(cosLUT[i+2]*(rad)+x,sinLUT[i+2]*(rad)+y);
  }
  endShape();
}
 
// Draw solid arc
void arc(float x,float y,float deg,float rad,float w) {
  int a = int(min (deg/SINCOS_PRECISION,SINCOS_LENGTH-1));
  beginShape(QUAD_STRIP);
  for (int i = 0; i < a; i++) {
    vertex(cosLUT[i]*(rad)+x,sinLUT[i]*(rad)+y);
    vertex(cosLUT[i]*(rad+w)+x,sinLUT[i]*(rad+w)+y);
  }
  endShape();
}


void setupForHieararchy()
{

  PARTICLE_DENSITY = 60;

  /*************************************************************************************/
  /**********************ARC SPHERE SETTINGS************************************/
  /*************************************************************************************/
  // Fill the tables
  sinLUT=new float[SINCOS_LENGTH];
  cosLUT=new float[SINCOS_LENGTH];
  for (int i = 0; i < SINCOS_LENGTH; i++) {
    sinLUT[i]= (float)Math.sin(i*DEG_TO_RAD*SINCOS_PRECISION);
    cosLUT[i]= (float)Math.cos(i*DEG_TO_RAD*SINCOS_PRECISION);
  }
 
  num = 20;
  pt = new float[6*num][6]; // rotx, roty, deg, rad, w, speed
  style = new int[2*num]; // color, render style
 
  // Set up arc shapes
  int index=0;
  float prob;
  

  //Setup parameters for 6 Arc Spheres
  for (int ii=0; ii< 6; ii++)
  {
    index = 0;
    for (int i=0; i<num; i++) {
      pt[index++][ii] = random(PI*2); // Random X axis rotation
      pt[index++][ii] = random(PI*2); // Random Y axis rotation
   
      pt[index++][ii] = random(60,80); // Short to quarter-circle arcs
      if(random(100)>90) pt[index][ii]=(int)random(8,27)*10;
   
      pt[index++][ii] = int(random(2,12)*3); // Radius. Space them out nicely
   
      pt[index++][ii] = random(4,20); // Width of band
      if(random(100)>90) pt[index][ii]=random(20,35); // Width of band
   
      pt[index++][ii] = radians(random(5,30))/5; // Speed of rotation
   
      // get colors
      prob = random(100);
      if(prob<30) style[i*2]=colorBlended(random(1), 0xf1,0x8d,0x9e, 0xde,0x7a, 0x22, 210);
      else if(prob<70) style[i*2]=colorBlended(random(1), 0x29,0x88,0xbc, 0xd0,0xe1,0xf9, 220);
      else if(prob<90) style[i*2]=colorBlended(random(1), 0xf9,0xba,0x32, 0xa5,0xc0,0x5b, 220);
      else style[i*2]=color(255,255,255, 220);
  
      if(prob<50) style[i*2]=colorBlended(random(1), 0xa5,0xc0,0x5b, 0x22,0x7a,0, 210);
      else if(prob<90) style[i*2]=colorBlended(random(1), 255,100,0, 255,255,0, 210);
      else style[i*2]=color(0xa1,0xd6,0xe2, 220);
  
      style[i*2+1]=(int)(random(100))%3;
      }
  }

  
  // Load a soundfile from the /data folder of the sketch and play it back
  String audioName = "a1.aiff";
  String path;
  path = sketchPath(audioName);
  sfile = new SoundFile(this, path);
  sfile.loop();//.play();

  //Initiate Pixel creators
  fill(255);
  ps = new ParticleSystem(PARTICLE_DENSITY,210,620, color(0xae,0xbd,0x38));
  ps1 = new ParticleSystem(PARTICLE_DENSITY,80,620, color(0x68, 0x82,0x9e));
  ps2 = new ParticleSystem(PARTICLE_DENSITY,340,620, color(0xae, 0xbd,0x38));
  ps3 = new ParticleSystem(PARTICLE_DENSITY,635,620, color(0x68, 0x82,0x9e));
  ps4 = new ParticleSystem(PARTICLE_DENSITY,765,620, color(0xae, 0xbd,0x38));
  ps5 = new ParticleSystem(PARTICLE_DENSITY,895,620, color(0x68, 0x82,0x9e));
}


void setupForSociocracy()
{

  PARTICLE_DENSITY = 160;

  /*************************************************************************************/
  /**********************ARC SPHERE SETTINGS************************************/
  /*************************************************************************************/
  // Fill the tables
  sinLUT=new float[SINCOS_LENGTH];
  cosLUT=new float[SINCOS_LENGTH];
  for (int i = 0; i < SINCOS_LENGTH; i++) {
    sinLUT[i]= (float)Math.sin(i*DEG_TO_RAD*SINCOS_PRECISION);
    cosLUT[i]= (float)Math.cos(i*DEG_TO_RAD*SINCOS_PRECISION);
  }
 
  num = 20;
  pt = new float[6*num][6]; // rotx, roty, deg, rad, w, speed
  style = new int[2*num]; // color, render style
 
  // Set up arc shapes
  int index=0;
  float prob;
  

  //Setup parameters for 6 Arc Spheres
  for (int ii=0; ii< 6; ii++)
  {
    index = 0;
    for (int i=0; i<num; i++) {
      pt[index++][ii] = random(PI*2); // Random X axis rotation
      pt[index++][ii] = random(PI*2); // Random Y axis rotation
   
      pt[index++][ii] = random(60,80); // Short to quarter-circle arcs
      if(random(100)>90) pt[index][ii]=(int)random(8,27)*10;
   
      pt[index++][ii] = int(random(2,12)*5); // Radius. Space them out nicely
   
      pt[index++][ii] = random(14,30); // Width of band
      if(random(100)>90) pt[index][ii]=random(30,45); // Width of band
   
      pt[index++][ii] = radians(random(5,30))/5; // Speed of rotation
   
      // get colors
      prob = random(100);
      if(prob<30) style[i*2]=colorBlended(random(1), 0xf1,0x8d,0x9e, 0xde,0x7a, 0x22, 210);
      else if(prob<70) style[i*2]=colorBlended(random(1), 0x29,0x88,0xbc, 0xd0,0xe1,0xf9, 220);
      else if(prob<90) style[i*2]=colorBlended(random(1), 0xf9,0xba,0x32, 0xa5,0xc0,0x5b, 220);
      else style[i*2]=color(255,255,255, 220);
  
      if(prob<50) style[i*2]=colorBlended(random(1), 0xa5,0xc0,0x5b, 0x22,0x7a,0, 210);
      else if(prob<90) style[i*2]=colorBlended(random(1), 255,100,0, 255,255,0, 210);
      else style[i*2]=color(0xa1,0xd6,0xe2, 220);
  
      style[i*2+1]=(int)(random(100))%3;
      }
  }

  
  
  // Load a soundfile from the /data folder of the sketch and play it back
  String audioName = "a2Tech.aiff";
  String path;
  path = sketchPath(audioName);
  sfile = new SoundFile(this, path);
  sfile.loop();//.play();
  
  //Initiate Pixel creators
  fill(255);
  ps = new ParticleSystem(PARTICLE_DENSITY,210,620, color(0xae,0xbd,0x38));
  ps1 = new ParticleSystem(PARTICLE_DENSITY,80,620, color(0x68, 0x82,0x9e));
  ps2 = new ParticleSystem(PARTICLE_DENSITY,340,620, color(0xae, 0xbd,0x38));
  ps3 = new ParticleSystem(PARTICLE_DENSITY,635,620, color(0x68, 0x82,0x9e));
  ps4 = new ParticleSystem(PARTICLE_DENSITY,765,620, color(0xae, 0xbd,0x38));
  ps5 = new ParticleSystem(PARTICLE_DENSITY,895,620, color(0x68, 0x82,0x9e));
}
