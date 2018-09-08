class Employees
{
PixelFactoryPrj pfPrjRoot;
PixelFactory pfRoot;
ParticleSystem ps;

  Employees(PixelFactoryPrj pfPrj, PixelFactory pf)
  {
   pfPrjRoot = pfPrj;   
  }
  

  void setup(int particle_density, int x, int y, color colPart)
  {
      ps = new ParticleSystem(particle_density,x,y, colPart);
  }
  
  void draw()
  {
   ps.update();
   ps.display();
  }

  void setEmitter(int x, int y)
  {
    color c1;
    if (pfPrjRoot.pfOrg.orgType == ORG_TYPE_HIERARCHY)
    {
       c1 = pf.ask_to_boss();
       ps.setEmitter(x,y,c1);
    }
    else
    {
        c1 = pfPrjRoot.custPict.tellmeLastColor();
        ps.setEmitter(x,y,c1);
        
    }
  }
}
