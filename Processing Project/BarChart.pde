//Class created by G. Mullen 
//Modified by B. Pusch to incorporate more functionality
//Object for a bar chart object
public class BarChart extends Graph
{   
    ArrayList<Mapping> data;
    String xALabel, yALabel;
    ArrayList<Integer> barColors;


    public BarChart(float fx, float fy, float fwidth, float fheight,String title, String xALabel, String yALabel, ArrayList<Mapping> data)
    {
        super(fx,fy,fwidth,fheight,title);
        this.xALabel = xALabel; this.yALabel = yALabel;
        this.data = data;
        this.barColors = new ArrayList<Integer>();
        createBarColors();
    }

    public void draw()
    {
        pushStyle();
        //calculating offset
        float leftOffsetX = this.gWidth*.1;
        float rightOffsetX = this.gWidth *.2;
        float offsetY = this.gHeight*.1;
        //display title
        fill(255);
        textSize(getTextSizeChart(gWidth,offsetY,this.title.length()));
        textAlign(CENTER,TOP);
        text(this.title,this.gWidth/2+this.x,this.y);
        //draw axes and dots
        drawAxes(leftOffsetX, rightOffsetX, offsetY);
        drawColumnsWithLabels(leftOffsetX, rightOffsetX, offsetY);
        popStyle();
    }

    //function to draw axes and x and y axis labels created by B.Pusch
    private void drawAxes(float leftOffset, float rightOffset, float offsetY)
    {
        pushStyle();
        strokeWeight(1);
        stroke(255);
        line(this.x+leftOffset,this.y+offsetY,this.x+leftOffset,this.y+this.gHeight-offsetY);
        line(this.x+leftOffset,this.y+this.gHeight-offsetY,this.x+this.gWidth-rightOffset,this.y+this.gHeight-offsetY);
        drawHashMarks(leftOffset, offsetY);
        fill(255);
        textAlign(CENTER, BOTTOM);
        textSize(20 *height/800);
        text(this.yALabel,this.x+leftOffset,this.y+offsetY-20*height/800);
        textAlign(LEFT,BOTTOM);
        textSize(15* width/1000);
        text(this.xALabel, this.x+this.gWidth-rightOffset,this.y+this.gHeight-offsetY);
        popStyle();
    }

    //function called in drawAxes() to draw the lines and caluculate the values of the y axis  created by B.Pusch
    private void drawHashMarks(float leftOffset, float offsetY)
    {
        pushStyle();
        float maxValue = Collections.max(this.data, new MappingComparator()).getValue();
        float axisLength = this.gHeight*.8;
        stroke(255);
        fill(255);
        textAlign(RIGHT,CENTER);
        for(int i = 1;i<=5;i++)
            {
                float hashHeight = this.y+this.gHeight-offsetY-axisLength/5*i;
                line(this.x+leftOffset,hashHeight,this.x+leftOffset+10, hashHeight);
                String hashLabel = Integer.toString((int)(maxValue/5.0*i)) + " ";
                textSize(getTextSizeChart(leftOffset,axisLength/10,hashLabel.length()));
                text(hashLabel,this.x+leftOffset,hashHeight);
            } 
        popStyle();
    } 

    //function to draw the columns and place the label under each bar created by B.Pusch
    private void drawColumnsWithLabels(float leftOffsetX, float rightOffsetX, float offsetY)
    {
        pushStyle();
        float maxValue = Collections.max(this.data, new MappingComparator()).getValue();
        float axisLength = this.gWidth*.7;
        float axisYLength = this.gHeight*.8;
        float increment = axisLength/data.size();
        float columnPosition = this.x+leftOffsetX+ axisLength/(this.data.size()*4);
        float labelPosition = this.x+leftOffsetX+ axisLength/(this.data.size()*2);
        int count =1;
        float textSize = getTextSizeChart(axisLength/data.size(),offsetY,data.get(0).getKey().length());
        for(Mapping m: this.data)
        { 
            textSize = Math.min(getTextSizeChart(axisLength,offsetY,m.getKey().length()),textSize); //should actually be Math.min(getTextSize(axisLength/(xValues.size()),offsetY,s.length()),textSize) but that makes the text too small
        } 
        textAlign(CENTER,TOP);
        textSize(textSize);
        noStroke();
        for(int i =0;i<this.data.size();i++)
        {
            fill(barColors.get(i));
            rectMode(CORNERS);
            rect(columnPosition,this.y+this.gHeight-offsetY-(axisYLength*(this.data.get(i).getValue()/maxValue)), columnPosition+ axisLength/(this.data.size()*2), this.y+this.gHeight-offsetY);
            columnPosition += increment;
            fill(255);
            text(this.data.get(i).getKey(),labelPosition, this.y+this.gHeight-offsetY);
            labelPosition += increment;
        }
        popStyle();
    }

    //function to reset and update graphv
    public void setGraph(ArrayList<Mapping> data, String title, String xALabel, String yALabel)
    {
        this.xALabel = xALabel; this.yALabel = yALabel;
        this.data = data;
        this.title = title;
        createBarColors();
    }
    
    //function to reset and update graph
    public void setGraph(ArrayList<Mapping> data)
    {
        this.data = data;
        createBarColors();
    }

    //function to add different colors to the bar chart
    private void createBarColors()
    {
        if(this.barColors != null & this.data.size() != this.barColors.size())
        {
            this.barColors.clear();
            Random r = new Random();
            for(int i =0; i< this.data.size();i++)
            {
                int blueValue = r.nextInt(100)+100;
                int greenValue = r.nextInt(blueValue/2);
                this.barColors.add(color(0,greenValue,blueValue));
            }
        }
    }
}
