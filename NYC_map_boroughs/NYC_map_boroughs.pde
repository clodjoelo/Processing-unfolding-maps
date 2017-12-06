import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.utils.*; 
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.marker.*;

import java.awt.Polygon;

Load loader = new Load();

Borough[] boroughs = new Borough[5];


UnfoldingMap map1;
de.fhpotsdam.unfolding.geo.Location startLocation = new de.fhpotsdam.unfolding.geo.Location(40.7003,-74.0275);


 
void setup(){
  size(1200,720);
  String mbTilesString1 = sketchPath("data/NY.mbtiles");
  float zoomIn= 10.8;
  
  map1 = new UnfoldingMap(this,new MBTilesMapProvider(mbTilesString1));
  map1.zoomTo(zoomIn);
  map1.panTo(startLocation);
  
  /*-----create borough objects----*/
  loader.setBoroughs();
  loader.createData();
  
  /*-----set the data----*/
   for(Borough br : boroughs){
        br.coOrdsToPixels();
        br.setPixels();
      }
    
}

 void draw(){
   map1.draw();
   for(Borough b : boroughs){
       b.shadeIn();
   }
  for(Borough b : boroughs){
     if(b.mouseTest(mouseX,mouseY)){
       b.displayMouse();
     }
   }
  }
  








