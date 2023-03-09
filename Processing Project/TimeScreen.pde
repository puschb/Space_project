//Class made by L. Chow 
//Screen for dot plot query
//Subclass of screen class
public class TimeScreen extends Screen
{ 
    private float fHeaderHeight, fVisualizationDivider, headerHeight, visualizationDivider;
    private String title, xLabel, yLabel, switchEvent, switchCountry, country;
    private ArrayList<Float> data;
    private ArrayList<Integer> year;
    private static final int massButtonEvent = 11;
    private static final int totalMassButtonEvent = 12;
    private static final int lengthButtonEvent = 13;
    private static final int spanButtonEvent = 14;
    private static final int suButtonEvent = 15;
    private static final int ruButtonEvent = 16;
    private static final int cnButtonEvent = 17;
    private static final int usButtonEvent = 18;
    
    public TimeScreen() 
    {
        super();
        this.screenColour = color(0);
        this.fHeaderHeight = .05;
        this.fVisualizationDivider = .32;
        this.headerHeight = height*fHeaderHeight;
        this.visualizationDivider = height*fVisualizationDivider;
        this.country = "the Soviet Union";
        this.switchEvent = "Mass";
        this.switchCountry = "SU";
        this.xLabel = "Time (years)";
        this.yLabel = this.switchEvent+" (KG)";
        this.title = this.switchEvent+" vs Time of Objects in "+this.country;
        //arraylist for y axis data
        this.data = new ArrayList<Float>();
        //arraylist for x axis data
        this.year = new ArrayList<Integer>();
        getValues();
        //draw widgets on screen
        screenWidgets.add(new ButtonWidget(.01,.01,(fHeaderHeight-.01)*2, fHeaderHeight-.02,"Return",GRAPH_SCREEN));
        screenWidgets.add(new ButtonWidget(.15, .8, .12, .07, "Mass",massButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.3, .8, .12, .07, "Total Mass",totalMassButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.15, .9, .12, .07, "Length",lengthButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.3, .9, .12, .07, "Span",spanButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.625, .8, .12, .07, "Soviet Union",suButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.775, .8, .12, .07, "Russia",ruButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.625, .9, .12, .07, "China",cnButtonEvent,20));
        screenWidgets.add(new ButtonWidget(.775, .9, .12, .07, "United States",usButtonEvent,20));
        //draw dot plot graph
        screenGraphs.add(new DotPlot(0.0,fHeaderHeight,1, 0.75, this.title, this.data, this.year,this.xLabel, this.yLabel));
    }

    public void draw()
    {
        pushStyle();
        background(this.screenColour);
        //draw header
        fill(color(32,33,36));
        rect(0,0,width,headerHeight);
        //draw divider
        fill(50);
        strokeWeight(2);
        stroke(200);
        rect(width*0.05,height*.785, .9*width, .2*height,8);
        fill(255);
        textSize(25*height/800);
        text("Filter : ",width*.1, .9*height);
        text("Country : ",width*.55, .9*height);
        popStyle();
        super.draw();
    }
 
    //function to get, change variables and return event to update graph
    public int getEvent(MouseEvent e)
    {
        int event;
        for (Widget w: screenWidgets)
        {
            event = w.getEvent(e);
            switch(event)
            {
                //mass widget pressed, update to new graph and title with mass variable and current country
                case massButtonEvent:
                    this.switchEvent = "Mass";
                    getValues();
                    this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    this.yLabel = this.switchEvent+" (KG)";
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //total mass widget pressed, update to new graph and title with total mass variable and current country
                case totalMassButtonEvent:
                    this.switchEvent = "TotMass";
                    getValues();
                    this.yLabel =  "Total Mass (KG)";
                    this.title = "Total Mass vs Time of Objects in "+this.country;
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //length widget pressed, update to new graph and title with length variable and current country
                case lengthButtonEvent:
                    this.switchEvent = "Length";
                    getValues();
                    this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    this.yLabel = this.switchEvent+" (M)";
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //span widget pressed, update to new graph and title with span variable and current country
                case spanButtonEvent:
                    this.switchEvent = "Span";
                    getValues();
                    this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    this.yLabel = this.switchEvent+" (M)";
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //SU widget pressed, update to new graph and title with Soviet Union country and current variable
                case suButtonEvent:
                    this.switchCountry = "SU";
                    this.country = "the Soviet Union";
                    getValues();
                    if (this.switchEvent.equals("TotMass"))
                        this.title = "Total Mass vs Time of Objects in "+this.country;
                    else 
                        this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //Russia widget pressed, update to new graph and title with Russia country and current variable
                case ruButtonEvent:
                    this.switchCountry = "RU";
                    this.country = "Russia";
                    getValues();
                    if (this.switchEvent.equals("TotMass"))
                        this.title = "Total Mass vs Time of Objects in "+this.country;
                    else 
                        this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //China widget pressed, update to new graph and title with China country and current variable
                case cnButtonEvent:
                    this.switchCountry = "CN";
                    this.country = "China";
                    getValues();
                   if (this.switchEvent.equals("TotMass"))
                        this.title = "Total Mass vs Time of Objects in "+this.country;
                    else 
                        this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //US widget pressed, update to new graph and title with United states country and current variable
                case usButtonEvent:
                    this.switchCountry = "US";
                    this.country = "the United States";
                    getValues();
                    if (this.switchEvent.equals("TotMass"))
                        this.title = "Total Mass vs Time of Objects in "+this.country;
                    else 
                        this.title = this.switchEvent+" vs Time of Objects in "+this.country;
                    ((DotPlot)screenGraphs.get(0)).setGraph(this.data,this.year,this.title,this.xLabel,this.yLabel); 
                    return event;
                //return to graph screen
                case GRAPH_SCREEN:
                    return event;
            }
        }
        return NULL_EVENT;
    }

    //function to get values with the current variable and country
    private void getValues()
    {
        boolean hasData = true;
        for (int row = 0; row<=gcat.getRowCount(); row++)
        {
            try
            {
                String state = gcat.getString(row, "State");
                if (state.equals(this.switchCountry))
                {
                    if (hasData && this.data != null)
                    {
                        this.data.clear();
                        this.year.clear();
                    }
                    hasData = false;
                    data.add(gcat.getFloat(row, this.switchEvent));
                    year.add(Integer.parseInt(gcat.getString(row,"LDate").substring(0,4)));
                }
            }
            catch(Exception e) {continue;}
        }
    }

    //function to resize screen
    void resize()
    {
        super.resize();
        this.headerHeight = fHeaderHeight*height;
    }
}