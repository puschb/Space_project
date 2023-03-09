//Class created by B. Pusch
//Screen for countries query
public class CountriesScreen extends Screen
{
    private float fHeaderHeight, fuIx, headerHeight, uIx, fuIWidth, uIWidth, fuIy, uIy, fuIHeight, uIHeight;
    private ArrayList<Mapping> data;
    private String year;
    private static final int sliderEvent = 11;
    private static final int updateButtonEvent = 12;
    
    public CountriesScreen()
    {
        super();
        this.screenColour = color(58,72,90);
        this.fHeaderHeight = .05;
        this.fuIx = .66;
        this.headerHeight = height*fHeaderHeight;
        this.uIx = width*fuIx;
        this.year = "1960";
        this.fuIWidth = .29;
        this.uIWidth = width*fuIWidth;
        this.fuIy = .1;
        this.uIy = fuIy*height;
        this.fuIHeight = .85;
        this.uIHeight = height*fuIHeight;
        data = new ArrayList<Mapping>();
        updateLaunchesVsCountryPerYear();
        screenGraphs.add(new PieChart(0,fHeaderHeight,fuIx,1-fHeaderHeight, "Number of Satellites by Country in "+ this.year,this.data));
        screenWidgets.add(new ButtonWidget(.01,.01,(fHeaderHeight-.01)*2, fHeaderHeight-.02,"Return",GRAPH_SCREEN)); 
        screenWidgets.add(new Slider(fuIx+.02,.74, fuIWidth-.02*2,.07,sliderEvent));
        screenWidgets.add(new ButtonWidget(fuIx+.02,.8,fuIWidth-.02*2,.1,"Update Graph", updateButtonEvent));
    }

    //created by B.Pusch
    public void draw()
    {
        pushStyle();    
        background(0);
        noStroke();
        //draw header
        fill(color(32,33,36));
        rect(0,0,width,headerHeight);
        //draw title 
        fill(255);
        textSize(getTextSizeChart(uIWidth,.1*height,10));
        textAlign(CENTER, BOTTOM);
        text("Year: " + this.year,(uIx+uIx+uIWidth)/2,.72*height);
        //draw legend and slider
        drawUI();
        drawLegend();
        popStyle();
        super.draw();    
    }

    //function to draw the UI created by B.Pusch
    private void drawUI()
    {
        pushStyle();
        stroke(200);
        strokeWeight(2);
        fill(50);
        rect(uIx, uIy, uIWidth,uIHeight,8);
        popStyle();
    }

    //function to draw and update legend created by B.Pusch
    private void drawLegend()
    {
        pushStyle();
        ArrayList<Mapping> colors = ((PieChart)this.screenGraphs.get(0)).getColors();
        float legendX = uIx+.1*uIWidth;
        float legendWidth = uIWidth*.8;
        float legendY = uIy+.08*uIHeight;
        float legendHeight = .6*uIHeight;
        rect(legendX,legendY,legendWidth,legendHeight,6);
        float entryHeight = legendHeight/11;
        float entryOffset = legendHeight/11/2;
        int count = 0;
        int otherTotal = 0;
        MappingKeyComparator comp = new MappingKeyComparator();
        stroke(0);
        rectMode(CENTER);
        textAlign(LEFT,CENTER);
        textSize(.6*entryHeight);
        for(Mapping c: this.data)
        {
            if(count<9)
            {
                fill(colors.get(Collections.binarySearch(colors,c,comp)).getValue());
                rect(legendX+.05*legendWidth+entryHeight/2,legendY+entryOffset+ entryHeight*count+ entryHeight/2,entryHeight*.7,entryHeight*.7);
                fill(0);
                text(" " +c.getKey() + " | Count: " + c.getValue(),legendX+.05*legendWidth+entryHeight*.7 ,legendY+entryOffset+ entryHeight/2 + entryHeight*count);
            }
            else
                otherTotal += c.getValue();
            count++;
        }
        if(count>=9)
        {
            fill(color(100,100,150));
            rect(legendX+.05*legendWidth+entryHeight/2,legendY+entryOffset+ entryHeight*9 + entryHeight/2,entryHeight*.7,entryHeight*.7);
            fill(0);
            text(" Other | Count: " + otherTotal,legendX+.05*legendWidth+ entryHeight*.7,legendY+entryOffset+ entryHeight/2+ entryHeight*9); 
        }       
        popStyle();
    }
    
    //function to get event 
    public int getEvent(MouseEvent e)
   {
       int event;
       for(Widget w: screenWidgets)
       {
           event = w.getEvent(e);
           switch(event)
           {
                case updateButtonEvent:
                    updateLaunchesVsCountryPerYear();
                    ((PieChart)screenGraphs.get(0)).setGraph(this.data); 
                    return event;
                case sliderEvent:
                    this.year = String.valueOf((int)(MINIMUM_YEAR+ (MAXIMUM_YEAR-MINIMUM_YEAR)*((Slider) screenWidgets.get(1)).getFractionOfSlider()));
                    screenGraphs.get(0).setTitle("Number of Satellites by Country in "+ this.year);
                    return event;
                case GRAPH_SCREEN:
                    return event;
           }
       }
       return NULL_EVENT;
   }
   
   // queries data to update displayed graphical information
   private void updateLaunchesVsCountryPerYear()
   {
       if(data != null)
            this.data.clear();
        String regex = "("+ this.year+ ").*";
       for(TableRow row: gcat.matchRows(regex,"LDate"))
        {
            try
            {
                Mapping category = new Mapping(orgs.findRow(row.getString("State"),"StateCode").getString("ShortEName"));
                if(category != null && !data.contains(category))
                    data.add(category);
                else if(data.contains(category))
                    this.data.get(this.data.indexOf(category)).increment();
            }
            catch(Exception e) {continue;}
        }   
   }

    //function to update and resize screen
   void resize()
   {
       super.resize();
       this.headerHeight = fHeaderHeight*height;
       this.uIWidth = fuIWidth*width;
       this.uIx = fuIx*width;
       this.uIy = fuIy*height;
       this.uIHeight = fuIHeight*height;
   }
}