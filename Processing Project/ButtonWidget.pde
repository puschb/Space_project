//Class created by B. Pusch
//Used for pressing buttons
public class ButtonWidget extends Widget
{
    String label;
    color labelColor,buttonSelectedColor, buttonColor;
    boolean hover;
    static final int RECT_RADII = 8;
    float fontSize;

    //widget constructor (without font size argument) created by B.Pusch
    public ButtonWidget(float fx, float fy, float fwidth, float fheight, String label, int event)
    {
        super(fx,fy,fwidth,fheight,event);
        this.label = label;
        this.buttonColor = color(255);
        this.buttonSelectedColor = color(100);
        this.labelColor = color(0);
        this.hover = false;
        this.fontSize = -1;
    }

    //widget constructor to incorporate font sizecreated by B.Pusch
    public ButtonWidget(float fx, float fy, float fwidth, float fheight, String label, int event, float fontSize)
    {
        super(fx,fy,fwidth,fheight,event);
        this.label = label;
        this.buttonColor = color(255);
        this.buttonSelectedColor = color(100);
        this.labelColor = color(0);
        this.hover = false;
        this.fontSize = fontSize/1000;
    }
    // created by B.Pusch
    public void draw(){
        
        pushStyle();
        noStroke();
        if(hover)
            fill(buttonSelectedColor);
        else
            fill(buttonColor);
        rect(x,y,wWidth,wHeight,RECT_RADII);
        //draw text on widget
        textAlign(CENTER, CENTER);
        if (this.fontSize == -1)
            textSize(getTextSizeChart(this.wWidth, this.wHeight, label.length()));
        else
            textSize(this.fontSize*width);
        fill(this.labelColor);
        text(label,x,y,wWidth,wHeight);
        popStyle();
    }

    //function to get and return mouse event created by B.Pusch
    int getEvent(MouseEvent e)
    { 
        if( (mouseX >= this.x && mouseX < this.x+this.wWidth)
            &&
            (mouseY >= this.y && mouseY < this.y+this.wHeight))
        {
            this.hover = true;
            if (e.getAction() == MouseEvent.RELEASE)
            {
                this.hover = false;
                return this.event;
            }
        }
        else
        {
            this.hover = false;
        }
        return NULL_EVENT;
    }



    

}