import java.util.*;

public class Board {
  Pokemon[][] board;
  int currentScore;
  int movesLeft;
  int level;
  boolean gameOver=false;
  boolean win=false;
  Boss giant;
  
  ArrayList<ArrayList<Integer>> rows; //for combo calc in rows
  ArrayList<ArrayList<Integer>> cols; //for combo calc in cols
  ArrayList<Float> calcVertMultipliers;
  ArrayList<Float> calcHorzMultipliers;
  String[] allTypes={"Normal", "Fighting", "Flying", "Poison", "Ground", "Rock",
  "Bug", "Fire", "Water", "Grass", "Electric", "Psychic", "Ice", "Dragon"};

Board(int moves, int lvl) {
  board = new Pokemon[6][6];
  rows = new ArrayList<ArrayList<Integer>>();
  cols = new ArrayList<ArrayList<Integer>>();
  level = lvl;
  gameOver=false;
  win=false;
  currentScore = 0;
  movesLeft = moves;
  String bossType=allTypes[(int)(Math.random()*allTypes.length)];
  giant = new Boss(10000,bossType);
  
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
 //THIS PART IS FOR TESTING TYPE EFFECTIVENESS
 for (int i=0;i<board.length;i++){
   for (int y=0;y<board.length;y++){
     if (board[i][y].getPNum()==0){
       board[i][y].setType("Grass");
       
     }
     if (board[i][y].getPNum()==1){
       board[i][y].setType("Water");
     }
     if (board[i][y].getPNum()==2){
       board[i][y].setType("Fire");
     }
     if (board[i][y].getPNum()==3){
       board[i][y].setType("Ice");
     }
   }
 }
}

// ACCESSORS AND MODIFIERS
int getCurrentScore() { return currentScore; }
int getMovesLeft() { return movesLeft; }
int getStage() { return level; }
Pokemon getPokemon(int row, int col) { return board[row][col]; }

void addScore(int s) { currentScore += s; }
void decrementMoves() { movesLeft--; }


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
  textAlign(BASELINE, BASELINE);
  shapeMode(CORNER);
  
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].isSelected()) {
        fill(0);
        selected = true;
        selectedRow = i;
        selectedCol = j;
        rect(0+96*j, 448+96*i, 96, 96);
      }
      else {
        if (board[i][j].getPNum() == -1) {
          fill(0);
          rect(0+96*j, 448+96*i, 96, 96);
          fill(255);
          textSize(10);
          text("R", 10+96*j, 458+96*i);
        }
        else {
          PImage charmander = loadImage("Charmander.png");
          if (board[i][j].getPNum() == 0){ 
            charmander.resize(0+96,96);
            image(charmander,0+96*j,448+96*i);
            //charmander.resize(20,20);
          }
          if (board[i][j].getPNum() == 1) {
            charmander.resize(0+96,96);
            image(charmander,0+96*j,448+96*i);
            //charmander.resize(20,20);
          }
          if (board[i][j].getPNum() == 2) {
            charmander.resize(0+96,96);
            image(charmander,0+96*j,448+96*i);
            //charmander.resize(20,20);;
          }
          if (board[i][j].getPNum() == 3) {
            charmander.resize(0+96,96);
            image(charmander,0+96*j,448+96*i);
            //charmander.resize(20,20);;
          }
          rect(0+96*j, 448+96*i, 96, 96);
        }
      }
    }
  }
  
  if (selected) {
    PImage charmander = loadImage("Charmander.png");
    if (board[selectedRow][selectedCol].getPNum() == -1) fill(0);
    if (board[selectedRow][selectedCol].getPNum() == 0) {
      charmander.resize(0+96,96);
      image(charmander,0+96*selectedRow,448+96*selectedCol);
      //charmander.resize(20,20);
    }
    if (board[selectedRow][selectedCol].getPNum() == 1) {
       charmander.resize(0+96,96);
       image(charmander,0+96*selectedRow,448+96*selectedCol);
       //charmander.resize(20,20);
    }
    if (board[selectedRow][selectedCol].getPNum() == 2) {
      charmander.resize(0+96,96);
      image(charmander,0+96*selectedRow,448+96*selectedCol);
      //charmander.resize(20,20);
    }
    if (board[selectedRow][selectedCol].getPNum() == 3) {
      charmander.resize(0+96,96);
      image(charmander,0+96*selectedRow,448+96*selectedCol);
      //charmander.resize(20,20);
    }
    charmander.resize(0+96,96);
    image(charmander,mouseX - 48, mouseY - 48);
  }
  
  
  fill(0);
  textSize(20);
  text("Score: " + getCurrentScore() + "\nMoves: " + getMovesLeft() + "\nStage: " + getStage(), 0+4, 20+4);
  giant.display(getCurrentScore());
  
  checkWin();
  if (win){
    shapeMode(CORNER);
    background(0);
    fill(255);
    textAlign(BASELINE, BASELINE);
    textSize(24);
    text("You are win",200, 480-100);
    fill(#9E7AD8);
    rect(180,500-100,180,80);
    fill(0);
    text("Next stage",220,550-100);
  }
  
  checkGameOver();
  if (gameOver){
    shapeMode(CORNER);
    background(0);
    fill(255);
    textAlign(BASELINE, BASELINE);
    textSize(24);
    text("Game Over...",200, 480-100);
    fill(#9E7AD8);
    rect(180,500-100,180,80);
    fill(0);
    text("Restart?",220,550-100);
   
  }
  
}


// PRINTLN IN HERE FOR DEBUGGING
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
        //println(i + ", " + j + ", " + len);        
        
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
        //println(j + ", " + i + ", " + len);
        
        cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {j, i, len})));
      }
      j = row;
    }
  }
}

//Clear combos from bottom to top
void clearCombo() {
 for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].getPNum() == -1) {
        shift(i, j);
      }
    }
 }
}

private void shift(int row, int col) {
  for (int i = row; i > 0; i--) {
    board[i][col] = board[i-1][col];
  }
  board[0][col] = new Pokemon("element",(int)(Math.random() * 4));
}

//Take values from arrayList (remove()), turn into -1 (cleared)
void scoreCalc() throws InterruptedException {
  //score calculation
  decrementMoves();
  while (check3Combo()) {
  comboCheck();
  
  int baseScore = 50; // potential to add bonus for extra combos
  while(rows.size() > 0) {
    ArrayList<Integer> temp = rows.remove(rows.size() - 1);
    int len = 0;
    float multiplier=board[temp.get(0)][temp.get(1)].effectiveness(giant.getType());
    addScore((int)(baseScore * temp.get(2) * multiplier));
    while (len < temp.get(2)) {
      board[temp.get(0)][temp.get(1) + len].setPNum(-1);
      len++;
    }
    }
  
  while(cols.size() > 0) {
    ArrayList<Integer> temp = cols.remove(cols.size() - 1);
    int len = 0;
    float multiplier=board[temp.get(0)][temp.get(1)].effectiveness(giant.getType());
    addScore((int)(baseScore * temp.get(2) * multiplier));
    while (len < temp.get(2)) {
      board[temp.get(0) + len][temp.get(1)].setPNum(-1);
      len++;
    }
    }
    
    // Tweaks:
    // Have board display after removing combos, dropping new ones, removing, repeat
    clearCombo();
  }
  }

boolean check3Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()){
         //notes which elements are in a row
         return true;
       }
     }
  }
    for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()){
           //notes which elements are in a row
           return true;
         }
       }
     }
     return false;
  }

void checkWin(){
   if (giant.getNeededScore()<=this.currentScore){
     win=true;
   }
 }

void checkGameOver(){
   if (giant.getNeededScore()>this.currentScore&&this.movesLeft==0){
     gameOver=true;
   }
 }

//void check4Combo(){
//  for (int i=0;i<6;i++){
//     for (int y=0;y<3;y++){
//         if (board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()&&board[i][y].getPNum()==board[i][y+3].getPNum()){
//           //notes which elements are in a row
//           rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, 4})));
//           println(i + ", " + y);
//       }
//     }
//  }
//  for (int i=0;i<6;i++){
//   for (int y=0;y<3;y++){ 
//       if (board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()&&board[y][i].getPNum()==board[y+3][i].getPNum()){
//         //notes which elements are in a row
//         cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, 4})));
//         println(y + ", " + i);
//       }
//     }
//   }
// }
 
// void check5Combo(){
//  for (int i=0;i<6;i++){
//     for (int y=0;y<2;y++){
//         if (board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()&&board[i][y].getPNum()==board[i][y+3].getPNum()&&board[i][y].getPNum()==board[i][y+4].getPNum()){
//           //notes which elements are in a row
//           rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, y, 5})));
//           println(i + ", " + y);
//       }
//     }
//  }
//  for (int i=0;i<6;i++){
//   for (int y=0;y<2;y++){ 
//       if (board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()&&board[y][i].getPNum()==board[y+3][i].getPNum()&&board[y][i].getPNum()==board[y+4][i].getPNum()){
//         //notes which elements are in a row
//         cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {y, i, 5})));
//         println(y + ", " + i);
//       }
//     }
//   }
// }
//void check6Combo(){
//  // ho
//  boolean combo = true;
//  for (int i=0; i<6; i++){
//    for (int y=0; y<6; y++){
//      if (board[i][y] != board[i][0]){
//        combo = false;
//      }
//    }
//    if (combo) {
//      println(i + ", " + 0);
//    }
//    combo = true;
//  }
  
//  combo = true;
//  // vert
//   for (int i=0; i<6; i++){
//     int temp = board[0][i].getPNum();
//     for (int y=0; y<6; y++){
//       if (board[y][i].getPNum() != temp){
//         // no 6 combo
//         combo = false;
//       }
//     }
//     if (combo) {
//      println(0 + ", " + i);
//     }
//    combo = true;
//  }
//}
}
