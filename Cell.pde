public class Cell{
  boolean isMined;
  int state;
  int label;
  
  Cell(boolean mine){
    isMined = mine;
    state = 0;
    label = 0;
  }
  
  void probe(){
    if(state==0){
      cellsLeft--;
    }
    if(isMined){
      state=3;
      //strokeWeight(5);
      textSize(60);
        fill(0);
        textAlign(CENTER, CENTER);
        text("GAME OVER.", width/2, height/2);
        noLoop();
    }
    else{
      state=1;
    }
  }
  
  void mark(){
    state=2;
  }
  
  void unmark(){
    if(state==2){
    state=0;
    }
  }
  
}
