//Class created by L. Chow
//Superclass for the screens that will be used
class Screen
{
    ArrayList<Widget> screenWidgets;
    ArrayList<Graph> screenGraphs;
    color screenColour;
    
   public Screen()
   {
    screenWidgets = new ArrayList<Widget>();
    screenGraphs = new ArrayList<Graph>();
   }

   //function to draw widgets and graphs on the screen
   void draw()
   {
    for(Widget w: screenWidgets)
        w.draw();
    for(Graph g: screenGraphs)
        g.draw();
   }

    //function to get mouse event
   int getEvent(MouseEvent e)
   {
       int event;
       for(Widget w: screenWidgets)
       {
           event = w.getEvent(e);
           if(event != NULL_EVENT) return event;
       }
       return NULL_EVENT;
   }

   //function to get key event 
   int getEvent(KeyEvent e)
   {
       int event;
       for(Widget w: screenWidgets)
       {
           event = w.getEvent(e);
           if(event != NULL_EVENT) return event;
       }
       return NULL_EVENT;
   }
   
   //function to resize the graphs and widgets
   void resize()
   {
       for(Graph g: screenGraphs)
            g.resize();
       for(Widget w: screenWidgets)
            w.resize();
   }
}