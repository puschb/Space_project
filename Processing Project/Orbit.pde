//Class created by B. Pusch
//sets up orbits used in the globe screen
public class Orbit
{
    public static final float radiusOfEarth = 6378;
    private static final int strokeWeight = 1;
    private static final int selectedStrokeWeight = 4;
    boolean selected;
    String satcatID;
    PShape orbit;
    float eccentricity, adjusted_apogee, adjusted_perigee, a,b,c, xShift, yShift, inclination, currentEarthRadius, raan;

    public Orbit(String id, float ecc, float apogee, float perigee, float inclination, float raan, float xShift, float yShift, float currentEarthRadius)
    {
        this.satcatID = id; this.eccentricity = ecc; this.xShift = xShift;this.yShift=yShift;this.inclination=inclination;
        this.currentEarthRadius = currentEarthRadius; this.raan = raan;
        this.adjusted_apogee = (apogee+radiusOfEarth)/radiusOfEarth*this.currentEarthRadius;
        this.adjusted_perigee = (perigee+radiusOfEarth)/radiusOfEarth*this.currentEarthRadius;
        this.a = (adjusted_apogee+adjusted_perigee)/2;
        this.c = eccentricity*this.a;
        this.b = (float)Math.sqrt(a*a-c*c);
        this.selected = false;
        createOrbit();
    }

    public void draw()
    {
        pushStyle();
        pushMatrix();
        translate(this.xShift,this.yShift,0);
        if(selected) 
        {
            this.orbit.setStroke(color(200,0,0));
            this.orbit.setStrokeWeight(selectedStrokeWeight);
        }
        else
        {
            this.orbit.setStroke(color(100,100,100));
            this.orbit.setStrokeWeight(strokeWeight);
        }
        rotateY(TWO_PI/360*this.raan);
        rotateX(PI/2 + TWO_PI / 360 * this.inclination);
        translate(-this.c,0,0);    
        shape(this.orbit);
        popStyle();
        popMatrix(); 
    }

    public float getApogee()
    {
        return adjusted_apogee;
    }

    public String getID()
    {
        return this.satcatID;
    }

    void createOrbit()
    {
        this.orbit = createShape();
        this.orbit.beginShape();
        this.orbit.noFill();
        this.orbit.strokeWeight(strokeWeight);
        for(int i = 0;i<=62;i++)
        {
            this.orbit.curveVertex(this.a*cos(TWO_PI/60*i),this.b*sin(TWO_PI/60*i),0);
        }
        this.orbit.endShape();
        this.orbit.setStroke(true);
    }

    public void setSelected(boolean s)
    {
        this.selected = s;
    }

    public void resize(float xShift, float yShift)
    {   
        this.xShift = xShift; this.yShift = yShift;
    }

    public int compareTo(Object obj)
    {
        if(obj instanceof Orbit)
        {
            Orbit orbit = (Orbit)obj;
            return Integer.compare(Integer.parseInt(this.satcatID),Integer.parseInt(orbit.getID()));
        }
        return -1;
    }

    public boolean equals(Object obj)
    {
        if(obj instanceof Orbit)
        {
            Orbit orbit = (Orbit) obj;
            return this.satcatID.equals(orbit.getID());
        }
        return false; 
    }
}