//Class created by L. Chow
//Screen to choose which graph to enquire
public class GraphScreen extends Screen 
{
    private Planet sun;
    private Star[] stars;
    private String title;
    private float fHeaderHeight;

    public GraphScreen()
    {
        super();
        this.screenColour = color(0);
        this.fHeaderHeight = .05;
        //add widgets to go to the different screen
        this.title = "Please choose a visualization of the data";
        screenWidgets.add(new ButtonWidget(2/12.0,.8,2.0/12.0,1.0/12.0,"Pie Chart",COUNTRY_SCREEN));
        screenWidgets.add(new ButtonWidget(5/12.0,.8,2.0/12.0,1.0/12.0,"Bar Chart",ALTITUDE_SCREEN));
        screenWidgets.add(new ButtonWidget(8/12.0,.8,2.0/12.0,1.0/12.0,"Dot Plot",TIME_SCREEN));
        screenWidgets.add(new ButtonWidget(.01,.01,(fHeaderHeight-.01)*2, fHeaderHeight-.02,"Return",HOME_SCREEN)); 
        //create sun object
        sun = new Planet (90, 0, 0, sunIm);
        //create and make stars
        stars = new Star[500];
        for (int i =0; i<stars.length; i++)
        {
            stars[i] = new Star();
        }
        //create planets
        sun.addPlanets(8); 
    }

    public void draw()
    {
        pushStyle();
        background(this.screenColour);
        super.draw();
        //draw stars
        pushMatrix();
        translate(width/2,height/3);
        for (int i =0; i<stars.length; i++)
        {
            stars[i].update();
            stars[i].drawStars();
        }
        popMatrix();
        //draw planets
        pushMatrix();
        translate(width/2,height/3);
        sun.drawPlanet();
        sun.orbit();
        popMatrix();
        fill(255);
        textAlign(CENTER,BOTTOM);
        textSize(getTextSize(width*.33,height*.1,this.title.length()));
        text(this.title, width*.5, height*.75);
    }

    //function to go to the graphs
    public int getEvent(MouseEvent e)
   {
       int event;
       for(Widget w: screenWidgets)
       {
           event = w.getEvent(e);
           switch(event)
           {
               case ALTITUDE_SCREEN:
                return event;
               case TIME_SCREEN:
                return event;
               case COUNTRY_SCREEN:
                return event;
               case HOME_SCREEN:
                return event;
           }
       }
       return NULL_EVENT;
   }
   void resize()
   {
       super.resize();
   }
}