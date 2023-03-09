//Class created by L. Chow
//Object for a dot plot
public class DotPlot extends Graph
{
    private ArrayList<Float> data;
    private ArrayList<Integer> year;
    private String xALabel, yALabel;

    public DotPlot(float fx, float fy, float fwidth, float fheight,String title, ArrayList<Float> data,ArrayList<Integer> year, String xALabel, String yALabel)
    { 
        super(fx,fy,fwidth,fheight,title);
        this.xALabel = xALabel; 
        this.yALabel = yALabel;
        this.data = data;
        this.year = year;
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
        drawDot(leftOffsetX, rightOffsetX, offsetY);
        popStyle();
    }

    //function to draw axes and x and y axis labels
    private void drawAxes(float leftOffset, float rightOffset, float offsetY)
    {
        pushStyle();
        strokeWeight(1);
        stroke(255);
        line(this.x+leftOffset,this.y+offsetY,this.x+leftOffset,this.y+this.gHeight-offsetY);
        line(this.x+leftOffset,this.y+this.gHeight-offsetY,this.x+this.gWidth-rightOffset,this.y+this.gHeight-offsetY);
        timeLabels(leftOffset, offsetY);
        drawHashMarks(leftOffset, offsetY);
        fill(255);
        textAlign(CENTER, BOTTOM);
        textSize(20*height/800);
        text(this.yALabel,this.x+leftOffset,this.y+offsetY-20);
        textAlign(LEFT,CENTER);
        text(this.xALabel, this.x+this.gWidth-rightOffset+50*width/1000,this.y+this.gHeight-offsetY);
        popStyle();
    }

    //function called in drawAxes() to draw the lines and caluculate the values of the y axis 
    private void drawHashMarks(float leftOffset, float offsetY)
    {
        pushStyle();
        float maxValue =Collections.max (this.data);
        float minValue = Collections.min(this.data);
        float axisLength = this.gHeight*.8;
        stroke(255);
        fill(255);
        textAlign(RIGHT,CENTER);
        for(int i = 1;i<=5;i++)
            {
                float hashHeight = this.y+this.gHeight-offsetY-axisLength/5*i;
                line(this.x+leftOffset,hashHeight,this.x+leftOffset+10, hashHeight);
                String hashLabel = Integer.toString((int)(maxValue/5.0*i)) + " ";
                textSize(getTextSizeChart(leftOffset,axisLength/15,hashLabel.length()));
                text(hashLabel,this.x+leftOffset,hashHeight);
            } 
        popStyle();
    }

    //function to find the x and y coordinates of the object to places the corresponding dot
    private void drawDot(float leftOffset, float rightOffset, float offsetY)
    {
        pushStyle();
        float maxValue =Collections.max (this.data);
        float minValue = Collections.min(this.data);
        float maxYear =Collections.max (this.year);
        float minYear = Collections.min(this.year);
        for (int i = 0; i < this.data.size(); i++) 
        {
            float x = map(year.get(i), minYear, maxYear, this.x+leftOffset,this.x+this.gWidth-rightOffset);
            float y = map(data.get(i), minValue, maxValue, this.y+this.gHeight-offsetY, this.y+offsetY);
            strokeWeight(5);
            fill(color(0,100,200));
            stroke(color(0,100,200));
            point(x, y);
        }
        popStyle();
    }

    //function called in drawAxes() to draw the lines and calculate the values of the x axis
    private void timeLabels(float leftOffset, float offsetY)
    {
        pushStyle();
        float maxValue =Collections.max (this.year);
        float minValue =Collections.min (this.year);
        float axisLength = this.gWidth*.7;
        stroke(255);
        fill(255);
        textAlign(CENTER,TOP);
        float xLabelMove = this.x+leftOffset;
        for(int i = 1;i<=8;i++)
            {
                line(xLabelMove+87.5,this.y+this.gHeight-offsetY,xLabelMove+87.5, this.y+this.gHeight-offsetY+10);
                String hashLabel =  Integer.toString((int)(minValue+(maxValue-minValue)/8*i)) + " ";
                textSize(getTextSizeChart(leftOffset,axisLength/8,hashLabel.length()));
                text(hashLabel,xLabelMove+leftOffset,this.y+this.gHeight-offsetY+5);
                xLabelMove+=axisLength/8;
            } 
        popStyle();
    }

    //function to reset and update graph
    public void setGraph(ArrayList<Float> data,ArrayList<Integer> year, String title, String xALabel, String yALabel)
    {
        this.xALabel = xALabel; this.yALabel = yALabel;
        this.data = data;
        this.year = year;
        this.title = title;
    }
    //function to reset and update graph
    public void setGraph(ArrayList<Float> data, ArrayList<Integer> year)
    {
        this.data = data;
        this.year = year;
    }
}