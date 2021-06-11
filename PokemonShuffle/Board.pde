import java.util.*;

public class Board {
  Pokemon[][] board;
  int currentScore;
  int movesLeft;
  int level;
  int gamemode;
  int limit;
  int combo;
  int increase;
  int countMegas;
  boolean gameOver;
  boolean win;
  Boss giant;
  
  ArrayList<ArrayList<Integer>> rows; //for combo calc in rows
  ArrayList<ArrayList<Integer>> cols; //for combo calc in cols
  ArrayList<Float> calcVertMultipliers;
  ArrayList<Float> calcHorzMultipliers;
  String[] allTypes={"Normal", "Fighting", "Flying", "Poison", "Ground", "Rock",
  "Bug", "Fire", "Water", "Grass", "Electric", "Psychic", "Ice", "Dragon"};
  ArrayList<Pokemon> party;

Board(int moves, int lvl, ArrayList<Pokemon> p, int mode) {
  board = new Pokemon[6][6];
  rows = new ArrayList<ArrayList<Integer>>();
  cols = new ArrayList<ArrayList<Integer>>();
  level = lvl;
  party = p;
  gameOver=false;
  win=false;
  currentScore = 0;
  combo = 0;
  countMegas=0;
  movesLeft = moves;
  gamemode = mode;
  String bossType=allTypes[(int)(Math.random()*allTypes.length)];
  giant = new Boss(moves * 250 + (int) (Math.random() * (500 * level)),bossType, moves);
 
  generateBoard();
  if (mode == 1) {
     //limit = millis() + 121000;
     limit = millis() + 61000;
  }
  for (Pokemon poke:party){
    poke.resetCounter();
  }
}

Board(int moves, int lvl, ArrayList<Pokemon> p, int mode, String type) {
  board = new Pokemon[6][6];
  rows = new ArrayList<ArrayList<Integer>>();
  cols = new ArrayList<ArrayList<Integer>>();
  level = lvl;
  party = p;
  gameOver=false;
  win=false;
  currentScore = 0;
  combo = 0;
  movesLeft = moves;
  gamemode = mode;
  giant = new Boss(moves * 250 + (int) (Math.random() * (500 * level)),type, moves);
  
  for (Pokemon poke:party){
    poke.resetCounter();
  }
}

void generateBoard() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      board[i][j] = new Pokemon(party.get((int)(Math.random() * 4)).getPokemonName());
      if (i>1){
        while (board[i][j].getPNum()==board[i-1][j].getPNum()&&board[i-1][j].getPNum()==board[i-2][j].getPNum()){
          board[i][j] = new Pokemon(party.get((int)(Math.random() * 4)).getPokemonName());
        }
      }
      if (j>1){
        while (board[i][j].getPNum()==board[i][j-1].getPNum()&&board[i][j].getPNum()==board[i][j-2].getPNum()){
          board[i][j] = new Pokemon(party.get((int)(Math.random() * 4)).getPokemonName());
        }
      }
    }
  }
}

// ACCESSORS AND MODIFIERS
int getCurrentScore() { return currentScore; }
int getMovesLeft() { return movesLeft; }
int getStage() { return level; }
int getCombo() { return combo; }
int getIncrease() { return increase; }
int getMegas() { return countMegas; }
void addMegas() {countMegas++;}
Pokemon getPokemon(int row, int col) { return board[row][col]; }

void addScore(int s) { currentScore += s; }
void decrementMoves() { movesLeft--; }

boolean boardMega(){ 
 for (Pokemon p:this.party){
    if (p.isMega()){
      return true;
    }
 }
 return false;
}

void swap(int r1, int c1, int r2, int c2) throws InterruptedException {
  Pokemon temp = board[r1][c1];
  board[r1][c1] = board[r2][c2];
  board[r2][c2] = temp;
}

//"updates" board everytime something happens
void display() {
  background(255);
  noStroke();
  fill(0);
  int selectedRow = 0;
  int selectedCol = 0;
  boolean selected = false;
  textAlign(BASELINE, BASELINE);
  shapeMode(CORNER);
  PImage p1 = party.get(0).getPImage(80);
  PImage p2 = party.get(1).getPImage(80);
  PImage p3 = party.get(2).getPImage(80);
  PImage p4 = party.get(3).getPImage(80);
  PImage rock = loadImage("Rock.png");
  PImage block = loadImage("Block.png");
  PImage grid = loadImage("Grid.jpg");

  
  image(grid, 288, 736);
  rock.resize(80, 80);
  block.resize(80, 80);

  
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].isSelected()) {
        selected = true;
        selectedRow = i;
        selectedCol = j;
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
          if (board[i][j].getPNum() == -3) {
            fill(255);
            image(block,48+96*j,496+96*i);
            textAlign(CENTER, CENTER);
            text(board[i][j].getBlockTurns(), 48+96*j,496+96*i);
          }
          if (board[i][j].getPNum() == -2) image(rock,48+96*j,496+96*i);
          
          if (board[i][j].getPNum() == party.get(0).getPNum()) image(p1,48+96*j,496+96*i);
          if (board[i][j].getPNum() == party.get(1).getPNum()) image(p2,48+96*j,496+96*i);
          if (board[i][j].getPNum() == party.get(2).getPNum()) image(p3,48+96*j,496+96*i);
          if (board[i][j].getPNum() == party.get(3).getPNum()) image(p4,48+96*j,496+96*i);
          
          if (board[i][j].isFrozen()) {
            stroke(#456AEA);
            strokeWeight(3);
            fill(157, 154, 242, 215);
            rect(0+96*j, 448+96*i, 93, 93);
            noStroke();
          }
          
        }
      }
    }
  }
  
  if (selected) {
    if (board[selectedRow][selectedCol].getPNum() == -1) fill(#FFFFFF);
    if (board[selectedRow][selectedCol].getPNum() == party.get(0).getPNum()) image(p1,mouseX, mouseY);
    if (board[selectedRow][selectedCol].getPNum() == party.get(1).getPNum()) image(p2,mouseX, mouseY);
    if (board[selectedRow][selectedCol].getPNum() == party.get(2).getPNum()) image(p3,mouseX, mouseY);
    if (board[selectedRow][selectedCol].getPNum() == party.get(3).getPNum()) image(p4,mouseX, mouseY);
  }
  
  fill(0);
  textSize(20);
  textAlign(BASELINE, BASELINE);
  
  if (mode == 0 || mode == 2) {
    String msg = "Score: " + getCurrentScore() + "\nMoves: " + getMovesLeft() + "\nStage: " + getStage();
    if (increase > 0) msg = "Score: " + getCurrentScore() + " (+" + getIncrease() + ")" + "\nMoves: " + getMovesLeft() + "\nStage: " + getStage();
    text(msg, 0+4, 20+4);
    if (getCombo() > 0) {
      textAlign(RIGHT, RIGHT);
      text("Combo:", width - 4, 0 + 24);
      textSize(36);
      text(getCombo(), width - 8, 40 + 24);
    }
    giant.display(getCurrentScore());
  }
  if (mode == 1) {
    String msg = "Score: " + getCurrentScore() + "\nTime: " + (limit - millis()) / 1000 / 60 + ":" + (limit - millis()) / 1000 % 60;
    if ((limit - millis()) / 1000 % 60 / 10 == 0) {
      msg = "Score: " + getCurrentScore() +"\nTime: " + (limit - millis()) / 1000 / 60 + ":0" + (limit - millis()) / 1000 % 60;
    }
    if (increase > 0) {
      msg = "Score: " + getCurrentScore() + " (+" + getIncrease() + ")" + "\nTime: " + (limit - millis()) / 1000 / 60 + ":" + (limit - millis()) / 1000 % 60;
      if ((limit - millis()) / 1000 % 60 / 10 == 0) {
        msg = "Score: " + getCurrentScore() + " (+" + getIncrease() + ")" +"\nTime: " + (limit - millis()) / 1000 / 60 + ":0" + (limit - millis()) / 1000 % 60;
      }
    }
    text(msg, 0+4, 20+4);
 
    if (getCombo() > 0) {
      textAlign(RIGHT, RIGHT);
      text("Combo:", width - 4, 0 + 24);
      textSize(36);
      text(getCombo(), width - 8, 40 + 24);
    }
    giant.display();
  }
  checkWin();
  if (win){
    if (mode==2){
      shapeMode(CORNER);
      background(0);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(35);
      text("Wild Pokemon defeated!",width/2, 200);
      
      fill(#9E7AD8);
      textSize(15);
      rect(width/2 - 90,450 - 40,180,80);
      fill(0);
      text("Back to Level Select",width/2,450);
    }
    else{
      shapeMode(CORNER);
      background(0);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(35);
      text("You are win",width/2, 200);
    
      fill(#9E7AD8);
      rect(width/2 - 90,450 - 40,180,80);
      textSize(20);
      fill(0);
      text("Next stage",width/2,450);
    }
  }
  
  checkGameOver();
  if (gameOver){
    shapeMode(CORNER);
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(35);
    if (mode == 0) text("Ran out of moves...",width/2, 200);
    if (mode == 1) text("Ran out of time...",width/2, 200);
    
    textSize(24);
    text("Score: " + getCurrentScore(), width/2, 300);
    
    fill(#9E7AD8);
    rect(width/2 - 90,450 - 40,180,80);
    fill(0);
    text("Select Mode",width/2,450);
   
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
      
      while (col < board.length - 1 && p == board[row][col+1].getPNum() && !board[row][col].isRock() && !board[row][col].isBlock() && !board[row][col].isEmpty()) {
        len++;
        col++;
      }
      if (len >= 3) rows.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, j, len})));
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
      
      while (row < board.length - 1 && p == board[row+1][col].getPNum() && !board[row][col].isRock() && !board[row][col].isBlock() && !board[row][col].isEmpty()) {
        len++;
        row++;
      }
      if (len >= 3) cols.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {j, i, len})));
      j = row;
    }
  }
}

ArrayList<ArrayList<Integer>> rockCheck() {
  ArrayList<ArrayList<Integer>> rock = new ArrayList<ArrayList<Integer>>();
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].isRock()) rock.add(new ArrayList<Integer>(Arrays.asList(new Integer[] {i, j})));
    }
  }
  return rock;
}

void blockCheck() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j].isBlock()) {
        board[i][j].decrementBlockTurns();
        if (board[i][j].getBlockTurns() <= 0) board[i][j].setPNum(-1);
      }
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
  int i = row;
  boolean mega=false;
  int megaNum=0;
  for (int y=0;y<party.size();y++){
    if (party.get(y).isMega()){
      mega=true;
      megaNum=y;
    }
  }
  while (i > 0 && !board[i-1][col].isFrozen()) {
    board[i][col] = board[i-1][col];
    i--;
  }
  
  
  if (i != 0) board[i][col].setEmpty();
  
  if (mega){
    int coinflip=(int)(Math.random()*7);
    if (coinflip<5){
      board[i][col] = new Pokemon(party.get(megaNum).getPokemonName());
    }
    else{
      board[i][col] = new Pokemon(party.get((int)(Math.random() * 4)).getPokemonName());
    }
  }
  else{
    board[i][col] = new Pokemon(party.get((int)(Math.random() * 4)).getPokemonName());
  }
}

//Take values from arrayList (remove()), turn into -1 (cleared)
void scoreCalc() {
  //score calculation
  decrementMoves();
  blockCheck();
  combo = 0;
  increase = 0;
  
  while (check3Combo()) {
    comboCheck();
    ArrayList<ArrayList<Integer>> rockList = rockCheck();
    int baseScore = 50; // potential to add bonus for extra combos
    while(rows.size() > 0) {
      ArrayList<Integer> temp = rows.remove(rows.size() - 1);
      int len = 0;
      float multiplier=board[temp.get(0)][temp.get(1)].effectiveness(giant.getType()) * ((combo / 4 * 0.025) + 1);
      if (board[temp.get(0)][temp.get(1)].canMega()){
          for (Pokemon pok:party){
            if (pok.getPNum()==board[temp.get(0)][temp.get(1)].getPNum()){
              pok.increaseMegaCounter();
            }
            if (pok.checkMega()){
              multiplier*=1.25;
            }
          }
          
        }
      addScore((int)(baseScore * temp.get(2) * multiplier));
      increase += (int)(baseScore * temp.get(2) * multiplier); 
      while (len < temp.get(2)) {
        if (board[temp.get(0)][temp.get(1) + len].isFrozen()) {
          board[temp.get(0)][temp.get(1) + len].setFrozen(false);
          len++;
        }
        else {
          board[temp.get(0)][temp.get(1) + len].setPNum(-1);
          len++;
        }
      }
      combo++;
      
    }
    
    while(cols.size() > 0) {
      ArrayList<Integer> temp = cols.remove(cols.size() - 1);
      int len = 0;
      float multiplier=board[temp.get(0)][temp.get(1)].effectiveness(giant.getType()) * ((combo / 4 * 0.025) + 1);
      if (board[temp.get(0)][temp.get(1)].canMega()){
          for (Pokemon pok:party){
            if (pok.getPNum()==board[temp.get(0)][temp.get(1)].getPNum()){
              pok.increaseMegaCounter();
            }
            if (pok.checkMega()){
              multiplier*=1.25;
            }
          }
        }
      addScore((int)(baseScore * temp.get(2) * multiplier));
      increase += (int)(baseScore * temp.get(2) * multiplier); 
      while (len < temp.get(2)) {
        if (board[temp.get(0) + len][temp.get(1)].isFrozen()) {
          board[temp.get(0) + len][temp.get(1)].setFrozen(false);
          len++;
        }
        else {
          board[temp.get(0) + len][temp.get(1)].setPNum(-1);
          len++;
        }
      }
      combo++;
    }
      
    // Removing rocks if they are adjacent to a combo  
    for (int i = 0; i < rockList.size(); i++) {
      int r = rockList.get(i).get(0);
      int c = rockList.get(i).get(1);
      
      if ((r > 0 && board[r-1][c].getPNum() == -1) || (r < board.length - 1 && board[r+1][c].getPNum() == -1) || (c > 0 && board[r][c-1].getPNum() == -1) || (c < board.length - 1 && board[r][c+1].getPNum() == -1)) {
        board[r][c].setPNum(-1);
      }
    }
    
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[0].length; j++) {
        if (board[i][j].isEmpty()) {
          for (int k = i; k > -1; k--) {
            boolean freeze = false;
            if (board[k][j].isFrozen()) {
              freeze = true;
            }
            if (!freeze && !board[i][j].isFrozen()) {
              board[i][j].setPNum(-1);
            }
          }
        }
      }
    }
      // Tweaks:
      // Have board display after removing combos, dropping new ones, removing, repeat
      clearCombo();
  }
    giant.modifyBoard(board, movesLeft);
  }

boolean check3Combo(){
  for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (!board[i][y].isBlock() && !board[i][y].isRock() && !board[i][y].isEmpty() && board[i][y].getPNum()==board[i][y+1].getPNum()&&board[i][y].getPNum()==board[i][y+2].getPNum()){
         //notes which elements are in a row
         return true;
       }
     }
  }
    for (int i=0;i<6;i++){
     for (int y=0;y<4;y++){
       if (!board[y][i].isBlock() && !board[y][i].isRock() && !board[y][i].isEmpty() && board[y][i].getPNum()==board[y+1][i].getPNum()&&board[y][i].getPNum()==board[y+2][i].getPNum()){
           //notes which elements are in a row
           return true;
         }
       }
     }
     return false;
  }

void checkWin(){
  if (mode == 0||mode==2) {
   if (giant.getNeededScore()<=this.currentScore){
     win=true;
   }
  }
 }

void checkGameOver(){
  if (mode == 0) {
   if (giant.getNeededScore()>this.currentScore&&this.movesLeft==0){
     gameOver=true;
   }
  }
  if (mode == 1) {
    if (millis() > limit) {
      gameOver=true;
    }
  }
 }
}
