Board test;
int row;
int col;
int stage;
boolean start;
boolean modeSelect;
boolean partySelect;
ArrayList<Pokemon> generator;
ArrayList<Pokemon> party;
ArrayList<String> types;

void setup() {
  size(576, 1024);
  start = true;
  stage = 1;
  types = new ArrayList<String>(Arrays.asList(new String[] {"Grass", "Water", "Fire", "Ice"}));
  generator = new ArrayList<Pokemon>();
  party = new ArrayList<Pokemon>();
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
    shapeMode(CORNER);
    textAlign(CENTER, CENTER);
    text("Party Select", width/2, height/6);

    // Party box
    fill(#595F59);
    rect(width/2 - 205, height/3 - 55, 410, 110);
    for (int i = 0; i < party.size(); i++) {
      if (party.get(i).getPNum() == 0) fill(#FF1538);
      if (party.get(i).getPNum() == 1) fill(#8915FF);
      if (party.get(i).getPNum() == 2) fill(#1588FF);
      if (party.get(i).getPNum() == 3) fill(#15FF1E);
      rect(width/2 - 200 + 100*i, height/3 - 50, 100, 100);
    }

    for (int i = 0; i < generator.size(); i++) {
      if (generator.get(i).getPNum() == 0) fill(#FF1538);
      if (generator.get(i).getPNum() == 1) fill(#8915FF);
      if (generator.get(i).getPNum() == 2) fill(#1588FF);
      if (generator.get(i).getPNum() == 3) fill(#15FF1E);
      rect(0+144*i, 448, 144, 144);
    }

    // Confirm?
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
        stage = 1;
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
    if (mouseY > height * 0.8 - 15 && mouseY < height * 0.8 + 15 && mouseX > (width/2) - 100 && mouseX < (width/2) + 100 && party.size() == 4) {
      partySelect = false;
      boardSetup(); // parameter for mode?
    }
    else if (mouseY > 448 && mouseY < 448 + 144 && mouseX > 0 && mouseX < width) {
      if (party.size() < 4) {
        col = mouseX / 144;
        if (!containDupe(generator.get(col), party)) {
          party.add(generator.get(col));
        }
      }
    }
    else if (mouseY > height/3 - 50 && mouseY < height/3 + 50 && mouseX > width/2 - 100 && mouseX < width / 2 + 100) {
      if (party.size() > 0) {
        col = (mouseX - (height/3 - 50)) / 100;
        println(col);
        party.remove(col);
      }
    }
  }
  else {
    int prevRow = row;
    int prevCol = col;
    if (mouseY >= 448 && mouseY < 1024 && mouseX > 0 && mouseX < 576) {
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

boolean containDupe(Pokemon input, ArrayList<Pokemon> test) {
  for (int i = 0; i < test.size(); i++) {
    if (input == test.get(i)) return true;
  }
  return false;
}
