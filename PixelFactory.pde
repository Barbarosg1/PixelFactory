class PixelFactory{

  /**********************ARC SPHERE VARIABLES*******************************************/
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
  /**********************/


  Employees[] pfEmployees = new Employees[6];
  PixelFactoryPrj pfPrjRoot;
  PShape hierl1, hiearl2_1, hierl2_2; //Director and manager Spheres
  
  ParticleSystem ps, ps1, ps2, ps3, ps4, ps5; //Pixel Products
  PixelFactory(PixelFactoryPrj pfPrj)
  {
      //Create Director and Manager Spheres
      hierl1 = createShape(SPHERE, 150);
      hierl1.setTexture(directtex); //directtex);  
      
      hiearl2_1 = createShape(SPHERE, 75);
      hiearl2_1.setTexture(managertex);  
    
      hierl2_2 = createShape(SPHERE, 75);
      hierl2_2.setTexture(managertex);  

      for(int i=0; i<6; i++ )
      {
          pfEmployees[i] = new Employees(pfPrj, this);
      }
  }

  public color ask_to_boss()
  {
    delay(1);
    //Boss asks to Customer
    return custPict.tellmeLastColor();
  }
  
  void draw()
  {
    for(int i=0; i<6; i++ )
    {
    //Initiate and display 
    pfEmployees[i].draw();  
    }
    
    if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
    {
      fill(255);
      pfEmployees[0].setEmitter(220,620);
      pfEmployees[1].setEmitter(80,620);
      pfEmployees[2].setEmitter(340,620);
      pfEmployees[3].setEmitter(635,620);
      pfEmployees[4].setEmitter(765,620);
      pfEmployees[5].setEmitter(895,620);
      
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
      pfEmployees[0].setEmitter(480,146);
      pfEmployees[1].setEmitter(790,330);
      pfEmployees[2].setEmitter(790,692);
      pfEmployees[3].setEmitter(480,870);
      pfEmployees[4].setEmitter(168,692);
      pfEmployees[5].setEmitter(168,330);

      int index=0;
      translate(480, 146, 0);
      for (int i = 0; i < num; i++) {
        index = drawArcCircle(0, index, i, 0, 0);
        }
    
  
      translate(790-480, 330-146, 0);
        index = 0;
        for (int i = 0; i < num; i++) {
          index = drawArcCircle(1, index, i, 0, 0);
        }
      
      
      translate(0, 692-330, 0);
        index = 0;
        for (int i = 0; i < num; i++) {
          index = drawArcCircle(2, index, i, 0, 0);
        }
      
       translate(480-790, 870-692, 0);
        index = 0;
        for (int i = 0; i < num; i++) {
          index = drawArcCircle(3, index, i, 0, 0);
        }
      
       translate(168-480, 692-870, 0);
        index = 0;
        for (int i = 0; i < num; i++) {
          index = drawArcCircle(4,index, i, 0, 0);
        }
  
       translate(0, 330-692, 0);
        index = 0;
        for (int i = 0; i < num; i++) {
        index = drawArcCircle(5, index, i, 0, 0);
        }

    }
    

  
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

  

  //Initiate Pixel creators
  fill(255);
  pfEmployees[0].setup(PARTICLE_DENSITY,210,620, color(0xae,0xbd,0x38));
  pfEmployees[1].setup(PARTICLE_DENSITY,80,620, color(0x68, 0x82,0x9e));
  pfEmployees[2].setup(PARTICLE_DENSITY,340,620, color(0xae, 0xbd,0x38));
  pfEmployees[3].setup(PARTICLE_DENSITY,635,620, color(0x68, 0x82,0x9e));
  pfEmployees[4].setup(PARTICLE_DENSITY,765,620, color(0xae, 0xbd,0x38));
  pfEmployees[5].setup(PARTICLE_DENSITY,895,620, color(0x68, 0x82,0x9e));
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

  //Initiate Pixel creators
  fill(255);

  pfEmployees[0].setup(PARTICLE_DENSITY,480,146, color(0xae,0xbd,0x38));
  pfEmployees[1].setup(PARTICLE_DENSITY,790,330, color(0x68, 0x82,0x9e));
  pfEmployees[2].setup(PARTICLE_DENSITY,790,692, color(0xae, 0xbd,0x38));
  pfEmployees[3].setup(PARTICLE_DENSITY,480,870, color(0x68, 0x82,0x9e));
  pfEmployees[4].setup(PARTICLE_DENSITY,168,692, color(0xae, 0xbd,0x38));
  pfEmployees[5].setup(PARTICLE_DENSITY,168,330, color(0x68, 0x82,0x9e));
}

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


}
