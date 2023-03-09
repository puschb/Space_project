//Class created by B. Pusch
//Screen for the globe query
public class GlobeScreen extends Screen
{
    private float fradius, radius;
    private float sfx,sfy,sx,sy,sz,hx,hy;
    private PShape globe;
    private ArrayList<Orbit> orbits;
    private ArrayList<String[]> data; //jcat,satcat,type,name,ldate,mass,perigee,apogee,inc,oporbit,raan,ecc
    private ArrayList<String[]> displayedData; //jcat, satcat, type,name,ldate,mass,perigee,apogee,inc,oporbit,raan,ecc
    private static final int jcat =0; private static final int satcat =1; private static final int type =2;private static final int name =3;private static final int ldate =4;private static final int mass =5;
    private static final int perigee =6; private static final int apogee=7; private static final int inc =8;private static final int oporbit =9;private static final int raan =10;private static final int ecc =11;
    float xUIDivider, UIWidth, yUIDivider, UIHeight;
    static final int toggleUIButtonEvent = 11;
    static final int textBoxEvent = 12;
    static final int resetHighlightEvent = 13;
    static final int updateButtonEvent = 14;
    static final int helpButtonEvent = 15;
    static final int orbitMenuEvent = 16;
    static final int maxOrbitsDisplayed = 200;
    static final int infographicWidth = 960;
    static final int infographicHeight = 540;
    boolean hideUI;
    boolean showHelp;

    public GlobeScreen() 
    {
        this.screenColour = color(0);
        this.xUIDivider = .725;  this.UIWidth = .25; this.yUIDivider = .1; this.UIHeight = .8;
        screenWidgets.add(new ButtonWidget(.01,.01,0.08, 0.03,"Return",HOME_SCREEN));  
        screenWidgets.add(new ButtonWidget(xUIDivider+.01+.12,.01,0.12, 0.03,"Toggle UI",toggleUIButtonEvent));
        screenWidgets.add(new ButtonWidget(.775,.825,.15,.05, "Update", updateButtonEvent));
        screenWidgets.add(new ButtonWidget(xUIDivider,.01,.12,.03,"Help",helpButtonEvent));
        screenWidgets.add(new ButtonWidget(.595,.01,.12,.03,"Reset", resetHighlightEvent));
        screenWidgets.add(new OrbitMenu(.75,.23,.2,.57,this.orbitMenuEvent));
        screenWidgets.add(new TextBox(.75,.15,.2,.05,textBoxEvent,"Alphanumeric"));
        this.sfx = .5; this.sfy = .5; this.sz = 0;
        this.fradius = .35;
        this.orbits = new ArrayList<Orbit>();
        this.data = new ArrayList<String[]>();
        this.displayedData = new ArrayList<String[]>();
        this.sx = this.sfx*width; this.sy = this.sfy*height; 
        this.hx = (int) ((float) (width / 2) - (float) (infographicWidth / 2)); this.hy = (int) ((float) (height / 2) - (float) (infographicHeight / 2));
        this.radius = Math.min(width,height)*fradius;
        noStroke();
        noFill();
        query("random");
        this.hideUI = false;
        this.showHelp = false;
        this.globe = createShape(SPHERE, this.radius);
        this.globe.setTexture(earthIm);  
    }

    //Modified by G. Mullen to include a help screen infographic
    public void draw()
    { 
        pushStyle();
        background(this.screenColour);
        cam.endHUD();
        noStroke();
        lights();
        pushMatrix();
        translate(this.sx,this.sy,this.sz);
        shape(this.globe);
        popMatrix();
        int count = 0;
        for(Orbit o: this.orbits)
        {
            o.draw();
        }
        cam.beginHUD();
        if(!hideUI)
        {
            fill(50);
            strokeWeight(2);
            stroke(200);
            rect(width*xUIDivider,height*this.yUIDivider, this.UIWidth*width, this.UIHeight*height,8);
            fill(255);
            rect(.75*width,.23*height,.2*width,.57*height);
            screenWidgets.get(2).draw();
            screenWidgets.get(5).draw();
            screenWidgets.get(6).draw();
        }
        if(showHelp)
        {
            background(0);
            image(infographic, hx, hy);
        }
        screenWidgets.get(0).draw();
        screenWidgets.get(1).draw();
        screenWidgets.get(3).draw();
        screenWidgets.get(4).draw();
        popStyle();
    }

    //Modified by G. Mullen to prevent UI elements from being accessed while help is shown or UI is hidden
    public int getEvent(MouseEvent e)
    {
        int event;
        for(Widget w: screenWidgets)
        {
            event = w.getEvent(e);
            switch(event) {
                case toggleUIButtonEvent:
                    if(!showHelp) this.hideUI = !this.hideUI;
                    return toggleUIButtonEvent;
                case helpButtonEvent:
                    this.showHelp = !this.showHelp;
                    return helpButtonEvent;
                case HOME_SCREEN:
                    cam.setActive(false);
                    return event;
                case textBoxEvent:
                    return textBoxEvent;
                case updateButtonEvent:
                    if(!showHelp) {
                        query(((TextBox)screenWidgets.get(6)).getString());
                        ((OrbitMenu)screenWidgets.get(5)).resetIndex();
                    } return updateButtonEvent;
                case resetHighlightEvent:
                    if(!showHelp) {
                        for(Orbit o:orbits)
                            o.setSelected(false);
                    } return resetHighlightEvent;
                case orbitMenuEvent:
                    if(!showHelp) {
                        if(((OrbitMenu)w).isGetID())
                        {
                            String id = ((OrbitMenu)w).getID();
                            Orbit oID = new Orbit(id,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0);
                            Collections.sort(this.orbits, new OrbitComparator()); 
                            int index = Collections.binarySearch(this.orbits, oID, new OrbitComparator());
                            if(index>=0)
                            {
                                orbits.get(index).setSelected(true);
                            }
                            else
                            {
                                index = (index+1)*-1;
                                String aID[] = {"",id, "", "","", "", "","","", "", "","" };
                                String s[] = this.data.get(Collections.binarySearch(this.data, aID, new GlobeDataComparator()));
                                this.orbits.add(index,  new Orbit(s[satcat], Float.parseFloat(s[ecc]), Float.parseFloat(s[apogee]),
                                                Float.parseFloat(s[perigee]), Float.parseFloat(s[inc]), Float.parseFloat(s[raan]),
                                                this.sx,this.sy,this.radius ));
                                orbits.get(index).setSelected(true);
                                this.displayedData.add(s);
                            }
                        }
                        else
                            return NULL_EVENT;
                    }
            }
        }
        return NULL_EVENT;
    }
    
    public float getSphereX()
    {
        return this.sx;
    }

    public float getSphereY()
    {
        return this.sy;
    }

    void resize()
    {
        super.resize();
        this.sx = this.sfx*width; this.sy = this.sfy*height; 
        this.hx = (int) ((float) (width / 2) - (float) (infographicWidth / 2)); this.hy = (int) ((float) (height / 2) - (float) (infographicHeight / 2));
        //this.radius = Math.min(width,height)*fradius;
        for(Orbit o: this.orbits)
            o.resize(this.sx,this.sy);  
    }

    //overall check --> "(D:[0-9]{4}-[0-9]{4})|(N:.+)|(T:(Debris-Fragmentation)|T:(Debris-Component)|T:(Debris)|T:(Humans)|T:(ISS)|T:(Suborbital))|((A:-*[0-9]+\\.[0-9]*|A:-*[0-9]+)-(-*[0-9]+\\.[0-9]*|-*[0-9]+))|((P:-*[0-9]+\\.[0-9]*|P:-*[0-9]+)-(-*[0-9]+\\.[0-9]*|-*[0-9]+))|((R:-{0,1}[0-9]+\\.[0-9]*|R:-{0,1}[0-9]+)-(-{0,1}[0-9]+\\.[0-9]*|-{0,1}[0-9]+);(-{0,1}[0-9]+\\.[0-9]*|-{0,1}[0-9]+)-(-{0,1}[0-9]+\\.[0-9]*|-{0,1}[0-9]+))|((M:-*[0-9]+\\.[0-9]*|M:-*[0-9]+)-(-*[0-9]+\\.[0-9]*|-*[0-9]+))|(O:(LLEO)|O:(LEO)|O:(MEO)|O:(HEO)|O:(GTO)|O:(GEO)|O:(VHEO)|O:(DSO)|O:(CLO))"
    //D:year>year or year --> all satellites that were launched in that year or year range
    //N:name --> all satellites with that name (not exact name)
    //T:sattelite type --> this is going to be difficult --> https://planet4589.org/space/gcat/web/intro/type.html
    //this program will use:
    //      Debris (fragmentation debris and component debris), with humans on board, ISS related, suborbital payloads,
    //A:a1-a2 --> all satellites in that apogee range
    //P:p1-p2 --> all satellites in that perigee range
    //R:a1-a2;p1-p2 --> all satellites in that apogee and that perigee range
    //M:m1-m2 --> all satellites in that mass range
    //O:orbit type --> all satellites in that orbit type (will probably have to do a random subset because there are too many   )
    
    // sets up a method by which all object data can be organized and visualized through queries by filtering based on string input using regular expressions
    void query(String input)
    {   
        String regex = "(random)"+
                        "|(D:[0-9]{4}>[0-9]{4})" +
                        "|(N:.+)"+
                        "|(T:(Debris-Fragmentation)|T:(Debris-Component)|T:(Debris)|T:(Human)|T:(ISS)|T:(Suborbital))"+
                        "|((A:-*[0-9]+\\.[0-9]*|A:-*[0-9]+)>(-*[0-9]+\\.[0-9]*|-*[0-9]+))"+
                        "|((P:-*[0-9]+\\.[0-9]*|P:-*[0-9]+)>(-*[0-9]+\\.[0-9]*|-*[0-9]+))"+
                        "|((R:-{0,1}[0-9]+\\.[0-9]*|R:-{0,1}[0-9]+)>(-{0,1}[0-9]+\\.[0-9]*|-{0,1}[0-9]+);(-{0,1}[0-9]+\\.[0-9]*|-{0,1}[0-9]+)>(-{0,1}[0-9]+\\.[0-9]*|-{0,1}[0-9]+))"+
                        "|((M:-*[0-9]+\\.[0-9]*|M:-*[0-9]+)>(-*[0-9]+\\.[0-9]*|-*[0-9]+))"+
                        "|(O:(LLEO)|O:(LEO)|O:(MEO)|O:(HEO)|O:(GTO)|O:(GEO)|O:(VHEO)|O:(DSO)|O:(CLO))";
        regex = regex.toLowerCase();
        input = input.toLowerCase();
        if(Pattern.matches(regex,input.toLowerCase()))
        {
            if(input.equalsIgnoreCase("random"))
            {
                if(updateData(".","#JCAT"))
                {
                    updateDisplayedData();
                }
            }
            else
            {
                float min,max;
                switch(input.charAt(0))
                {
                    case 'd':
                        min = Integer.parseInt(input.substring(2,6));
                        max = Integer.parseInt(input.substring(7,11));
                        if(min<=max && min>=1958 && max<=2022)
                        {
                            if(updateData(min,max,"LDate"))
                                updateDisplayedData();
                        }
                        break;
                    case 'n':
                        input = input.substring(2,input.length());
                        regex = "(";
                        for(int i = 0;i<input.length();i++)
                        {

                            regex += ""+'[' + input.charAt(i) + Character.toUpperCase(input.charAt(i)) + ']';
                        }
                        regex += ").*";
                        if(updateData(regex,"Name"))
                        {
                            updateDisplayedData();
                        }
                        break;
                    case 't':
                        input = input.substring(2,input.length());
                        if(input.equalsIgnoreCase("Debris-Fragmentation"))
                            regex = "^[Dd].*";
                        else if (input.equalsIgnoreCase("Debris-Component"))
                            regex = "^[Cc].*";
                        else if (input.equalsIgnoreCase("Debris"))
                            regex = "^[CcDd].*";
                        else if (input.equalsIgnoreCase("Human"))
                            regex = "^[PpSs][Hh].*";
                        else if (input.equalsIgnoreCase("ISS"))
                            regex = "^.{5}[IiCcDdMmVv]{1}.*";
                        else if (input.equalsIgnoreCase("Suborbital"))
                            regex = "^[Ss].*";
                        if(updateData(regex,"Type"))
                            updateDisplayedData();
                        break;
                    case 'a':
                        min = Float.parseFloat(input.substring(2,input.indexOf('>')));
                        max = Float.parseFloat(input.substring(input.indexOf('>')+1,input.length()));
                        if(min<=max)
                        {
                            if(updateData(min,max,"Apogee"))
                                updateDisplayedData();
                        }
                        break;
                    case 'p':
                        min = Float.parseFloat(input.substring(2,input.indexOf('>')));
                        max = Float.parseFloat(input.substring(input.indexOf('>')+1,input.length()));
                        if(min<=max)
                        {
                            if(updateData(min,max,"Perigee"))
                                updateDisplayedData();
                        }
                        break;
                    case 'r':
                        min = Float.parseFloat(input.substring(2,input.indexOf('>')));
                        max = Float.parseFloat(input.substring(input.indexOf('>')+1,input.indexOf(';')));
                        float min2 = Float.parseFloat(input.substring(input.indexOf(';')+1,input.indexOf('>',input.indexOf(';'))));
                        float max2 = Float.parseFloat(input.substring(input.indexOf('>',input.indexOf(';'))+1, input.length()));
                        if(min<=max && min2<max2)
                        {
                            if(updateData(min,max, min2, max2,"Apogee", "Perigee"))
                                updateDisplayedData();
                        }
                        break;
                    case 'm':
                        min = Float.parseFloat(input.substring(2,input.indexOf('>')));
                        max = Float.parseFloat(input.substring(input.indexOf('>')+1,input.length()));
                        if(min<=max)
                        {
                            if(updateData(min,max,"Mass"))
                                updateDisplayedData();
                        }
                        break;
                    case 'o':
                        input = input.substring(2,input.length());
                        if(input.equalsIgnoreCase("LLEO"))
                            regex = "^([Ll][Ll][Ee][Oo]).*";
                        else if (input.equalsIgnoreCase("LEO"))
                            regex = "^([Ll][Ee][Oo]).*";
                        else if (input.equalsIgnoreCase("MEO"))
                            regex = "^([Mm][Ee][Oo]).*";
                        else if (input.equalsIgnoreCase("HEO"))
                            regex = "^([Hh][Ee][Oo]).*";
                        else if (input.equalsIgnoreCase("GTO"))
                            regex = "^([Gg][Tt][Oo]).*";
                        else if (input.equalsIgnoreCase("GEO"))
                            regex = "^([Gg][Ee][Oo]).*";
                        else if (input.equalsIgnoreCase("VHEO"))
                            regex = "^([Vv][Hh][Ee][Oo]).*";
                        else if (input.equalsIgnoreCase("DSO"))
                            regex = "^([Dd][Ss][Oo]).*";
                        else if (input.equalsIgnoreCase("CLO"))
                            regex = "^([Cc][Ll][Oo]).*";
                        if(updateData(regex,"OpOrbit"))
                            updateDisplayedData();
                        break;
                }
            }
        }
    }

    boolean updateData(float min, float max, String columnName)
    {
        boolean hasData = true;
        for(TableRow row:activeSatellites.rows())
        {
            String value = columnName.equals("LDate")? row.getString(columnName).substring(0,4):row.getString(columnName);
            if(Float.parseFloat(value)<=max && Float.parseFloat(value)>=min)
            {
                if(hasData && this.data != null)
                {
                    this.data.clear();
                }
                hasData = false;
                String tempArray[] = {row.getString("#JCAT"),row.getString("Satcat"), row.getString("Type"), row.getString("Name"),
                                    row.getString("LDate"), row.getString("Mass"), row.getString("Perigee"),row.getString("Apogee"),
                                    row.getString("Inc"), row.getString("OpOrbit"), row.getString("raan"),row.getString("ecc") };
                this.data.add(tempArray);
            }
        }
        if(!hasData)
            ((OrbitMenu)screenWidgets.get(5)).addData(this.data);
        return !hasData;
    }

    boolean updateData(float min1, float max1, float min2, float max2, String columnName1, String columnName2)
    {
        boolean hasData = true;
        for(TableRow row:activeSatellites.rows())
        {
            String value1 = row.getString(columnName1);
            String value2 = row.getString(columnName2);
            if(Float.parseFloat(value1)<=max1 && Float.parseFloat(value1)>=min1 && Float.parseFloat(value2)<=max2 && Float.parseFloat(value2)>=min2)
            {
                if(hasData && this.data != null)
                {
                    this.data.clear();
                }
                hasData = false;
                String tempArray[] = {row.getString("#JCAT"),row.getString("Satcat"), row.getString("Type"), row.getString("Name"),
                                    row.getString("LDate"), row.getString("Mass"), row.getString("Perigee"),row.getString("Apogee"),
                                    row.getString("Inc"), row.getString("OpOrbit"), row.getString("raan"),row.getString("ecc") };
                this.data.add(tempArray);
            }
        }
        if(!hasData)
            ((OrbitMenu)screenWidgets.get(6)).addData(this.data);
        return !hasData;
    }

    boolean updateData(String regex, String columnName)
    {
        boolean hasData = true;
        for(TableRow row: activeSatellites.matchRows(regex,columnName))
        {
            if(hasData && this.data != null)
            {
                this.data.clear();
            }
            hasData = false;
            String tempArray[] = {row.getString("#JCAT"),row.getString("Satcat"), row.getString("Type"), row.getString("Name"),
                                    row.getString("LDate"), row.getString("Mass"), row.getString("Perigee"),row.getString("Apogee"),
                                    row.getString("Inc"), row.getString("OpOrbit"), row.getString("raan"),row.getString("ecc") };
            this.data.add(tempArray);
        }
        if(!hasData)
            ((OrbitMenu)screenWidgets.get(5)).addData(this.data);
        return !hasData;
    }

    void updateDisplayedData()
    {
        if(this.orbits != null)
        {
            this.orbits.clear();
        }
        if(this.displayedData != null)
        {
            this.displayedData.clear();
        }
            
        if(this.data.size() < maxOrbitsDisplayed)
        {
            this.displayedData = (ArrayList<String[]>)this.data.clone();
        }
        else
        {
            Collections.shuffle(this.data);
            int count =0;
            for(String s[]: this.data)
            { //used to be a try an catch here with the orbit constructor
                if(count>= maxOrbitsDisplayed)
                    break;
                this.displayedData.add(s);
                count++;
            }
        }
        for(String s[]: this.displayedData)
        {
            
            this.orbits.add(new Orbit(s[satcat], Float.parseFloat(s[ecc]), Float.parseFloat(s[apogee]),
                            Float.parseFloat(s[perigee]), Float.parseFloat(s[inc]), Float.parseFloat(s[raan]),
                            this.sx,this.sy,this.radius ));
        }
        Collections.sort(this.orbits, new OrbitComparator());   
        Collections.sort(this.data, new GlobeDataComparator());
    }
}