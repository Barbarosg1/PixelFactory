
  
//color[][] TColorPixels = new color[IMG_WIDTH][IMG_HEIGHT]; 
boolean[][] TouchedPixels = new boolean[IMG_WIDTH][IMG_HEIGHT];
int everyTenThousand = 0;
boolean completed =false;
//static public color lastcolor;
PixelFactory pfcust;

class CWindow extends PApplet {
  PImage CustImgOj;
  public color lastcolor;
  
  CWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(IMG_WIDTH, IMG_HEIGHT, P3D);
  }

  void setup() {
    background(0);
    completed=false;
    pfcust = new PixelFactory();

    CustImgOj = loadImage("C:\\barbaros\\FutureTellersPrj\\PixelFactoryPrj\\data\\coaa_960_1024.png"); 

    // Clear Touched matrix
    for (int i = 0; i < CustImgOj.width; i++) {
      for (int j = 0; j < CustImgOj.height; j++) {
        //TColorPixels[i][j] = CustImgOj.get(i, j);
        TouchedPixels[i][j] = false;
        
      }
    }


 }

  public color tellmeLastColor()
  {
    return  this.lastcolor;
  }
  
  colorOfPos giveMeColor()
  {
      colorOfPos cop = new colorOfPos();

      
      if(pfOrg.orgType ==ORG_TYPE_HIERARCHY)
          pfcust.ask_to_boss();
      cop.x = int(random(0,IMG_WIDTH));
      cop.y = int(random(0,IMG_HEIGHT));
      
      cop.c = CustImgOj.get(cop.x, cop.y); //TColorPixels[cop.x][cop.y];
      this.lastcolor = cop.c;
      return cop;
  }
  
  void draw() {
      colorOfPos cop = new colorOfPos();
      int imax = 100;
      loadPixels();
      for (int i=0;i<imax;i++)
        {
        int maxtry = 1000;
        do{  
          cop = giveMeColor();
          if (--maxtry<1)
            break;
          }while (TouchedPixels[cop.x][cop.y] == true);
        int loc = cop.x + cop.y*CustImgOj.width;
        pixels[loc] = cop.c;
        TouchedPixels[cop.x][cop.y] = true;
        if (++everyTenThousand>10000) 
          {
            everyTenThousand = 0;
            completed = true;
             for (int x = 0; x < CustImgOj.width; x++) {
                for (int y = 0; y < CustImgOj.height; y++) {
                  if (TouchedPixels[x][y] == false)
                    {
                    completed = false;
                    break;
                    }
                }
             }
          }            
        }
      updatePixels();

      if (completed)
          {
          theme_changed = false;
          /*pfPrj.redraw();
          sfile.stop();
          pfPrj.setup();*/
          setup();
          println("After one turn" + theme_changed);
          /*if (pfOrg.orgType == ORG_TYPE_HIERARCHY)
              pfOrg.orgType = ORG_TYPE_SOCIOCRACY;
          else
            pfOrg.orgType = ORG_TYPE_HIERARCHY;
*/
          }
}

  void mousePressed() {
    println("mousePressed in secondary window");
  }
  
  
}

class  colorOfPos {
public color c;
public int x;
public int y;
}
