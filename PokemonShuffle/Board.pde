import java.util.*;

public class Board {
  int[][] board;
  int currentScore;
  int movesLeft;
  
  ArrayList<ArrayList<Integer>> rows; //for combo calc in rows
  ArrayList<ArrayList<Integer>> cols; //for combo calc in cols
  

Board(int moves) {
  board = new int[6][6];
  currentScore = 0;
  movesLeft = moves;
  rows = new ArrayList<ArrayList<Integer>>();
  cols = new ArrayList<ArrayList<Integer>>();
  
  generateBoard();
}

void generateBoard() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      board[i][j] = (int) (Math.random() * 4);
    }
  }
}

int getCurrentScore() {
  return currentScore;
}

int getMovesLeft() {
  return movesLeft;
}

void swap(int r1, int c1, int r2, int c2) {
  int temp = board[r1][c1];
  board[r1][c1] = board[r2][c2];
  board[r2][c2] = temp;
}

//"updates" board everytime something happens
//colors for now, might be replaced with PImages later
void display() {
  background(255);
  noStroke();
  fill(0);
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == -1) fill(0);
      if (board[i][j] == 0) fill(#FF1538);
      if (board[i][j] == 1) fill(#8915FF);
      if (board[i][j] == 2) fill(#1588FF);
      if (board[i][j] == 3) fill(#15FF1E);
      rect(0+96*j, 448+96*i, 96, 96);
    }
  }
  
  fill(0);
  textSize(24);
  text("Score: " + getCurrentScore() + "\nMoves Left: " + getMovesLeft(), 0+4, 24+4);
}

//works bottom to top
void clearCombo() {
 for (int i = board.length - 1; i > -1; i--) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == -1) {
        shift(i, j);
      }
    }
 }
}

void shift(int row, int col) {
  for (int i = row; i > 0; i--) {
    board[i][col] = board[i-1][col];
  }
  board[0][col] = (int) (Math.random() * 4);
}

void scoreCalc() {
  //score calculation
  println(3);
  check3Combo();
  println(4);
  check4Combo();
  println(5);
  check5Combo();
  println(6);
  check6Combo();
  
  println();
  println(rows.size());
  
  while(rows.size() != 0) {
    ArrayList<Integer> temp = rows.remove(rows.size() - 1);
    if (board[temp.get(0)][temp.get(1)] != temp.get(2) || board[temp.get(0)][temp.get(1)+1] != temp.get(2)) {
      
      int i = temp.get(0);
      int j = temp.get(1);
      
      while (j < board.length && board[i][j] == temp.get(2)) {
        //score
        board[i][j] = -1;
        j++;
      }
      println("r");
      display();
    }
  }
  
  //take values from arrayList (remove()), turn into -1 (cleared)
  //if checking for dupes, check if your coord and the one to the right are both -1
}

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
     int temp = board[0][i];
     for (int y=0; y<6; y++){
       if (board[y][i] != temp){
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

void check3Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[i][y]==board[i][y+1]&&board[i][y]==board[i][y+2]){
         //notes which elements are in a row
         rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, board[i][y], 3})));
         println(i + ", " + y);
       }
     }
  }
    for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[y][i]==board[y+1][i]&&board[y][i]==board[y+2][i]){
           //notes which elements are in a row
           cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, board[y][i], 3})));
           println(y + ", " + i);
         }
       }
     }
  }

void check4Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<3;y++){
         if (board[i][y]==board[i][y+1]&&board[i][y]==board[i][y+2]&&board[i][y]==board[i][y+3]){
           //notes which elements are in a row
           rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, board[i][y], 4})));
           println(i + ", " + y);
       }
     }
  }
  for (int i=0;i<6;i++){
   for (int y=0;y<3;y++){ 
       if (board[y][i]==board[y+1][i]&&board[y][i]==board[y+2][i]&&board[y][i]==board[y+3][i]){
         //notes which elements are in a row
         cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, board[y][i], 4})));
         println(y + ", " + i);
       }
     }
   }
 }
 
 void check5Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<2;y++){
         if (board[i][y]==board[i][y+1]&&board[i][y]==board[i][y+2]&&board[i][y]==board[i][y+3]&&board[i][y]==board[i][y+4]){
           //notes which elements are in a row
           rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, board[i][y], 5})));
           println(i + ", " + y);
       }
     }
  }
  for (int i=0;i<6;i++){
   for (int y=0;y<2;y++){ 
       if (board[y][i]==board[y+1][i]&&board[y][i]==board[y+2][i]&&board[y][i]==board[y+3][i]&&board[y][i]==board[y+4][i]){
         //notes which elements are in a row
         cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, board[y][i], 5})));
         println(y + ", " + i);
       }
     }
   }
 }

}
