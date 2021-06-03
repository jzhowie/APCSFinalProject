Board test;
int row;
int col;
int stage;
int mode;
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
  types = new ArrayList<String>(Arrays.asList(new String[] {"Fire","Grass","Dragon","Water","Normal","Flying","Electric","Ground"}));
  String[] pokemon = {"Charmander", "Bulbasaur", "Dratini", "Squirtle","Raticate","Pidgeotto","Pikachu","Sandshrew"};
  generator = new ArrayList<Pokemon>();
  party = new ArrayList<Pokemon>();
  for (int i = 0; i < 8; i++) {
    generator.add(new Pokemon(pokemon[i],types.get(i)));
  }
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
    textSize(45);
    textAlign(CENTER, CENTER);
    text("Gamemode(s)", width/2, height/6);
    
    shapeMode(CORNER);
    fill(255, 0, 0);
    rect(width/2 - 100, height/2 - 15, 200, 30);
    fill(0);
    textSize(25);
    text("Endless", width/2, height/2);
    
    fill(255, 0, 0);
    
    rect(width/2 - 100, height * 0.55 - 15, 200, 30);
    fill(0);
    textSize(25);
    text("Time Trial", width/2, height * 0.55);
    
    if (mouseY >= height/2 - 15 && mouseY < height/2 + 15 && mouseX > width/2 - 100 && mouseX < width/2 + 100) {
      PImage msgBox = loadImage("messageBox.png");
      msgBox.resize(msgBox.width/2, msgBox.height/2 + 25);
      image(msgBox, width/2, height * 0.82);
      text("Play until you lose.", width/2, height * 0.8);
      textSize(15);
      text("Bosses get progressively harder. \nOption to change party every 5 levels", width/2, height * 0.85);
    }
    
    if (mouseY >= height * 0.55 - 15 && mouseY < height * 0.55 + 15 && mouseX > width/2 - 100 && mouseX < width/2 + 100) {
      PImage msgBox = loadImage("messageBox.png");
      msgBox.resize(msgBox.width/2, msgBox.height/2 + 25);
      image(msgBox, width/2, height * 0.82);
      text("Short on time?", width/2, height * 0.8);
      textSize(15);
      text("Unlimited moves. \nLimited time. Get score. (WIP)", width/2, height * 0.85);
    }
    
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
      party.get(i).display(width/2 - 150 + 100 * i, height/3, 100);
      
    }
    for (int i = 0; i < generator.size(); i++) {
      if (i<4){
        generator.get(i).display(100 + 125*i, 520, 144);
      }
      else{
        generator.get(i).display(100 + 125*(i%4), 520+144, 144);
      }
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
        if (stage % 5 == 0) {
          partySelect = true;
        }
        stage++;
        test=new Board(99, stage, party, mode);
        //just for testing, actual game over should probably send to start menu
      }
    }
    else if (test.gameOver){
      if (mouseX<=360&&mouseX>=180&&mouseY>=500-100&&mouseY<=580-100){
        stage = 1;
        test=new Board(99, stage, party, mode);
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
      mode = 0;
    }
    if (mouseY > (height * 0.55) - 15 && mouseY < (height * 0.55) + 15 && mouseX > (width/2) - 100 && mouseX < (width/2) + 100) {
      partySelect = true;
      modeSelect = false;
      mode = 1;
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
        row=mouseY/520;
        col=col+row;
        if (!containDupe(generator.get(col), party)) {
          party.add(generator.get(col));
        }
      }
    }
    else if (mouseY > height/3 - 50 && mouseY < height/3 + 50 && mouseX > width/2 - 200 && mouseX < width / 2 + 200) {
      if (party.size() > 0) {
        col = (mouseX - (width/2 - 200)) / 100;
        if (col < party.size()) {
          party.remove(col);
        }
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
  test = new Board(99, stage, party, mode); // set to 1 to test game over
  test.display();
}

boolean containDupe(Pokemon input, ArrayList<Pokemon> test) {
  for (int i = 0; i < test.size(); i++) {
    if (input == test.get(i)) return true;
  }
  return false;
}
