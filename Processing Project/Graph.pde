//Class created by B. Pusch
//Superclass for graphs

abstract public class Graph
{
    float fx, fy, fwidth, fheight;
    float x,y,gWidth,gHeight;
    String title;
    color backGroundColor, primaryColor;

    public Graph(float fx, float fy, float fwidth, float fheight,String title)
    {
        this.fx = fx; this.fy = fy; this.fwidth = fwidth; this.fheight = fheight;
        
        resize();

        this.title = title;
        this.backGroundColor = color(255);
        this.primaryColor = color(0);
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    abstract void draw();
    void resize()
    {
        this.gWidth = width * fwidth;
        this.gHeight =  height * fheight;
        this.x = width * fx;
        this.y = height * fy;
    }
}