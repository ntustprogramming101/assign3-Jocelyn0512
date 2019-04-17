final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

float soilSize = 80;
float imgSize = 80;
float grassHeight = 15;
float hogSpeed = 80/16;
float hogX = soilSize*4;
float hogY = soilSize;
int lifes =2;

boolean downPressed, downPressed2, rightPressed, leftPressed, idle, right, left;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24,groundhogIdle, groundhogDown, groundhogLeft, groundhogRight, life;
PImage soilImg0, soilImg1, soilImg2, soilImg3, soilImg4, soilImg5;
PImage stone1, stone2;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  life = loadImage("img/life.png");
   
  soilImg0 = loadImage("img/soil0.png");
  soilImg1 = loadImage("img/soil1.png");
  soilImg2 = loadImage("img/soil2.png");
  soilImg3 = loadImage("img/soil3.png");
  soilImg4 = loadImage("img/soil4.png");
  soilImg5 = loadImage("img/soil5.png");
  
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  playerHealth =2;
  
}
  
void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}
 
		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
    rect(0, (240-hogY)-grassHeight, width, GRASS_HEIGHT);
    
    
		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		int limit = 0;

    for(int y = 160+80; y < 2160; y+=80){
     for(int x = 0; x < width; x+=80){
      if(limit < 320)
        image(soilImg0, x, y-hogY);
      else if(limit >= 320 && limit < 640)
       image(soilImg1,x,y-hogY);
      else if(limit >= 640 && limit < 960)
       image(soilImg2,x,y-hogY);
      else if(limit >= 960 && limit < 1280)
       image(soilImg3,x,y-hogY);
      else if(limit >= 1280 && limit < 1440)
       image(soilImg4,x,y-hogY);
      else if(limit >= 1440 && limit < 1600)
       image(soilImg4,x,y-hogY);
      else if(limit >= 1600 && limit <= 2160)
       image(soilImg5,x,y-hogY);
     }
     
     limit+= 80;
    }
    
        
    //stone
    //pattern1
    int stoneX1 = 0;
    for(int y = 240; y < 880;  y = y+80){
      image(stone1, stoneX1, y-hogY);
      stoneX1+=80;
    }
    
    //pattern2
    int index = 0;
    for(int y = 880; y < 1520; y += 80){
     int c = index / 80;
     if((c == 0) || (c ==3)){
      image(stone1,80, y-hogY);
      image(stone1,160, y-hogY);
      image(stone1,400, y-hogY);
      image(stone1,480, y-hogY);
     }
     else if((c == 1) || (c ==2)){
      image(stone1,0, y-hogY);
      image(stone1,240, y-hogY);
      image(stone1,320, y-hogY);
      image(stone1,560, y-hogY);
     }
    
     if(c == 3)
      index = 0;
     else
      index += 80;
    }
    
    //pattern3
    int x3=0;
    for(int y = 1520; y <= 2080; y += 80){
     int c = x3 / 80;
     if(c == 0){
      image(stone1,80, y-hogY);
      image(stone1,160, y-hogY);
      image(stone1,320, y-hogY);
      image(stone1,400, y-hogY);
      image(stone1,560, y-hogY);
      image(stone2,160, y-hogY);
      image(stone2,400, y-hogY);
     }
     else if(c == 1){
      image(stone1,0, y-hogY);
      image(stone1,80, y-hogY);
      image(stone1,240, y-hogY);
      image(stone1,320, y-hogY);
      image(stone1,480, y-hogY);
      image(stone1,560, y-hogY);
      image(stone2,80, y-hogY);
      image(stone2,320, y-hogY);
      image(stone2,560, y-hogY);
     }
     else if(c == 2){
      image(stone1,0, y-hogY);
      image(stone1,160, y-hogY);
      image(stone1,240, y-hogY);
      image(stone1,400, y-hogY);
      image(stone1,480, y-hogY);
      image(stone2,0, y-hogY);
      image(stone2,240, y-hogY);
      image(stone2,480, y-hogY);
     }
    
     if(c == 2){
      x3 = 0;
     }
     else{
      x3 += 80;
     }
    }
     
      
  		// Player
      if(idle){
        image(groundhogIdle, hogX, 80);
      }
         idle=true;
      if(right){
        image(groundhogRight, hogX, 80);
      }
         
      if(left){
        image(groundhogLeft, hogX, 80);
      }
    
      
        if(downPressed){
          idle=false;
          leftPressed=false;
          rightPressed=false;
          downPressed2=false;
          hogY += hogSpeed;
          image(groundhogDown, hogX, 80);
         }
      
      if(hogY + imgSize >= 2080){
        hogY = 2000;
        idle=true;
        downPressed=false;
      }  
      for(int i=1; i<=24; i++){
      if(hogY == soilSize*i){
        downPressed=false;
      } 
      }
      
      
              
      if(leftPressed){
         idle=false;
         right=false;
         rightPressed=false;
         downPressed=false;
         hogX -= hogSpeed;
         image(groundhogLeft, hogX, hogY);
         
       }    
        if(hogX <= 0){ 
         leftPressed=false;
         hogX = 0;
         idle=true;
          }
        if(hogX == soilSize || hogX == soilSize*2 || hogX == soilSize*3 
        || hogX == soilSize*4 || hogX == soilSize*5 || hogX == soilSize*6){
          leftPressed=false;
          
        }
           
           
     if(rightPressed){
        idle=false;
         left=false;
         leftPressed=false;
         downPressed=false;
         hogX += hogSpeed;
         image(groundhogRight, hogX, hogY);
         
     }
        if(hogX + imgSize > width) {
         hogX = width - imgSize;
         rightPressed=false;
         idle=true;
         right=false;
       }
       
       if(hogX == soilSize || hogX == soilSize*2 || hogX == soilSize*3 
       || hogX == soilSize*4 || hogX == soilSize*5 || hogX == soilSize*6){ 
         rightPressed=false; 
       }
         
		// Health UI
    
    for (int i=0; i<playerHealth; i++){
      
        
        image(life,10+(i*70),10);
      
    }
      if(i<=0){
       gameState = GAME_OVER;
       }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  if (key==CODED) {
  switch(keyCode){
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break;
  }
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}
 
void keyReleased(){
}
