class Minesweeper{
  int mines;
 
  
  Minesweeper(int numOfMines){
    mines = numOfMines;
   
  }
  void display(){   
    
    for(int col = 0; col < cells[0].length; col++){

      for(int row = 0; row < cells.length; row++){
        stroke(0);
    
        if(cells[row][col].state==0){
          fill(0, 0, 255);
          rect(col*xInt, row*yInt, xInt, yInt);
        }
        else if(cells[row][col].state==1){
          noFill();
          textAlign(CENTER, CENTER);
          text(cells[row][col].label, col*xInt+xInt/2, row*yInt+yInt/2);
          rect(col*xInt, row*yInt, xInt, yInt);
        }
        else if(cells[row][col].state==2){
          fill(0,0,255);
          stroke(0);
          rect(col*xInt, row*yInt, xInt, yInt);
          line(col*xInt, row*yInt, (col+1)*xInt, (row+1)*yInt);
          line(col*xInt, (row+1)*yInt, (col+1)*xInt, row*yInt);
          
        }
        else if(cells[row][col].state==3){
          fill(255,0,0);
          rect(col*xInt, row*yInt, xInt, yInt);
         
        
        }
        
      }
    }
    
    if(cellsLeft == mines){
      stroke(0);
      textSize(60);
      fill(0);
      textAlign(CENTER, CENTER);
      text("YOU WON.", width/2, height/2);
      noLoop();
    }
  }
  
  void probe(int row, int col){
    cells[row][col].probe();

    
    cells[row][col].label = calcLabel(row, col);
    if(cells[row][col].label == 0){
      if(row < cells.length-1){
        if(cells[row+1][col].state==0){
          probe(row+1, col);
          
        }
      if(col < cells[0].length-1){
          if(cells[row+1][col+1].state==0){
          probe(row+1, col+1);
          
        }
      }
      if(col > 0){
        if(cells[row+1][col-1].state==0){
          probe(row+1, col-1);
          
        }
      }
    }
    if(row > 0){
      if(cells[row-1][col].state==0){
          probe(row-1, col);
          
        }
      if(col < cells[0].length-1){
        if(cells[row-1][col+1].state==0){
          probe(row-1, col+1);
          
        }
      }
      if(col > 0){
        if(cells[row-1][col-1].state==0){
          probe(row-1, col-1);
          
        }
      }
    }
    if(col < cells[0].length-1){
        if(cells[row][col+1].state==0){
          probe(row, col+1);
          
        }
      }
      if(col > 0){
        if(cells[row][col-1].state==0){
          probe(row, col-1);
          
        }
      }
    }
  }

  int calcLabel(int row, int col){
    int label = 0;
    if(row < cells.length-1){
      if(cells[row+1][col].isMined){
        label++;
      }
      if(col < cells[0].length-1){
        if(cells[row+1][col+1].isMined){
          label++;
        }
      }
      if(col > 0){
        if(cells[row+1][col-1].isMined){
          label++;
        }

      }
    }
    if(row > 0){
      if(cells[row-1][col].isMined){
        label++;
      }
      if(col < cells[0].length-1){
        if(cells[row-1][col+1].isMined){
          label++;
        }
      }
      if(col > 0){
        if(cells[row-1][col-1].isMined){
          label++;
        }
      }
    }
    if(col < cells[0].length-1){
        if(cells[row][col+1].isMined){
          label++;
        }
      }
      if(col > 0){
        if(cells[row][col-1].isMined){
          label++;
        }
      }
    return label;
    }
    
    void mark(int row, int col){
      cells[row][col].mark();
    }
    
    void unmark(int row, int col){
      cells[row][col].unmark();
    }
  
}
