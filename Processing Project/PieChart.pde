//Class created by B. Pusch
//Object for a pie chart
public class PieChart extends Graph
{
    private ArrayList<Mapping> data;
    private ArrayList<Mapping> colors;

    public PieChart(float fx, float fy, float fwidth, float fheight,String title, ArrayList<Mapping> data)
    { 
        super(fx,fy,fwidth,fheight,title);
        this.data = data;
        this.colors = new ArrayList<Mapping>();
        createColors();
    }

    public void draw()
    { 
        pushStyle();
        float offset = .15;
        fill(0);
        noStroke();
        rect(x,y,gWidth,gHeight);
        drawPie(offset);
        fill(255);
        textSize(getTextSizeChart(gWidth,offset*height,this.title.length()));
        textAlign(CENTER,TOP);
        text(this.title,this.gWidth/2+this.x,this.y+40);
        popStyle();
    }

    private void drawPie(float offset)
    {
        pushStyle();
        float totalValue = 0;
        for(Mapping entry: this.data)
            totalValue += entry.getValue();
        float centerX = this.gWidth/2+this.x;
        float centerY = this.gHeight/2+this.y;
        float diameter = Math.min(this.gWidth*(1-2*offset),this.gHeight*(1-2*offset));
        float currentAngle = 0;
        int count =0;
        for(Mapping entry: this.data)
        {
            
            if(count<9)
            {    
                stroke(this.colors.get(Collections.binarySearch(this.colors,entry,new MappingKeyComparator())).getValue());
                fill(this.colors.get(Collections.binarySearch(this.colors,entry,new MappingKeyComparator())).getValue());
                arc(centerX,centerY,diameter,diameter,currentAngle, currentAngle+ (((float)entry.getValue())/totalValue)*2*PI,PIE);
            }
            else
            {
                fill(color(100,100,150));
                arc(centerX,centerY,diameter,diameter,currentAngle, 2*PI,PIE);
                break;
            }
            count++;
            currentAngle += (entry.getValue()/totalValue)*2*PI;
        }
        popStyle();
    }


    public void setGraph(ArrayList<Mapping> data)
    {
        this.data = data;
        Collections.sort(this.data,  new MappingComparator());
        Collections.reverse(this.data);
    }

    private void createColors()
    {
        Random random = new Random();
        ArrayList<String> countriesUsed = new ArrayList<String>();
        for(TableRow r: gcat.rows())
        {
            String temp = r.getString("State");
            if(!countriesUsed.contains(temp))
            {
                countriesUsed.add(temp);
                int colorParameter1 = random.nextInt(100)+50;
                int colorParameter2 = random.nextInt(colorParameter1/2+1);
                try{
                    this.colors.add(new Mapping(orgs.findRow(temp,"StateCode").getString("ShortEName"),color(0,colorParameter2,colorParameter1)));
                }
                catch(Exception e) {continue;}
                
            }   
        }
        Collections.sort(this.colors, new MappingKeyComparator());
    }
    public ArrayList<Mapping> getColors()
    {
        return this.colors;
    }
    
}












