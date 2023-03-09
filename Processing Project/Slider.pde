//Class created by B. Pusch
//Slider object used by screens
//Subclass of widget class
public class Slider extends Widget
{
    color sliderColor,tickColor;
    float xTick, yTick, ftickWidth;
    float fxTick, fyTick;

    public Slider(float fx, float fy, float fwidth, float fheight,int event)
    {
        super(fx,fy,fwidth,fheight,event);
        this.xTick = x; this.yTick = y; this.ftickWidth = .03;
        this.fxTick = this.xTick/width; this.fyTick = this.yTick/height;
        sliderColor = color(100);
        this.tickColor = color(100);
    }

    public void draw()
    {
        pushStyle();
        stroke(sliderColor);
        strokeWeight(.4*wHeight);
        line(x,y,x+wWidth, y);
        noStroke();
        fill(sliderColor);
        circle(x,y,wHeight*.4);
        circle(x+wWidth,y,wHeight*.4);
        rectMode(CENTER);
        fill(tickColor);
        noStroke();
        rect(xTick, yTick, ftickWidth*width, wHeight,wHeight*.2);
        popStyle();
    }

    public float getFractionOfSlider()
    {
        return (this.xTick-this.x)/(this.wWidth);
    }

    int getEvent(MouseEvent e)
    {
        if(e.getAction() == MouseEvent.DRAG)
        {
            if( (mouseX >= this.xTick-this.ftickWidth*width/2 && mouseX < this.xTick+this.ftickWidth*width/2)
            &&
            mouseY >= this.yTick - this.wHeight/2 && mouseY < this.yTick+this.wHeight/2)
            {
                this.xTick = mouseX > this.x+ this.wWidth?this.x+ this.wWidth:mouseX < this.x?this.x:mouseX;
                this.fxTick = xTick/width;
                return this.event;
            }
        }
        return NULL_EVENT;
    }

    void resize()
    {
        super.resize();
        xTick = fxTick*width;
        yTick = fyTick*height;
    }
}