//Class created by G. Mullen
// modified by B. Pusch to add functionality
//Object of text box
//Subclass of widget class
public class TextBox extends Widget{
    private final int RECT_RADII = 8;
    String input;
    boolean selected;
    String type;
    float textSize;
    String inputDisplayed;

    public TextBox(float fx, float fy, float fwidth, float fheight, int event, String type) 
    {
        super(fx, fy, fwidth, fheight, event);
        this.input = "";
        selected = false;
        this.type = type;
        this.textSize = wHeight*.7;
        this.inputDisplayed = "";
    }

    public void draw() 
    {
        pushStyle();
        stroke(0);
        fill(255);
        rect(x, y, wWidth, wHeight, RECT_RADII);
        textSize(this.textSize);
        textAlign(LEFT,CENTER);
        fill(0);
        text(this.inputDisplayed, this.x, this.y+wHeight/2);
        popStyle();
    }

    public void updateText(char x) 
    {
        this.input += x;
        textSize(this.textSize);
        if(textWidth(this.input) > wWidth)
        {  
            inputDisplayed += x;
            for(int i = 1; textWidth(this.inputDisplayed)>wWidth;i++)
                this.inputDisplayed = this.inputDisplayed.substring(i,this.inputDisplayed.length());
        }
        else
            inputDisplayed = this.input;
    }

    // backspace key
    public void rmText() 
    {
        textSize(this.textSize);
        if(input.length()>0)
            input = input.substring(0, input.length() - 1);
        if(textWidth(this.input) > wWidth)
        {
            inputDisplayed = this.input.substring(this.input.length()-this.inputDisplayed.length(),this.input.length());
            for(int i =1; textWidth(inputDisplayed) > wWidth;i++)
                inputDisplayed = this.input.substring(i,this.input.length());
        }
        else
            inputDisplayed = this.input;
    }

    public int getEvent(MouseEvent e) 
    {
        if(e.getAction() == MouseEvent.RELEASE)
        {
            if (mouseX >= x && mouseX <= x + wWidth && mouseY >= y && mouseY <= y+wHeight) 
            {
                selected = true;
                return event;
            }
            else selected = false;
        }  
        return NULL_EVENT;
    }

    // get keypressed event
    public int getEvent(KeyEvent e) 
    {
        if (keyPressed) 
        {
            if(this.selected)
            {
                if(this.type.equalsIgnoreCase("Numbers") && (Character.isDigit(key) || (key == '.' && this.input.indexOf('.') == -1) || (this.input.length() == 0 && key ==  '-')))
                    this.updateText(key);
                else if(this.type.equalsIgnoreCase("Alphanumeric") && (Character.isDigit(key) || Character.isLetter(key) || key == ':' || key == '-' || key == '>' || key == '.'||key==';'))
                    this.updateText(key);
                else if(keyCode == BACKSPACE)
                    this.rmText();
                return this.event;
               }
            return NULL_EVENT;
           }        
        return NULL_EVENT;
    }

    public String getString() 
    {
        return this.input;
    }

    void resize()
    {
        super.resize();
        this.textSize = this.wHeight*.7;
    }
}
