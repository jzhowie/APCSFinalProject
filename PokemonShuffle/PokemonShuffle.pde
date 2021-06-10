Board test;
int row;
int col;
int stage;
int mode;
boolean start;
boolean modeSelect;
boolean partySelect;
boolean levelSelect;
boolean tempLevel;
ArrayList<Pokemon> generator;
ArrayList<Pokemon> party;
ArrayList<Pokemon> levels;
ArrayList<String> types;


void setup() {
  size(576, 1024);
  start = true;
  stage = 1;
  types = new ArrayList<String>(Arrays.asList(new String[] {"Fire","Grass","Dragon","Water","Normal","Flying","Electric","Ground"}));
  String[] pokemon = {"Charmander", "Bulbasaur", "Dratini", "Squirtle","Raticate","Pidgeotto","Pikachu","Sandshrew"};
  String[] bosses = {"Butterfree","Moltres", "Scyther", "Starmie"};
  String[] bossTypes={"Bug","Fire","Grass","Water"};
  generator = new ArrayList<Pokemon>();
  party = new ArrayList<Pokemon>();
  levels = new ArrayList<Pokemon>();
  for (int i = 0; i < 8; i++) {
    generator.add(new Pokemon(pokemon[i],types.get(i)));

  }
  for (int i = 0; i < 8; i++) {
    if (generator.get(i).getType().equals("Fire")||generator.get(i).getType().equals("Water")){
      generator.get(i).setCanMega(true);
    }
  }
  for (int i=0;i<bosses.length;i++){
      levels.add(new Pokemon(bosses[i],bossTypes[i])); //TEMP FOR LEVELS
   }
}

void draw() {
  // starting screen hopefully
  PImage back=loadImage("Back.png");
  back.resize(76,76);
  
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
    image(back,576-38,76);
    background(255);
    fill(0);
    noStroke();
    textSize(45);
    textAlign(CENTER, CENTER);
    text("Gamemode(s)", width/2, height/6);
    
    shapeMode(CORNER);
    
    fill(#B655DE);
    rect(width/2 - 200, height * 0.4 - 40, 400, 80);
    fill(0);
    textSize(35);
    text("Endless", width/2, height * 0.4);
    
    fill(#4E93EA);
    rect(width/2 - 200, height * 0.55 - 40, 400, 80);
    fill(0);
    textSize(35);
    text("Time Trial", width/2, height * 0.55);
    
    fill(#DB9237);
    rect(width/2 - 200, height * 0.70 - 40, 400, 80);
    fill(0);
    textSize(35);
    text("Level Select", width/2, height * 0.7);
    
    textSize(25);
    if (mouseY >= height * 0.4 - 40 && mouseY < height * 0.4 + 40 && mouseX > width/2 - 200 && mouseX < width/2 + 200) {
      PImage msgBox = loadImage("messageBox.png");
      msgBox.resize((int) (msgBox.width * 0.6), (int) (msgBox.height * 0.6));
      image(msgBox, width/2, height * 0.9);
      text("Play until you lose.", width/2, height * 0.88);
      textSize(15);
      text("Bosses get progressively harder. \nOption to change party every 5 levels", width/2, height * 0.93);
    }
    
    if (mouseY >= height * 0.55 - 40 && mouseY < height * 0.55 + 40 && mouseX > width/2 - 200 && mouseX < width/2 + 200) {
      PImage msgBox = loadImage("messageBox.png");
      msgBox.resize((int) (msgBox.width * 0.6), (int) (msgBox.height * 0.6));
      image(msgBox, width/2, height * 0.9);
      text("Short on time?", width/2, height * 0.88);
      textSize(15);
      text("Unlimited moves. \nLimited time. Get score. (WIP)", width/2, height * 0.93);
    }
    
    if (mouseY >= height * 0.7 - 40 && mouseY < height * 0.7 + 40 && mouseX > width/2 - 200 && mouseX < width/2 + 200) {
      PImage msgBox = loadImage("messageBox.png");
      msgBox.resize((int) (msgBox.width * 0.6), (int) (msgBox.height * 0.6));
      image(msgBox, width/2, height * 0.9);
      text("Progressive playthrough!", width/2, height * 0.88);
      textSize(15);
      text("Beat Pokemon that continuously get stronger. \nLimited time. Battle a boss at the end of a world. (WIP)", width/2, height * 0.93);
    }
    
  }
  else if (partySelect) {
    
    background(255);
    fill(0);
    noStroke();
    textSize(35);
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
       generator.get(i).display(72+144* (i % 4) , 520 + 144 * (i / 4), 144);
    }
    if (mouseY > 448 && mouseY < 448 + 288 && mouseX > 0 && mouseX < width){
      col = mouseX / 144;
      row=(mouseY - 448) /144;
      col=col+row*4;
      String type = generator.get(col).getType();
      String name = generator.get(col).getPokemonName();
      textSize(25);
      fill(0);
      textAlign(CENTER, CENTER);
      text(name+": "+type+" Type", 576/2,425);
    }
    // Confirm?
    textSize(25);
    fill(#55F766);
    rect(width/2 - 75, height * (0.85) - 30, 150, 60);
    fill(0);
    text("Confirm", width/2, height * (0.85));
    image(back,576-38,76);
  }
  else if (levelSelect){

    shapeMode(CORNER);
    background(255);
    fill(0);
    noStroke();
    textSize(25); //n needs tweaking
    textAlign(CENTER, CENTER);
    image(back,576-38,76);
    imageMode(CENTER);
    PImage title = loadImage("TitleScreen.png");
    title.resize(title.width/2, title.height/2);
    image(title, width/2, (int)(height/12));
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Levels:", 576/2,225);
    for (int i = 0; i < levels.size(); i++) {
      levels.get(i).display(72+144* (i % 4) , height/3, 144);      
    }
    if (mouseY > height/3-100 && mouseY < height/3 + 100 && mouseX > 0 && mouseX < width ){
      col = mouseX/144;
      row=(mouseY - height/3) /100;
      String type = levels.get(col).getType();
      String name = levels.get(col).getPokemonName();
      textSize(25);
      fill(0);
      textAlign(CENTER, CENTER);
      text("Level "+(col+1)+": "+name, 576/2,425);
    }
  }
  else {
    test.display();
  }
}

// orb moving during board
void mousePressed() {
  if (!start && !modeSelect && !partySelect && !levelSelect) {
    if (mouseY > 448 && mouseY < 1024 && mouseX > 0 && mouseX < 576) { // and if game started
      row = (mouseY - 448) / 96;
      col = mouseX / 96;
      //println(row + ", " + col);
      test.getPokemon(row, col).setSelect(true);
      
      if (test.getPokemon(row, col).isFrozen() || test.getPokemon(row, col).isRock() || test.getPokemon(row, col).isBlock()) {
        test.getPokemon(row, col).setSelect(false);
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
    if (mouseY >= height * 0.4 - 40 && mouseY < height * 0.4 + 40 && mouseX > width/2 - 200 && mouseX < width/2 + 200) {
      partySelect = true;
      modeSelect = false;
      mode = 0;
    }
    if (mouseY >= height * 0.55 - 40 && mouseY < height * 0.55 + 40 && mouseX > width/2 - 200 && mouseX < width/2 + 200) {
      partySelect = true;
      modeSelect = false;
      mode = 1;
    }
    if (mouseY >= height * 0.7 - 40 && mouseY < height * 0.7 + 40 && mouseX > width/2 - 200 && mouseX < width/2 + 200){
      partySelect = false;
      modeSelect = false;
      levelSelect = true;
      mode = 2;
    }
  }

  else if (partySelect) {
    if (mouseY > height * 0.85 - 30 && mouseY < height * 0.85 + 30 && mouseX > (width/2) - 75 && mouseX < (width/2) + 75 && party.size() == 4) {
      partySelect = false;
      boardSetup(); // parameter for mode?
    }
    else if (mouseY > 0 && mouseY < 150 && mouseX > 500-76 && mouseX < width&&tempLevel==false) {
       partySelect=false;
       modeSelect=true;
    }
    else if (mouseY > 0 && mouseY < 150 && mouseX > 500-76 && mouseX < width&&tempLevel) {
       partySelect=false;
       levelSelect=true;
       tempLevel=false;
    }
    else if (mouseY > 448 && mouseY < 448 + 288 && mouseX > 0 && mouseX < width) {
      if (party.size() < 4) {
        col = mouseX / 144;
        row=(mouseY - 448) /144;
        col=col+row*4;
        if (!containDupe(generator.get(col), party)&&getMegas(party)==0) {
          if (generator.get(col).canMega()){
             party.add(generator.get(col));
             
          }
        }
        if (!containDupe(generator.get(col), party)&&getMegas(party)==1){
          if (!generator.get(col).canMega()){
             party.add(generator.get(col));
          }
          if (generator.get(col).canMega()){
             party.add(generator.get(col));
             party.remove(generator.get(col));
          }
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
  else if (levelSelect){
    if (mouseY > height/3-100 && mouseY < height/3 + 100 && mouseX > 0 && mouseX < width ){
      col = mouseX/144;
      row=(mouseY - height/3) /100;
      partySelect=true;
      String type=levels.get(col).getType();
      boardSetup(levels.get(col).getType());
      levelSelect=false;
      tempLevel=true;
    }
    else if (mouseY > 0 && mouseY < 150 && mouseX > 500-76 && mouseX < width) {
       levelSelect=false;
       modeSelect=true;
    }
  }
  else {
    if (test.win) {
      if (mouseX<=width/2 + 90&&mouseX>=width/2 - 90 &&mouseY>= 450 - 40&&mouseY<= 450 + 40){
        if (mode==0){ 
          if (stage % 5 == 0) {
            partySelect = true;
          }
          stage++;
          test=new Board(99, stage, party, mode);
          //just for testing, actual game over should probably send to start menu
        }
        if (mode==2){
          levelSelect=true;
        }
      }
    }
    else if (test.gameOver){
      if (mouseX<=width/2 + 90&&mouseX>=width/2 - 90 &&mouseY>= 450 - 40&&mouseY<= 450 + 40){
        stage = 1;
        modeSelect = true;
        //just for testing, actual game over should probably send to start menu
      }
    }
    else {
      int prevRow = row;
      int prevCol = col;
      if (test.getPokemon(prevRow, prevCol).isFrozen() || test.getPokemon(prevRow, prevCol).isRock() || test.getPokemon(prevRow, prevCol).isBlock()) {
        test.getPokemon(prevRow, prevCol).setSelect(false);
      }
      else if (mouseY >= 448 && mouseY < 1024 && mouseX > 0 && mouseX < 576) {
        test.getPokemon(row, col).setSelect(false);
        try {
          test.swap(prevRow, prevCol, (mouseY - 448) / 96, mouseX / 96);
          if (!test.check3Combo() || test.getPokemon(prevRow, prevCol).isFrozen() || test.getPokemon((mouseY - 448) / 96, mouseX / 96).isFrozen() || test.getPokemon(prevRow, prevCol).isRock() || test.getPokemon((mouseY - 448) / 96, mouseX / 96).isRock() || test.getPokemon(prevRow, prevCol).isBlock() || test.getPokemon((mouseY - 448) / 96, mouseX / 96).isBlock()) {
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
}



void boardSetup() {
  test = new Board(99, stage, party, mode); // set to 1 to test game over
  test.display();
}

void boardSetup(String bossType) {
  test = new Board(25, stage, party, mode,bossType); // set to 1 to test game over
  
}

boolean containDupe(Pokemon input, ArrayList<Pokemon> test) {
  for (int i = 0; i < test.size(); i++) {
    if (input == test.get(i)) return true;
  }
  return false;
}

int getMegas(ArrayList<Pokemon> party){
  int count=0;
  for (Pokemon p:party){
    if (p.canMega()){
      count++;
    }
  }
  return count;
}
