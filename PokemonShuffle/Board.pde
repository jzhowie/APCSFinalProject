public class Board {
  int[][] board;
  int currentScore;
  int movesLeft;
  
  ArrayList<ArrayList<Integer>> rows; //for combo calc
  ArrayList<ArrayList<Integer>> cols; //for combo calc
  

Board(int moves) {
  board = new int[6][6];
  currentScore = 0;
  movesLeft = moves;
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
      if (board[i][j] == 0) fill(0);
      if (board[i][j] == 1) fill(60);
      if (board[i][j] == 2) fill(180);
      if (board[i][j] == 3) fill(240);
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

void check6Combo(){
  for (int i=0;i<6;i++){
    int[] subArray=board[i];
    int temp=board[i][0];
    for (int y:subArray){
      if (y!=temp){
        //no 6 combo
      }
      else{
        //clear the row
      }
    }
  }
    for (int i=0;i<6;i++){
     for (int y=0;y<6;y++){
       int temp=board[i][0];
       if (board[i][y]!=temp){
         // no 6 combo
       }
       else{
         // clear the column
       }
     }
  }
}

void check3Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[i][y]==board[i][y+1]&&board[i][y]==board[i][y+2]){
         //notes which elements are in a row
       }
     }
  }
    for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[y][i]==board[y+1][i]&&board[y][i]==board[y+2][i]){
           //notes which elements are in a row
         }
       }
     }
  }

void check4Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<3;y++){
         if (board[i][y]==board[i][y+1]&&board[i][y]==board[i][y+2]&&board[i][y]==board[i][y+3]){
           //notes which elements are in a row
       }
     }
  }
  for (int i=0;i<6;i++){
   for (int y=0;y<3;y++){ 
       if (board[y][i]==board[y+1][i]&&board[y][i]==board[y+2][i]&&board[y][i]==board[y+3][i]){
         //notes which elements are in a row
       }
     }
   }
 }
 
 void check5Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<2;y++){
         if (board[i][y]==board[i][y+1]&&board[i][y]==board[i][y+2]&&board[i][y]==board[i][y+3]&&board[i][y]==board[i][y+4]){
           //notes which elements are in a row
       }
     }
  }
  for (int i=0;i<6;i++){
   for (int y=0;y<2;y++){ 
       if (board[y][i]==board[y+1][i]&&board[y][i]==board[y+2][i]&&board[y][i]==board[y+3][i]&&board[y][i]==board[y+4][i]){
         //notes which elements are in a row
       }
     }
   }
 }

}
