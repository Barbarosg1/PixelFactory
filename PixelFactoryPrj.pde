import processing.sound.*;

PixelFactory pf; 
PImage directtex, managertex, backgroundtex;
int PARTICLE_DENSITY;
Organization pfOrg;
CWindow custPict;
boolean initialized_before = false;
boolean theme_changed =false;
boolean mainLocationSet=false;
SoundFile sfile;


final int IMG_WIDTH = 960, IMG_HEIGHT = 1024;


void settings()
{
  size(IMG_WIDTH, IMG_HEIGHT, P3D);

  //SET ORGANIZATION TYPE
  pfOrg = new Organization();
  pfOrg.orgType = ORG_TYPE_HIERARCHY;
  
}

void setup() 
  {
  if (initialized_before == false)
    {
      //First time initialization tasks
      //surface.setTitle("Pixel Factory"); 
      //surface.setResizable(false); 

      noStroke();
      background(0);
      //Cretae Texture for Director and Manager Spheres and for background
      directtex = CreateTexture(0xff, 0x42, 0x0e, 25);
      directtex.filter(BLUR, 12);
      managertex = CreateTexture(0x37, 0x5e, 0x97, 22);      //0x89, 0xda, 0x59, 25);  //0x37, 0x5e, 0x97, 16);
      managertex.filter(BLUR, 10);
      backgroundtex = CreateTexture(0xe0, 0xe5, 0xe5, 8);

      
      pf = new PixelFactory(this);
      custPict = new CWindow(this);


      initialized_before = true;
    }
  
  if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
    {
    pf.setupForHieararchy();
    // Load a soundfile and play it back
    String audioName = "a1.aiff";
    String path;
    path = sketchPath(audioName);
    sfile = new SoundFile(this, path);
    sfile.loop();//.play();
  
    }
  else
    {
    pf.setupForSociocracy();
    // Load a soundfile and play it back
    String audioName = "a2Tech.aiff";
    String path;
    path = sketchPath(audioName);
    sfile = new SoundFile(this, path);
    sfile.loop();//.play();

    }
theme_changed = true;
} 


void draw () {
  if (!mainLocationSet){
      surface.setLocation(100, 100);
      mainLocationSet = true;
      println("Main location is set");
    }

  if (theme_changed == false)
    {
      theme_changed = true;
      sfile.stop();
      sfile = null;
      if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
        {
          pfOrg.orgType = ORG_TYPE_SOCIOCRACY;
          pf.setupForSociocracy();
      
          // Load a soundfile and play it back
          String audioName = "a2Tech.aiff";
          String path;
          path = sketchPath(audioName);
          sfile = new SoundFile(this, path);
          sfile.loop();//.play();              
        }
      else
        {
          pfOrg.orgType = ORG_TYPE_HIERARCHY;
          pf.setupForHieararchy();

          // Load a soundfile and play it back
          String audioName = "a1.aiff";
          String path;
          path = sketchPath(audioName);
          sfile = new SoundFile(this, path);
          sfile.loop();//.play();
        }
    }
    
  background(0x00091c);
  
  // Disabling writing to the depth mask so the 
  // background image doesn't occludes any 3D object.
  hint(DISABLE_DEPTH_MASK);
   image(backgroundtex, 0, 0, width, height);
  hint(ENABLE_DEPTH_MASK);

  pf.draw();
 
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
