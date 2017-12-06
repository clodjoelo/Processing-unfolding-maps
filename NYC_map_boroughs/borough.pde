
class Borough{
  String name;
  float latCenter;
  float lonCenter;
  String acry;
  int index;
  color c;
  ArrayList<PVector> pixelsInside  = new ArrayList<PVector>();
  ArrayList<PVector>[] boundsCoOrds;
  ArrayList<Polygon>[] pixelFinder;
  ScreenPosition boroughOutline;
  int amountOfShapes;
  float shapeId = -1;
  int countOfShapes = 0;

  Borough(String _name, float _lat, float _lon, String _acry,int _index,color _c,int _aOS){
      name = _name;
      latCenter = _lat;
      lonCenter = _lon;
      acry = _acry;
      index = _index;
      c = _c;
      amountOfShapes = _aOS;
      setArrays();
  }
  
 /*-------array of arraylists of lat lon co-ordinates and polygons representing borough outlines----------*/
 /*-------use array of arraylist because different land masses within boroughs e.g -islands----------*/
 
public void setArrays(){
    boundsCoOrds = (ArrayList<PVector>[])new ArrayList[amountOfShapes];
    pixelFinder = (ArrayList<Polygon>[])new ArrayList[amountOfShapes];
  }
  
 /*-------- this identifies the new landmass outlines within the borough-------*/
  /*------- it's identified by the the shapeid in borbounds.csv that we are iterating over here----------*/
  /*------- when it changes we know its a new landmass so start a new arraylist----------*/
  void setBoundsCoOrds(float thisId, float la, float lo){
    if(shapeId!= thisId){
      boundsCoOrds[countOfShapes] = new ArrayList<PVector>();
      countOfShapes++;  
    }
       boundsCoOrds[countOfShapes-1].add(new PVector(la,lo));
       shapeId = thisId;
   }
   
   
 /*-------- convert all lat long data to pixels (x y) data-------*/ 
 /*-------- then we convert it to polygon data -------*/  
   void coOrdsToPixels(){  
   PVector boundary = new PVector(0,0);
   for(int i = 0; i< boundsCoOrds.length; i++){
     pixelFinder[i] = new ArrayList<Polygon>();
    final Polygon polygon = new Polygon();
     for(int j = 0; j< boundsCoOrds[i].size(); j++){
        boundary = boundsCoOrds[i].get(j);
        de.fhpotsdam.unfolding.geo.Location boundaryPoint = new de.fhpotsdam.unfolding.geo.Location(boundary.x,boundary.y);
        SimplePointMarker boundaryMarker = new SimplePointMarker(boundaryPoint);
        boroughOutline = boundaryMarker.getScreenPosition(map1);
        polygon.addPoint(round(boroughOutline.x),round(boroughOutline.y)); 
    }
    pixelFinder[i].add(polygon);
   }    
 }
   
   /*-------- iterate over all the pixels on the screen-------*/ 
   void setPixels(){
     loadPixels();
     for(int i = 0; i< pixels.length; i++){
          float yPix = i/width;
          float xPix = i% width;
          findPixelsInside(round(xPix),round(yPix));
     }
   }
   
  /*------ and see if they are inside the bounds of of our borough polygons-----*/
  /*------ each pixel that is inside we store in a new arraylist of P Vector-----*/
    void findPixelsInside(int x, int y){
     boolean found = false;
     for(int j = 0; j< pixelFinder.length; j++){
       for(int k = 0; k< pixelFinder[j].size(); k++){
         Polygon p = pixelFinder[j].get(k);
         if(p.contains(x,y)){
             float xPos = float(x);
             float yPos = float(y);
             PVector v = new PVector(xPos,yPos);
             pixelsInside.add(v);
             found = true;
             break;
      } 
   }
   if(found){
        break;
     }
   }  
    }
    
    public boolean mouseTest(int x, int y){
    boolean found = false;
     for(int j = 0; j< pixelFinder.length; j++){
       for(int k = 0; k< pixelFinder[j].size(); k++){
         Polygon p = pixelFinder[j].get(k);
         if(p.contains(x,y)){
             float xPos = float(x);
             float yPos = float(y);
             PVector v = new PVector(xPos,yPos);
             pixelsInside.add(v);
             found = true;
             break;
      } 
   }
   if(found){
        break;
     }
   }
      
    }
 
  public String getName(){
      return name;
  }
  
   public String getAcry(){
      return acry;
  }
  
  public color getColor(){
    return c;
  }
  
  
  public int getIndex(){
      return index;
  }
  
  public void shadeIn(){
    loadPixels();
    for(PVector p : pixelsInside){
      int x = round(p.x);
      int y = round(p.y);
      int loc =x+y*width;
      pixels[loc] = color(c);
    }
    updatePixels();
  }
  
  void displayMouse(){
    fill(0,100);
    String detail = "The mouse is inside "+name;
    float wdth = textWidth(detail);
    noStroke();
    rect(mouseX,mouseY-10,wdth,12);
    fill(255);
    text("The mouse is inside "+name,mouseX,mouseY);         
  }
  

}
