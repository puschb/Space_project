//Class created by B. Pusch
//Superclass for widget objects
public class Widget
{
    float fx, fy, fwidth, fheight; 
    float x,y,wWidth,wHeight;
    int event;
    
    Widget(float fx, float fy, float fwidth, float fheight, int event)
    {
        this.fx = fx; this.fy = fy; this.fwidth = fwidth; this.fheight = fheight;
        this.event = event;
        this.resize();
    }

    void draw()
    {
    } 

    int getEvent(MouseEvent e)
    {
        return NULL_EVENT;
    }

    int getEvent(KeyEvent e)
    {
        return NULL_EVENT;
    }
    
    void resize()
    {
        this.wWidth = width * fwidth;
        this.wHeight =  height * fheight;
        this.x = width * fx;
        this.y = height * fy;
    }
}