//Class created by L Chow
//Star objects for background of homescreen
public class Star 
{
  private float x, y, z;

  Star()
  {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
  }

  //function to move stars
  public void update() {
    z = z - 5;
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
    }
  }

  //function to draw stars in random places on the screen
  public void drawStars() {
    fill(255);
    noStroke();
    ellipse(map(x/z, 0, 1, 0, width), map(y/z, 0, 1, 0, height),  map (z, 0, width, 16, 0),  map (z, 0, width, 16, 0));
  }
}
