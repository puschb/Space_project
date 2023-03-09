//Class created by B. Pusch
//function
public class OrbitMenuEntry extends Widget
{
    boolean selected;
    String label;
    color backgroundColor, textColor, selectedColor;
    String id; 

    public OrbitMenuEntry(float fx, float fy, float fwidth, float fheight, int event, String label,String id)
    {
        super(fx,fy,fwidth,fheight,event);
        this.label = label; this.id = id;
        this.backgroundColor = color(255); this.textColor = color(0);
        this.selectedColor = color(200);
        this.selected = false;
    }

    void draw()
    {
        pushStyle();
        rectMode(CORNER);
        if(this.selected) fill(this.selectedColor);
        else fill(this.backgroundColor);
        strokeWeight(2);
        stroke(0);
        rect(this.x,this.y,this.wWidth,this.wHeight);
        textSize(getTextSize(this.wWidth, this.wHeight, this.label.length()));
        fill(this.textColor);
        text(this.label, this.x,this.y,this.wWidth,this.wHeight);
        popStyle();
    }

    int getEvent(MouseEvent e)
    { 
        if( (mouseX >= this.x && mouseX < this.x+this.wWidth)
            &&
            (mouseY >= this.y && mouseY < this.y+this.wHeight))
        {
            this.selected = true;
            if (e.getAction() == MouseEvent.RELEASE)
            {
                return this.event;
            }
        }
        else{
            this.selected = false;
        }
        return NULL_EVENT;
    }

    public String getID()
    {
        return this.id;
    }

    public void reset(String id, String label)
    {
        this.id = id; this.label = label;
    }

    public void resetNull()
    {
        this.id = ""; this.label = "";
    }
}