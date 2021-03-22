//import gifAnimation.*;

PShape floor;
PShape wall1;
PShape wall2;
PShape wall3;
PShape wall4;
int px;
int py;
int pz;
int lr;
int lg;
int lb;
boolean helpScreen;

//GifMaker gifFile;

void setup(){
  size(1000, 800, P3D);
  floor = createShape();
  floor.beginShape();
  floor.vertex(0, height, 0);
  floor.vertex(width, height, 0);
  floor.vertex(width, height, -500);
  floor.vertex(0, height, -500);
  floor.endShape(CLOSE);

  wall1 = createShape();
  wall1.beginShape();
  wall1.fill(color(100, 100, 100));
  wall1.vertex(0, height, -500);
  wall1.vertex(0, height/2, -500);
  wall1.vertex(width, height/2, -500);
  wall1.vertex(width, height, -500);
  wall1.endShape();
  
  wall2 = createShape();
  wall2.beginShape();
  wall2.vertex(0, height, 0);
  wall2.vertex(0, height/2, 0);
  wall2.vertex(0, height/2, -500);
  wall2.vertex(0, height, -500);
  wall2.endShape(0);
  
  wall3 = createShape();
  wall3.beginShape();
  wall3.vertex(width, height, -500);
  wall3.vertex(width, height/2, -500);
  wall3.vertex(width, height/2, 0);
  wall3.vertex(width, height, 0);
  wall3.endShape();
    
  px = 0;
  py = 0;
  pz = 0;
  
  lr = 0;
  lg = 0;
  lb = 0;

  helpScreen = true;
  
  //gifFile = new GifMaker(this, "animacion.gif");
  //count = 0;
}

void draw(){
  
  if(helpScreen){
    background(0);
    pushMatrix();
    translate(width/2, height/2);
    textAlign(CENTER);
    textSize(16);
    text("USO" + "\n" + "Presiona <w> y <s> para mover la cámara en el eje z" 
         + "\n" + "Presiona <a> y <d> para mover la cámara en el eje x" + "\n"
         + "Presiona <flecha arriba> y <flecha abajo> para mover la cámara en el eje y"
         + "\n" + "Presiona <r> <g> o <b> para aumentar el valor de las componentes de color"
         + "\n" + "de la luz ambiental aplicada en los objetos" + "\n" 
         + "Clic en la pantalla para poner las componentes de color de la luz ambiental a 0"
         + "\n" + "Presiona <ENTER> para empezar",0 ,-160);
    popMatrix();
  }else{
    background(0);
    camera(width/2.0 - px, height/2.0 - py, (height/2.0) / tan(PI*30.0 / 180.0)  - pz, width/2.0, height/2.0, 0, 0, 1, 0);
    
    lights();
     
    directionalLight(0, 0, 255, 0, 1, 0);
    shape(floor);
      
    lights();
    shape(wall1);
      
    lights();
    directionalLight(0, 255, 0, -1, 0, 0);
    shape(wall2);
      
    lights();
    directionalLight(255, 0, 0, 1, 0, 0);
    shape(wall3);
    
    lights();
    pointLight(200, 200, 200, px, py, pz);
    ambientLight(lr, lg, lb);
    createCustomShape(width/2, height - 100, -250, 50, true, loadImage("img/gold.jpg"));
    createCustomShape(width/2 - 100, height - 100, -250, 60, false, loadImage("img/silver.jpg")); 
    createCustomShape(width/2 + 100, height - 100, -250, 60, false, loadImage("img/copper.png")); 
  }
  
  //gifFile.addFrame();

}

void createCustomShape(int posx, int posy, int posz, int size, boolean sphere, PImage texture){
  PShape customShape;
  createShape();
  customShape = createShape(sphere ? SPHERE : BOX, size);
  if(sphere){
    sphereDetail(50);
  }
  customShape.setStroke(255);
  customShape.setTexture(texture);
  endShape();
  
  pushMatrix();
  translate(posx, posy, posz);
  shape(customShape);
  popMatrix();
}

void keyPressed() {

  switch(key){
    case 'w':
      pz += 10;
      break;
    case 's':
      pz -= 10;
      break;
    case 'a':
      px -= 10;
      break;
    case 'd':
      px += 10;
      break;
    case 'r':
      if(lr < 255) lr += 5;
      break;
    case 'b':
      if(lb < 255) lb += 5;
      break;
    case 'g':
      if(lg < 255) lg += 5;
      break;
    /*  
    case 'x':
      gifFile.finish();
      break;
    */
    default:
      break;
  }
  
  if(keyCode == DOWN){
    py -= 10;
  }

  if(keyCode == UP){
    py += 10;
  }
  
  if(keyCode == ENTER){
    helpScreen = false;
  }
}

void mousePressed(){
  lr = 0;
  lg = 0;
  lb = 0;
}
