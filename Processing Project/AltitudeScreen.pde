//Class created by L. Chow
//Screen for altitude query by objects within a certain altitude (perigee/apogee) range displayed though a bar chart
public class AltitudeScreen extends Screen 
{ 
    private float fHeaderHeight, fVisualizationDivider, headerHeight, visualizationDivider,maxRange, minRange;
    private String title, xLabel, yLabel, switchEvent;
    private int barColor;
    private ArrayList<Mapping> data;
    private static final int switchPerigeeEvent = 11;
    private static final int switchApogeeEvent = 12;
    private static final int updateButtonEvent = 13;
    private static final int minInputEvent = 14;
    private static final int maxInputEvent = 15;

    public AltitudeScreen()
    {
        super();
        this.screenColour = color(0);
        this.fHeaderHeight = .05;
        this.fVisualizationDivider = .75;
        this.headerHeight = height*fHeaderHeight;
        this.visualizationDivider = width*fVisualizationDivider;
        this.title = "Perigee Bar Chart";
        this.xLabel = "Type of Object";
        this.yLabel = "Total Objects";
        this.switchEvent = "Perigee";
        this.maxRange = 400; 
        this.minRange = -100; 
        this.data = new ArrayList<Mapping>();
        getValues();
        // add bar chart to screen
        screenGraphs.add(new BarChart(0.0,fHeaderHeight,fVisualizationDivider, 1-fHeaderHeight, this.title, this.xLabel, this.yLabel, this.data));
        // add widgets to the screen
        screenWidgets.add(new ButtonWidget(.01,.01,(fHeaderHeight-.01)*2, fHeaderHeight-.02,"Return",GRAPH_SCREEN)); 
        screenWidgets.add(new ButtonWidget(.775, .125, .15, .15, "Perigee",switchPerigeeEvent));
        screenWidgets.add(new ButtonWidget(.775, .3, .15, .15, "Apogee",switchApogeeEvent)); 
        screenWidgets.add(new ButtonWidget(.75,.775,.2,.075,"Update Graph", updateButtonEvent));
        // add maximum and minimum text boxes to the screen
        screenWidgets.add(new TextBox(.75,.525,.2,.05,minInputEvent,"Numbers"));
        screenWidgets.add(new TextBox(.75,.66,.2,.05,maxInputEvent,"Numbers"));
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
        rect(width*.725,height*.1, .25*width, .8*height,8);
        fill(255);
        textSize(20*height/800);
        text("Minimum",width*.85,height*.5);
        text("Maximum",width*.85,height*.65);
        popStyle();
        super.draw();
    }

    
    public int getEvent(MouseEvent e)
    {
        int event;
        for (Widget w: screenWidgets)
        {
            event = w.getEvent(e);
            switch(event)
            {
                // if perigee widget is pressed, it will get the new values and create a new graph
                case switchPerigeeEvent:
                    this.switchEvent = "Perigee";
                    getValues();
                    ((BarChart)screenGraphs.get(0)).setGraph(this.data,"Perigee Bar Chart",this.xLabel,this.yLabel); 
                    return event;
                // if apogee widget is pressed, it will get the new values and create a new graph
                case switchApogeeEvent:
                    this.switchEvent = "Apogee";
                    getValues();
                    ((BarChart)screenGraphs.get(0)).setGraph(this.data,"Apogee Bar Chart",this.xLabel,this.yLabel);
                    return event;
                case minInputEvent:
                    return event;
                case maxInputEvent:
                    return event;
                // if update button is pressed, it will get new values between the new range for perigee and create a new graph
                case updateButtonEvent:
                    this.switchEvent = "Perigee";
                    setPerigee(this.maxRange,this.minRange);
                    getValues();
                    ((BarChart)screenGraphs.get(0)).setGraph(this.data,"Perigee Bar Chart",this.xLabel,this.yLabel); 
                    return event;
                case GRAPH_SCREEN:
                    return event;
            }
        }
        return NULL_EVENT;
    }
    
     public int getEvent(KeyEvent e)
   {
       int event;
       for(Widget w: screenWidgets)
       {
           event = w.getEvent(e);
           switch(event)
           {
               // turns string input to float for maximum and minimum
               case minInputEvent:
                    try{this.minRange = Float.parseFloat(((TextBox)w).getString());}
                    catch(Exception e1) {return event;}
                    return event;
               case maxInputEvent:
                    try{this.maxRange = Float.parseFloat(((TextBox)w).getString());}
                    catch(Exception e1){return event;}
                    return event;
           }
       }
       return NULL_EVENT;
   }

    // function to get values from data set and put them into an arraylist to use in the barchart
    private void getValues()
    {
        boolean hasData = true;
       for (int row = 0; row <= gcat.getRowCount(); row++) 
       {
           try
           {
            String value = gcat.getString(row, this.switchEvent);
            Float num = Float. parseFloat(value);
            if (num>=this.minRange && num <=this.maxRange)
            {
                if (hasData && this.data != null)
                    this.data.clear();
                hasData = false;
                //Just quering objects that are P, R, C, D
                String type = Character.toString(gcat.getString(row, "Type").replaceAll("[^PRCD]", "").charAt(0));
                switch (type)
                {
                    case ("P"):
                    type = "Payload";
                    break;
                    case("R"):
                    type = "Vehicle";
                    break;
                    case("C"):
                    type = "Component";
                    break;
                    case("D"):
                    type = ("Debris");
                    break;
                }
                Mapping category = new Mapping(type);
                if(category != null && !data.contains(category))
                    data.add(category);
                else if(data.contains(category))
                    this.data.get(this.data.indexOf(category)).increment();
            }
           }
           catch (Exception e){

           }
       }
    }

    // resize screen
    void resize()
   {
       super.resize();
       this.visualizationDivider = fVisualizationDivider*width;
       this.headerHeight = fHeaderHeight*height;
   }

    // function to ensure perigee entered is within bounds
   private void setPerigee(float maxRange, float minRange){
       if (maxRange<MINIMUM_PERIGEE)
            maxRange = MINIMUM_PERIGEE;
        if (maxRange>MAXMIM_PERIGEE)
            maxRange = MAXMIM_PERIGEE;
   }

    // function to ensure apogee entered is within bounds
   private void setApogee (float maxRange, float minRange){
       if (maxRange<MINIMUM_APOGEE)
            maxRange = MINIMUM_PERIGEE;
        if (maxRange>MAXMIM_PERIGEE)
            maxRange = MAXIMUM_APOGEE;
   }
}
