//class created by B. Pusch
//screen that has the link to the AI model we created
public class AIScreen extends Screen 
{
    private static final int AI_LINK_BUTTON = 11;
    private float fHeaderHeight, headerHeight;
    private static final String LINK_TO_AI = "https://colab.research.google.com/drive/1lvM66PfdMTXnljwyzCn9JMUZ_Rh8vAPv?usp=sharing";
    ArrayList<Star> stars;
    private String title, instruction1, instruction2, instruction3,instruction4, example;
    public AIScreen()
    {
        stars = new ArrayList<Star>();
        this.screenColour = color(0);
        this.title = "Instructions";
        this.instruction1 = "1. Click and collapse 'Use AI Model to Query'.";
        this.instruction2 = "2. Press on play button on left hand side under 'Use AI Model to Query'. (Press RUN ANYWAYS)";
        this.instruction3 = "3. Click into 'Use AI Model to Query'.";
        this.instruction4 = "4. Click into question box and ask any question related to the data!";
        this.example = "For example, 'When was the Kosmos rocket launched?'.";
        this.fHeaderHeight = .05;
        headerHeight = height*fHeaderHeight;
        screenWidgets.add(new ButtonWidget(4/12.0,5.5/12,4/12.0,1/12.0, "Visit our AI",AI_LINK_BUTTON));
        screenWidgets.add(new ButtonWidget(.01,.01,(fHeaderHeight-.01)*2, fHeaderHeight-.02,"Return",HOME_SCREEN));
        for(int i = 0;i<500;i++)
            stars.add(new Star());
    }
    //draw function created by B.Pushc
    public void draw()
    {
        pushStyle();
        background(this.screenColour);
        //draw divider
        fill(50);
        strokeWeight(2);
        stroke(200);
        rect(width*0.05,height*.6, .9*width, .3*height,8);
        //draw stars
        pushMatrix();
        translate(width/2,height/3);
        for (Star s:stars)
        {
            s.update();
            s.drawStars();
        }
        popMatrix();
        super.draw();
        //draw instructions
        fill(255);
        textAlign(CENTER,TOP);
        textSize(30);
        text(this.title,width*0.5,height*0.6);
        textSize(20);
        text(this.instruction1, width*0.5,height*0.65);
        text(this.instruction2, width*0.5,height*0.7);
        text(this.instruction3, width*0.5,height*0.75);
        text(this.instruction4, width*0.5, height*0.8);
        text(this.example, width*0.5,height*0.85);
        popStyle();

    }

    //event function created by B.Pushc
    public int getEvent(MouseEvent e)
    {
        int event;
        for(Widget w: screenWidgets)
        {
            event = w.getEvent(e);
            switch(event)
            {
                case HOME_SCREEN:
                    return event;
                case AI_LINK_BUTTON:
                    try {
	                        Desktop.getDesktop().browse(new URL(LINK_TO_AI).toURI());
	                    } 
                    catch (Exception error) {
	                    System.out.println(error);
	                }
                    return event;
            }
        }
        return NULL_EVENT;

    }

    //resize function created by B.Pushc
    void resize()
    {
        super.resize();
        this.headerHeight = fHeaderHeight*height;
    }
}