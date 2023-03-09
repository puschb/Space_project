//Main
import java.util.*;
import java.util.regex.*;
import peasy.*;
import java.net.*;
import processing.sound.*;
import java.awt.*;

HomeScreen homeScreen;
CountriesScreen countriesScreen;
AltitudeScreen altitudeScreen;
GlobeScreen globeScreen;
TimeScreen timeScreen;
GraphScreen graphScreen;
Screen currentScreen;
AIScreen aiScreen;
Table gcat;
Table orgs;
Table activeSatellites;
float currentWidth, currentHeight;
PImage sunIm, jupiterIm, earthIm, marsIm, mercuryIm, neptuneIm, saturnIm, uranusIm, venusIm, infographic;
PeasyCam cam;
SoundFile audio;

void setup()
{
    size(1000,800, P3D);
    smooth();
    surface.setResizable(true);
    background(234,152,200);
    currentWidth = width;
    currentHeight = height;
    //create table for each data set
    gcat = loadTable("Data/gcat.tsv", "header, tsv");
    orgs = loadTable("Data/orgs.tsv", "header, tsv");
    activeSatellites = loadTable("Data/active-satellites.tsv", "header, tsv");
    //create font
    PFont myFont = createFont("Georgia", 100, true);
    textFont(myFont);
    //add planet images
    sunIm =  loadImage("Images/sun.jpeg");
    earthIm = loadImage("Images/earthmap1k.jpg");
    jupiterIm = loadImage("Images/jupitermap.jpg");
    marsIm = loadImage("Images/mars_1k_color.jpg");
    mercuryIm = loadImage("Images/mercurymap.jpg");
    neptuneIm = loadImage("Images/neptunemap.jpg");
    saturnIm = loadImage("Images/saturnmap.jpg");
    uranusIm = loadImage("Images/uranusmap.jpg");
    venusIm = loadImage("Images/venusmap.jpg");
    infographic = loadImage("Images/Infographic.png");
    //camera for 3D images
    cam = new PeasyCam(this,width/2,height/2,0,600);
    //cam.setMinimumDistance(600);
    cam.setMaximumDistance(7000);    
    cam.setActive(false);
    //screen objects
    homeScreen = new HomeScreen();
    countriesScreen = new CountriesScreen();
    altitudeScreen = new AltitudeScreen();
    globeScreen = new GlobeScreen();
    timeScreen = new TimeScreen();
    graphScreen = new GraphScreen();
    aiScreen = new AIScreen();
    currentScreen = homeScreen;
    //audio in background
    audio = new SoundFile(this, "InterstellarJourney.wav");
    audio.loop();
}

//funtion to resize each screen
//resize all screens --> update this when a new screen is added
void resize()
{
    cam = new PeasyCam(this,width/2,height/2,0,600);
    cam.setMaximumDistance(7000);
    System.gc();
    cam.reset();
    currentWidth = width;
    currentHeight = height;
    homeScreen.resize();
    globeScreen.resize();
    altitudeScreen.resize();
    countriesScreen.resize();
    timeScreen.resize();
    graphScreen.resize();
    aiScreen.resize();
}

void draw()
{
    cam.beginHUD();
    if(currentWidth != width || currentHeight != height)
    {
        noLoop();
        background(currentScreen.screenColour);
        resize();
        loop();
    }
    else
    {
        currentScreen.draw();
    }
    cam.endHUD();
}

void mouseMoved(MouseEvent e)
{
    currentScreen.getEvent(e);
}

//function to switch screens when mouse is released
void mouseReleased(MouseEvent e) 
{
  switch(currentScreen.getEvent(e))
  {
    case HOME_SCREEN:
        cam.setActive(false);
        cam.reset();
        currentScreen = homeScreen;
        break;
    case COUNTRY_SCREEN:
        cam.setActive(false);
        currentScreen = countriesScreen;
        break;
    case ALTITUDE_SCREEN:
        cam.setActive(false);
        currentScreen = altitudeScreen; 
        break;
    case GLOBE_SCREEN:
        cam.setActive(true);
        cam.reset();
        currentScreen = globeScreen; 
        break;
    case TIME_SCREEN:
        cam.setActive(false);
        currentScreen = timeScreen;
        break;
    case GRAPH_SCREEN:
        cam.setActive(false);
        cam.reset();
        currentScreen = graphScreen;
        break;
    case AI_SCREEN:
        cam.setActive(false);
        cam.reset();
        currentScreen = aiScreen;
        break;
    
  }
}

void mouseDragged(MouseEvent e)
{
    currentScreen.getEvent(e);
}

void keyPressed(KeyEvent e) 
{
    currentScreen.getEvent(e);
}







