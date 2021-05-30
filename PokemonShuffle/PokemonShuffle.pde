Board test;
int row;
int col;
int stage;
boolean start;
boolean modeSelect;
boolean partySelect;
ArrayList<Pokemon> generator;
ArrayList<String> types;

void setup() {
  size(576, 1024);
  start = true;
  stage = 1;
  types = new ArrayList<String>(Arrays.asList(new String[] {"Grass", "Water", "Fire", "Ice"}));
  generator = new ArrayList<Pokemon>();
  for (int i = 0; i < 4; i++) {
    generator.add(new Pokemon(types.get(i), i));
  }
  //test = new Board(1);
  //test.display();
}

void draw() {
  // starting screen hopefully
  if (start) {
    shapeMode(CORNER);
    background(255);
    fill(0);
    noStroke();
    textSize(25); //n needs tweaking
    textAlign(CENTER, CENTER);
    
    imageMode(CENTER);
    PImage title = loadImage("TitleScreen.png");
    title.resize(title.width/2, title.height/2);
    image(title, width/2, height/4);
    text("<< Click anywhere to proceed >>", width/2, height * 0.80);
  }
  else if (modeSelect) {
    background(255);
    fill(0);
    noStroke();
    textSize(25);
    textAlign(CENTER, CENTER);
    text("Gamemode(s)", width/2, height/4);
    shapeMode(CORNER);
    fill(255, 0, 0);
    rect(width/2 - 100, height/2 - 15, 200, 30);
    fill(0);
    text("Endless", width/2, height/2);
  }
  else if (partySelect) {
    background(255);
    fill(0);
    noStroke();
    textSize(25);
    textAlign(CENTER, CENTER);
    text("Party Select", width/2, height/4);
    
    shapeMode(CORNER);
    fill(#55F766);
    rect(width/2 - 100, height * (0.80) - 15, 200, 30);
    fill(0);
    text("Confirm", width/2, height * (0.80));
  }
  else {
    test.display();
  }
}

// orb moving during board
void mousePressed() {
  if (!start && !modeSelect && !partySelect) {
    if (mouseY >= 448 && mouseY < 1024 && mouseX > 0 && mouseX < 576) { // and if game started
      row = (mouseY - 448) / 96;
      col = mouseX / 96;
      //println(row + ", " + col);
      test.getPokemon(row, col).toggleSelect();
    }
    else if (test.win) {
      if (mouseX<=360&&mouseX>=180&&mouseY>=500-100&&mouseY<=580-100){
        stage++;
        test=new Board(99, stage);
        //just for testing, actual game over should probably send to start menu
      }
    }
    else if (test.gameOver){
      if (mouseX<=360&&mouseX>=180&&mouseY>=500-100&&mouseY<=580-100){
        test=new Board(99, stage);
        //just for testing, actual game over should probably send to start menu
      }
    }
  }
}

void mouseReleased() {
  if (start) {
    start = false;
    modeSelect = true;
  }
  else if (modeSelect) {
    if (mouseY > (height/2) - 15 && mouseY < (height/2) + 15 && mouseX > (width/2) - 100 && mouseX < (width/2) + 100) {
      partySelect = true;
      modeSelect = false;
    }
  }
  else if (partySelect) {
    if (mouseY > height * 0.8 - 15 && mouseY < height * 0.8 + 15 && mouseX > (width/2) - 100 && mouseX < (width/2) + 100)
    partySelect = false;
    boardSetup(); // parameter for mode?
  }
  else {
    int prevRow = row;
    int prevCol = col;
    if (mouseY >= 448 && mouseY < 1024 && mouseX > 0 && mouseX < 57) {
      test.getPokemon(row, col).toggleSelect();
      try {
        test.swap(prevRow, prevCol, (mouseY - 448) / 96, mouseX / 96);
        if (!test.check3Combo()) {
          test.swap((mouseY - 448) / 96, mouseX / 96, prevRow, prevCol);
        }
        else {
          test.scoreCalc();
        }
      }
      catch (InterruptedException e) {}
    }
  }
}

void boardSetup() {
  test = new Board(99, stage); // set to 1 to test game over
  test.display();
}
