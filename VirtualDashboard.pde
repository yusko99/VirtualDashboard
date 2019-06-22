PImage img, electrick, oil, water, parking; // background image
float saX1, saY1, saX2, saY2; // speedometer needle's parameters
float raX1, raY1, raX2, raY2;// RPM arrow's parameters
float waX1, waY1, waX2, waY2;// water temps' parameters
float taX1, taY1, taX2, taY2;// turbo's parameters
float aaX1, aaY1, aaX2, aaY2;// air temp's parameters
float raStartDegree, saStartDegree, taStartDegree, waStartDegree, aaStartDegree ; // start positons of needles
float arrowLength;   // rpm and speed needle's length
float smallArrowLength;  // length of arrows of small controls 
boolean isOnGear, isStarted;


void setup(){
  size(640, 480);
  img= loadImage("dash3.png");
  
  // dashboard warnings images
  electrick = loadImage("electrickWarning.png");
  oil = loadImage("oilWarning.png");
  water = loadImage("waterWarning.png");
  parking = loadImage("parkingWarning.png");
  
  isOnGear= false;
  isStarted= false;
  
  // coordinates for the needles
  raX1= 185;      taX1 =320;
  raY1= 320;      taY1 =215;
  
  saX1 = 455;      waX1 = 54;      aaX1 = 582;
  saY1 = 320;      waY1 = 225;     aaY1 = 225;
  
  //starting position of each needle
  raStartDegree = 90;
  saStartDegree = 90;
  taStartDegree = 180;
  waStartDegree = 90;
  aaStartDegree = 90;
  
  //needles' length
  arrowLength = 80;
  smallArrowLength = 25;
}

void draw(){
  //setting the background and text's properties
  background(img);
  textSize(15);
  fill(#FF0000);
 
 
  
  //warnings when the engine is OFF
  if(isStarted == false) {
    image(electrick, 0, 350);
     text("press E to start the engine", 40,40);
  }
  if(isOnGear == false) image(parking, 550,410);
  
  // appear when the engine is on
  if(raStartDegree >130){
    text("press S to stop the engine", 40,70);
   if(isOnGear == false) text("press P to put on a gear and drive", 40, 90);
   
  }
  
  
  
 
 // pressing the gas pedal UP and increasing the RPM
 if(keyPressed== true && keyCode == UP && raStartDegree<=360 && isStarted== true){
  
 
   // changing RPM
   raStartDegree+=1.5; 
   
   if(taStartDegree <=360){
   taStartDegree+=5;
   }
   

   
   // driving the car
   if(isOnGear== true){
     
     //changing gears on 6500 RPM
     if(raStartDegree > 285 && saStartDegree<300){
     raStartDegree= 180;
     }
     
     
     //1st gear
     if(saStartDegree >=90 && saStartDegree<=120){
        saStartDegree+=1.6;
             }
     //2nd gear
     if(saStartDegree >=120 && saStartDegree<=180){
       saStartDegree+=1.25;
      
     }
     //3rd gear
     if(saStartDegree >=180 && saStartDegree<=240){
       
       saStartDegree+=1;
     }
     //4th gear
     if(saStartDegree >=240 && saStartDegree<=360){
       
       saStartDegree+=0.8;
     }
 //showing the gear on the board  
   if(saStartDegree <=225) {
     textSize(36);
     text("D1", 560,430);
   }
   if(saStartDegree >=225 && saStartDegree <= 280) {
     textSize(36);
     text("D2", 560,430);
   }
   if(saStartDegree >=280 || saStartDegree==360) {
     textSize(36);
     text("D3", 560,430);
   }
   
 }
   
 }
 // releasing the gas pedal
  if(keyPressed == false && raStartDegree >135){
    raStartDegree-=2;
    
    
   
 
    }
    
  if(keyPressed == false && saStartDegree>92){
    saStartDegree-=2;
    
     if(saStartDegree <=225) {
     textSize(36);
     text("D1", 560,430);
   }
   if(saStartDegree >=225 && saStartDegree <= 280) {
     textSize(36);
     text("D2", 560,430);
   }
   if(saStartDegree >=280 || saStartDegree==360) {
     textSize(36);
     text("D3", 560,430);
   }
  }
 
  if(keyPressed == false && raStartDegree >=135){
   if(taStartDegree >=180) taStartDegree-=5;
     if(raStartDegree <=300 && waStartDegree >=135) waStartDegree-=0.1; 
  }
  
  // warning when RPM are in critical
  if(raStartDegree>=300){
    image(water,0, 392);
    image(oil, 0, 440);
  }
  
  
  
 // increasing water's temp in critical RPM
 if(raStartDegree >=300 && waStartDegree<=360) {
   waStartDegree+=0.24; 
   
 }
 // noramal water temp increasing
if (raStartDegree> 130 && raStartDegree<=300 && waStartDegree <=210) waStartDegree+=0.1;

 
 // air temps leveling
if(raStartDegree >130 && aaStartDegree <= 170) aaStartDegree+=0.1;
  
  createRPMNeedle();
  createSpeedometerNeedle();
  createTurboNeedle();
  createWaterNeedle();
  createAirNeedle();
}


void createRPMNeedle(){
  raX2 = raX1 + arrowLength * cos(radians(raStartDegree));
  raY2 = raY1 + arrowLength * sin(radians(raStartDegree));
  
  strokeWeight(3);
  stroke(#FF0000);
  ellipse(raX1, raY1, 10,10);
  fill(#FF0000);
  line(raX1, raY1, raX2, raY2);
}

void createSpeedometerNeedle(){
  saX2 = saX1 + arrowLength * cos(radians(saStartDegree));
  saY2 = saY1 + arrowLength * sin(radians(saStartDegree));
  
  strokeWeight(3);
  stroke(#FF0000);
  ellipse(saX1, saY1, 10,10);
  fill(#FF0000);
  line(saX1, saY1, saX2, saY2);
}

void createWaterNeedle(){
   waX2 = waX1 + smallArrowLength * cos(radians(waStartDegree));
   waY2 = waY1 + smallArrowLength * sin(radians(waStartDegree));
  
  strokeWeight(3);
  stroke(#FF0000);
  ellipse(waX1, waY1, 5,5);
  fill(#FF0000);
  line(waX1, waY1, waX2, waY2);
}

void createTurboNeedle(){
  taX2 = taX1 + smallArrowLength * cos(radians(taStartDegree));
  taY2 = taY1 + smallArrowLength * sin(radians(taStartDegree));
  
  strokeWeight(3);
  stroke(#FF0000);
  ellipse(taX1, taY1, 5,5);
  fill(#FF0000);
  line(taX1, taY1, taX2, taY2);
}

void createAirNeedle(){
   
   aaX2 = aaX1 + smallArrowLength * cos(radians(aaStartDegree));
   aaY2 = aaY1 + smallArrowLength * sin(radians(aaStartDegree));
  
  strokeWeight(3);
  stroke(#FF0000);
  ellipse(aaX1, aaY1, 5,5);
  fill(#FF0000);
  line(aaX1, aaY1, aaX2, aaY2);
}

void keyTyped(){
  // starting the engine
if(key == 'E' || key == 'e'){
  isStarted= true;
  raStartDegree =135;
  
   if(keyPressed== true && keyCode == UP && raStartDegree<=360) raStartDegree+=3;
  if(keyPressed == false && raStartDegree >135) raStartDegree-=2;
}

// putting engine into gear
if (key== 'P' || key=='p') isOnGear = true;

//stopping the engine
if(key == 'S' || key =='s') setup();
}
