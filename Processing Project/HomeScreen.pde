//Created created by L. Chow
//Class for the homescreen object
public class HomeScreen extends Screen
{
    private Planet sun;
    private String title, choose;
    private Star[] stars;

    static final int toggleAudioEvent = 11;
    static final int exitEvent = 12;

    public HomeScreen()
    {
        super();
        this.screenColour = color(0);
        //add widgets to go to the different screen
        screenWidgets.add(new ButtonWidget(5/12.0,.8,2.0/12.0,1.0/12.0,"Graph",GRAPH_SCREEN));
        screenWidgets.add(new ButtonWidget(8/12.0,.8,2.0/12.0,1.0/12.0,"Globe",GLOBE_SCREEN));
        screenWidgets.add(new ButtonWidget(2/12.0,.8,2.0/12.0,1.0/12.0, "AI",AI_SCREEN));
        screenWidgets.add(new ButtonWidget(.01,.01,0.08, 0.03,"Mute Audio",toggleAudioEvent));
        screenWidgets.add(new ButtonWidget(.91,.01,0.08, 0.03,"Exit",exitEvent));
        this.title = "Welcome!";
        this.choose = "Please choose a query of the data";
        //create sun object
        sun = new Planet (100, 0, 0, sunIm);
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
        translate(width/2,height/2);
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
        textSize(getTextSizeChart(width*(1.0/4.0),height*.2,this.title.length()));
        text(this.choose, width*.5, height*.75);
        textSize(getTextSizeChart(width*(1.0/3.0),height*.2,this.title.length()));
        text(this.title, width*.5, height*.15);
        popStyle();
    }

    public int getEvent(MouseEvent e) {
        int event;
        for(Widget w : screenWidgets) {
            event = w.getEvent(e);
            switch(event) {
                case toggleAudioEvent:
                    if(audio.isPlaying()) audio.pause();
                    else audio.play();
                    return toggleAudioEvent;
                case exitEvent:
                    exit();
                    return exitEvent;
            }
        }
        return super.getEvent(e);
    }
    void resize()
   {
       super.resize();
       //sun.resize();
   }
}