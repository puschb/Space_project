//Class created by B. Pusch
//function
public class OrbitMenu extends Widget
{
    ArrayList<OrbitMenuEntry> entries;
    ButtonWidget pageUp, pageDown;
    private static final int pageUpEvent = 11;
    private static final int pageDownEvent = 12;
    float fEntryHeight, entryHeight;
    private static final int numEntries = 15;
    float buttonHeight;
    ArrayList<String[]> data;
    int index, currentEntryEvent;
    boolean getEntryEvent;

    public OrbitMenu(float fx, float fy, float fwidth, float fheight, int event)
    {
        super(fx,fy,fwidth,fheight,event);
        this.data = null;
        this.buttonHeight = fheight/20;
        this.fEntryHeight = (fheight-buttonHeight)/numEntries;
        this.index = 0;
        this.currentEntryEvent = 0;
        boolean getEntryEvent = false;
        this.pageUp = new ButtonWidget(fx,fy+fheight-buttonHeight,fwidth/2,buttonHeight,"Page Up",pageUpEvent);
        this.pageDown = new ButtonWidget(fx+fwidth/2,fy+fheight-buttonHeight,fwidth/2,buttonHeight,"Page Down",pageDownEvent);
        this.entries = new ArrayList<OrbitMenuEntry>();
        for(int i =0;i<numEntries;i++)
        {
            this.entries.add(new OrbitMenuEntry(fx,fy+fEntryHeight*i,fwidth,fEntryHeight,20+i,"","0"));
        }
    }

    void draw()
    {
        pushStyle();
        stroke(0);
        fill(255);
        rect(x,y,wWidth,wHeight);
        pageUp.draw();
        pageDown.draw();
        for(OrbitMenuEntry o: entries)
        {
            o.draw();
        }
        popStyle();
    }

    int getEvent(MouseEvent e)
    {
        if(pageUp.getEvent(e) == pageUpEvent)
        {
            this.index = Math.max(0,index-1);
            setData();
            return this.event;
        }
        if(pageDown.getEvent(e) == pageDownEvent)
        {
            this.index = (index+1)*numEntries >= this.data.size()?index:index+1;
            setData();
            return this.event;
        }
        int event;
        for(OrbitMenuEntry ent:entries)
        {
            event = ent.getEvent(e);
            //System.out.println(event);
            if(event != NULL_EVENT)
            {
                this.currentEntryEvent = event;
                this.getEntryEvent = true;
                return this.event;
            }
                
        }
        return NULL_EVENT;
    }

    public boolean isGetID()
    {
        boolean isGetID = this.getEntryEvent;
        this.getEntryEvent = false;
        return isGetID;
    }

    public String getID()
    {
        return entries.get(this.currentEntryEvent-20).getID();
    }

    void resize()
    {
        super.resize();
        if(pageDown != null)
            pageDown.resize();
        if(pageUp != null)
            pageUp.resize();   
        if(entries != null) 
            for(OrbitMenuEntry e:entries)
                e.resize();
    }

    void setData()
    {
        int dataIndex;
        String label;
        for(int i =0;i<numEntries;i++)
        {
            dataIndex = index*numEntries + i;
            if(dataIndex < data.size())
            {
                label = this.data.get(dataIndex)[3] +    " | " + this.data.get(dataIndex)[4];
                this.entries.get(i).reset(this.data.get(dataIndex)[1],label);
            }
            else this.entries.get(i).resetNull();
        }
    }

    void addData(ArrayList<String[]> data)
    {       
        this.data = data;
        setData();
    }

    public void resetIndex()
    {
        this.index = 0;
        setData();
    }
}