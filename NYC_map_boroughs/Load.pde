
class Load{  

 
void setBoroughs(){
 Table tableBurough = loadTable("burough.csv");
  for(int y = 0; y <boroughs.length;y++){
     String name = tableBurough.getString(y, 0);
     float lat = tableBurough.getFloat(y, 1);
     float lon = tableBurough.getFloat(y, 2);
     String acry = tableBurough.getString(y, 3);
     String c = tableBurough.getString(y, 4);
     color b = unhex("FF"+c);
     int shapes = tableBurough.getInt(y, 5);
     boroughs[y] = new Borough(name,lat,lon,acry,y,b,shapes);
  }
  }
  
  
  void createData(){
   Table table = loadTable("borbounds.csv", "header");
    int [] loadOrder = new int[5];
    
    
/*-------array to re-order id data from shape file (borbounds.csv) so it matches---*/
/*-------our preset borough id order--------*/
    
    loadOrder [0] = 4;
    loadOrder [1] = 3;
    loadOrder [2] = 0;
    loadOrder [3] = 1;
    loadOrder [4] = 2;
    
    int current=0;
     
    Borough b = boroughs[4];
    for(int i = 0; i<table.getRowCount();i++){
     TableRow row = table.getRow(i);
     float shapeId = row.getFloat("shapeid");
     float lat = row.getFloat("y");
     float lon = row.getFloat("x");
     if(current!=int(row.getInt("shapeid"))){
        current=int(row.getInt("shapeid"));
        b = boroughs[loadOrder[current]];
     }
      b.setBoundsCoOrds(shapeId,lat,lon);
      }
      
}

  
}
