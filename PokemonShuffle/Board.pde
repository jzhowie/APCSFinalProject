import java.util.*;

public class Board {
  Pokemon[][] board;
  int currentScore;
  int movesLeft;
  
  ArrayList<ArrayList<Integer>> rows; //for combo calc in rows
  ArrayList<ArrayList<Integer>> cols; //for combo calc in cols
  

Board(int moves) {
  board = new Pokemon[6][6];
  currentScore = 0;
  movesLeft = moves;
  rows = new ArrayList<ArrayList<Integer>>();
  cols = new ArrayList<ArrayList<Integer>>();
  
  generateBoard();
}

void generateBoard() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      board[i][j] = new Pokemon("element",(int)(Math.random() * 4));
      if (i>1){
        while (board[i][j].getPNum()==board[i-1][j].getPNum()&&board[i-1][j].getPNum()==board[i-2][j].getPNum()){
          board[i][j] = new Pokemon("element",(int)(Math.random() * 4));
        }
      }
      if (j>1){
        while (board[i][j].getPNum()==board[i][j-1].getPNum()&&board[i][j].getPNum()==board[i][j-2].getPNum()){
          board[i][j] = new Pokemon("element",(int)(Math.random() * 4));
        }
      }
    }
  }
}

int getCurrentScore() {
  return currentScore;
}

int getMovesLeft() {
  return movesLeft;
}

void swap(int r1, int c1, int r2, int c2) throws InterruptedException {
  Thread.sleep(100);
  Pokemon temp = board[r1][c1];
  board[r1][c1] = board[r2][c2];
  board[r2][c2] = temp;
}

//"updates" board everytime something happens
//colors for now, might be replaced with PImages later
void display() {
  background(255);
  noStroke();
  fill(0);
  int selectedRow = 0;
  int selectedCol = 0;
  boolean selected = false;
  
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].isSelected()) {
        fill(0);
        selected = true;
        selectedRow = i;
        selectedCol = j;
      }
      else {
        if (board[i][j].getPNum() == -1) fill(0);
        if (board[i][j].getPNum() == 0) fill(#FF1538);
        if (board[i][j].getPNum() == 1) fill(#8915FF);
        if (board[i][j].getPNum() == 2) fill(#1588FF);
        if (board[i][j].getPNum() == 3) fill(#15FF1E);
      }
      rect(0+96*j, 448+96*i, 96, 96);
    }
  }
  
  if (selected) {
    if (board[selectedRow][selectedCol].getPNum() == -1) fill(0);
    if (board[selectedRow][selectedCol].getPNum() == 0) fill(#FF1538);
    if (board[selectedRow][selectedCol].getPNum() == 1) fill(#8915FF);
    if (board[selectedRow][selectedCol].getPNum() == 2) fill(#1588FF);
    if (board[selectedRow][selectedCol].getPNum() == 3) fill(#15FF1E);
    rect(mouseX - 48, mouseY - 48, 96, 96);
  }
  
  
  fill(0);
  textSize(24);
  text("Score: " + getCurrentScore() + "\nMoves Left: " + getMovesLeft(), 0+4, 24+4);
}

void comboCheck() {
  // FOR ROWS
  // Loops through everything adjacent to the right that is equal as itself
  // Records length and only adds to the arraylist if it is greater than 3
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < 4; j++) {
      int p = board[i][j].getPNum();
      int len = 1;
      int row = i;
      int col = j;
      
      while (col < board.length - 1 && p == board[row][col+1].getPNum()) {
        len++;
        col++;
      }
      if (len >= 3) {
        println(i + ", " + j + ", " + len);
        rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, j, len})));
      }
      j = col;
    }
  }
  
  // FOR COLS i = Col #, j = Row # 
  // Loops through everything adjacent down that is equal as itself
  // Records length and only adds to the arraylist if it is greater than 3
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < 4; j++) {
      int p = board[j][i].getPNum();
      int len = 1;
      int col = i;
      int row = j;
      
      while (row < board.length - 1 && p == board[row+1][col].getPNum()) {
        len++;
        row++;
      }
      if (len >= 3) {
        println(j + ", " + i + ", " + len);
        cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {j, i, len})));
      }
      j = row;
    }
  }
}
//works bottom to top
void clearCombo() {
 for (int i = board.length - 1; i > -1; i--) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].getPNum() == -1) {
        shift(i, j);
      }
    }
 }
}

void shift(int row, int col) {
  for (int i = row; i > 0; i--) {
    board[i][col] = board[i-1][col];
  }
  board[0][col] = new Pokemon("element",(int)(Math.random() * 4));
}

void scoreCalc() {
  //score calculation
  //println(3);
  //check3Combo();
  //println(4);
  //check4Combo();
  //println(5);
  //check5Combo();
  //println(6);
  //check6Combo();
  
  comboCheck();
  println();
  
  //removing combos wip
  while(rows.size() > 0) {
    ArrayList<Integer> temp = rows.remove(rows.size() - 1);
    
    display();
    }
  }
  
  //take values from arrayList (remove()), turn into -1 (cleared)
  //if checking for dupes, check if your coord and the one to the right are both -1


void check6Combo(){
  // ho
  boolean combo = true;
  for (int i=0; i<6; i++){
    for (int y=0; y<6; y++){
      if (board[i][y] != board[i][0]){
        combo = false;
      }
    }
    if (combo) {
      println(i + ", " + 0);
    }
    combo = true;
  }
  
  combo = true;
  // vert
   for (int i=0; i<6; i++){
     int temp = board[0][i].getPNum();
     for (int y=0; y<6; y++){
       if (board[y][i].getPNum() != temp){
         // no 6 combo
         combo = false;
       }
     }
     if (combo) {
      println(0 + ", " + i);
     }
    combo = true;
  }
}

boolean check3Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()){
         //notes which elements are in a row
         //rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, 3})));         
         //println(i + ", " + y);
         return true;
       }
     }
  }
    for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()){
           //notes which elements are in a row
           //cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, 3})));
           //println(y + ", " + i);
           return true;
         }
       }
     }
     return false;
  }

void check4Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<3;y++){
         if (board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()&&board[i][y].getPNum()==board[i][y+3].getPNum()){
           //notes which elements are in a row
           rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, 4})));
           println(i + ", " + y);
       }
     }
  }
  for (int i=0;i<6;i++){
   for (int y=0;y<3;y++){ 
       if (board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()&&board[y][i].getPNum()==board[y+3][i].getPNum()){
         //notes which elements are in a row
         cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, 4})));
         println(y + ", " + i);
       }
     }
   }
 }
 
 void check5Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<2;y++){
         if (board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()&&board[i][y].getPNum()==board[i][y+3].getPNum()&&board[i][y].getPNum()==board[i][y+4].getPNum()){
           //notes which elements are in a row
           rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, 5})));
           println(i + ", " + y);
       }
     }
  }
  for (int i=0;i<6;i++){
   for (int y=0;y<2;y++){ 
       if (board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()&&board[y][i].getPNum()==board[y+3][i].getPNum()&&board[y][i].getPNum()==board[y+4][i].getPNum()){
         //notes which elements are in a row
         cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, 5})));
         println(y + ", " + i);
       }
     }
   }
 }
 
 
 Pokemon getPokemon(int row, int col) {
   return board[row][col];
 }



}
