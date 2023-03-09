//Class created by L. Chow 
//Planet objects for homescreen
public class Planet
{
  private float radius, angle, distance, orbitSpeed;
  private PVector vector;
  private PShape globe;
  private Planet[] planets;
  private PImage textures[];

  Planet(float r, float d, float o, PImage img)
  {
    this.vector = PVector.random3D();
    this.radius = r;
    this.distance = d;
    vector.mult(distance);
    this.angle = random(TWO_PI);
    this.orbitSpeed = o;
    noFill();
    noStroke();
    this.globe = createShape(SPHERE, radius);
    globe.setTexture(img);
    setTextures();
  }

  // function to add multiple plants to circle around the sun
  public void addPlanets(int total)
  {
    planets = new Planet[total];
    for (int i = 0; i < planets.length; i++)
    {
      planets[i]= new Planet (radius*0.5, random(radius*2,radius*3), random(-0.05, 0.05), textures[i]);
    }
  }

  // function to make planets move around the sun
  public void orbit() 
  {
    pushMatrix();
    angle = angle + orbitSpeed;
    if (planets !=null)
      for (int i = 0; i < planets.length; i++)
      {
        planets[i].orbit();
      }
    popMatrix();
  }

  // function to draw planets
  public void drawPlanet()
  {
    pushMatrix();
    noStroke();
    lights();
    fill(255);
    PVector spin = vector.cross(new PVector(1,0,1));
    rotate(angle, spin.x,spin.y,spin.z);
    translate(vector.x,vector.y,vector.z);
    shape(this.globe);
    if (planets !=null)
      for (int i = 0; i < planets.length; i++)
      {
        planets[i].drawPlanet();
      }
    popMatrix();
  }

  // function to set textures for planets
  private void setTextures()
  {
    this.textures = new PImage[8];
    this.textures[0] = mercuryIm;
    this.textures[1] = jupiterIm;
    this.textures[2] = earthIm;
    this.textures[3] = marsIm;
    this.textures[4] = neptuneIm;
    this.textures[5] = saturnIm;
    this.textures[6] = uranusIm;
    this.textures[7] = venusIm;
  }
}
