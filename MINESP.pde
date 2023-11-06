Minesweeper game;
Cell[][] cells;
float yInt;
float xInt;
ArrayList<Integer> probeSet;
ArrayList<Integer> tempSet;
ArrayList<Integer> unmarkedNeighbors;
ArrayList<Integer> probedNeighbors;
int change;
int safeMove, safeT;
int cellsLeft;

void setup(){
  size(800,800); 
  strokeWeight(3);
  cells = new Cell[16][16];
  cellsLeft = 16*16;
  
  ArrayList<Boolean> cellSet = new ArrayList<Boolean>();
    for(int tt = 0; tt < 16*16; tt++){
      if(tt<40){
        cellSet.add(true);
      }
      else{
        cellSet.add(false);
      }
    }
    
    
    for(int re = 0; re < 16; re++){
      for(int at = 0; at < 16; at++){
        int result = int(random(1)*cellSet.size());
        cells[re][at] = new Cell(cellSet.get(result));
        cellSet.remove(result); 
      }
    }
    yInt = 800.0 / cells.length;
    xInt = 800.0 / cells[0].length;
  game = new Minesweeper(40);
  probeSet = new ArrayList<Integer>();
  safeT = 0;
 // delay(1000);
}



void draw(){
  background(255);
  
  game.display();
 // delay(100);
  tempSet = new ArrayList<Integer>();

  if(safeMove == 0){
    safeT++;
  }
  else{
    safeT = 0;
  }
  if(probeSet.size() == 0 || safeT == 2){
    int choice = int(random(1)*cells.length*cells[0].length);
    while(cells[choice / cells[0].length][choice % cells[0].length].state != 0){
      choice = int(random(1)*cells.length*cells[0].length);
    }
    probeSet.add(choice);
    safeT = 0;
  }

 
  
  safeMove=0;
  for(int that = 0; that < probeSet.size(); that++){
    int r = probeSet.get(that) / cells[0].length;
    int c = probeSet.get(that) % cells[0].length;
    int marked = 0;
    if(cells[r][c].state==0){
      game.probe(r, c);
    }
    probedNeighbors = new ArrayList<Integer>();
    unmarkedNeighbors = new ArrayList<Integer>();
    if(r < cells.length-1){
        if(cells[r+1][c].state==0){
          unmarkedNeighbors.add((r+1)*cells[0].length+c);
        }
        else if(cells[r+1][c].state==2){
          marked++;
        }
        else if(cells[r+1][c].state==1){
          probedNeighbors.add((r+1)*cells[0].length+c);
        }
        
        if(c < cells[0].length-1){
          if(cells[r+1][c+1].state==0){
            unmarkedNeighbors.add((r+1)*cells[0].length+c+1);
          }
          else if(cells[r+1][c+1].state==2){
            marked++;
          }
          else if(cells[r+1][c+1].state==1){
            probedNeighbors.add((r+1)*cells[0].length+c+1);
          }
        }
      
      if(c > 0){
          if(cells[r+1][c-1].state==0){
            unmarkedNeighbors.add((r+1)*cells[0].length+c-1);
          }
          else if(cells[r+1][c-1].state==2){
            marked++;
          }
          else if(cells[r+1][c-1].state==1){
            probedNeighbors.add((r+1)*cells[0].length+c-1);
          }
        }

      
    }
    if(r > 0){
      
        if(cells[r-1][c].state==0){
          unmarkedNeighbors.add((r-1)*cells[0].length+c);
        }
         else if(cells[r-1][c].state==2){
          marked++;
        }
        else if(cells[r-1][c].state==1){
            probedNeighbors.add((r-1)*cells[0].length+c);

          }
      
      if(c < cells[0].length-1){
      
        if(cells[r-1][c+1].state==0){
          unmarkedNeighbors.add((r-1)*cells[0].length+c+1);
        }
        else if(cells[r-1][c+1].state==2){
          marked++;
        }
        else if(cells[r-1][c+1].state==1){
            probedNeighbors.add((r-1)*cells[0].length+c+1);
          }
        
      }
      if(c > 0){
     
          if(cells[r-1][c-1].state==0){
          unmarkedNeighbors.add((r-1)*cells[0].length+c-1);
        }
        else if(cells[r-1][c-1].state==2){
          marked++;
        }
        else if(cells[r-1][c-1].state==1){
            probedNeighbors.add((r-1)*cells[0].length+c-1);
          }
        
      }
    }
    if(c < cells[0].length-1){
        
          if(cells[r][c+1].state==0){
          unmarkedNeighbors.add((r)*cells[0].length+c+1);
        }
        else if(cells[r][c+1].state==2){
          marked++;
        }
        else if(cells[r][c+1].state==1){
            probedNeighbors.add((r)*cells[0].length+c+1);
          }
        
      }
      if(c > 0){
    
          if(cells[r][c-1].state==0){
          unmarkedNeighbors.add((r)*cells[0].length+c-1);
        }
        else if(cells[r][c-1].state==2){
          marked++;
        }
        else if(cells[r][c-1].state==1){
            probedNeighbors.add((r)*cells[0].length+c-1);
          }
        
      }
      int eLabel = cells[r][c].label-marked;
     // println(eLabel);
      if(eLabel == unmarkedNeighbors.size() && eLabel != 0){
        safeMove++;
      
        for(int toMark : unmarkedNeighbors){
          
          game.mark(toMark / cells[0].length, toMark % cells[0].length);
          
        }
    
   
      }
      else if(eLabel == 0){
        if(unmarkedNeighbors.size() != 0){
          safeMove++;
        }
        for(int toAdd : unmarkedNeighbors){
          tempSet.add(toAdd);
        }

        for(int bat : probedNeighbors){
          tempSet.add(bat);
        }
       
      }

      
      
      
  }



  for(int bet : tempSet){
    boolean dang=true;
    for(int ter=0; ter<probeSet.size(); ter++){
      if(probeSet.get(ter)==bet){
        dang=false;
        ter=probeSet.size();
      }
    }
    if(dang){
      probeSet.add(bet);
    }
  } 

  
  
  
  if(keyPressed){
    if(key == 'p' || key == 'P'){
      int co = int(mouseX/xInt);
      int ro = int(mouseY/yInt);
      game.probe(ro, co);
    }
    else if(key == 'm' || key == 'M'){
      int co = int(mouseX/xInt);
      int ro = int(mouseY/yInt);
      game.mark(ro, co);
    }
    else if(key == 'n' || key == 'N'){
      int co = int(mouseX/xInt);
      int ro = int(mouseY/yInt);
      game.unmark(ro, co);
    }
  }

  
  }
