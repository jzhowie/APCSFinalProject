public class Boss{

  private int neededScore;
  private String type;
  
  Boss(int score, String element){
    neededScore=score;
    type=element;
  }
  
  public int getNeededScore(){
    return neededScore;
  }
  
  public String getType() {
    return type;
  }
  
  public void setType(String element){
    type=element;
  }
  
  public void display(int score) {
    display();
    
    fill(#64454D);
    rect(width/2 - 107, height/5 + 120, 214, 20);
    
    //actual bar
    fill(#FC527C);
    rect(width/2 - 100, height/5 + 125, 200 - (200 * score / getNeededScore()), 10);
    
    fill(0);
    textSize(15);
    textAlign(CENTER, CENTER);
    text("HP", width/2 - 130, height/5 + 127);
  }
  
  private String getName(){
    if (type.equals("Normal")){
      return "Snorlax";
    }
    if (type.equals("Fighting")){
      return "Machamp";
    }
    if (type.equals("Flying")){
      return "Pidgeotto";
    }
    if (type.equals("Poison")){
      return "Weezing";
    }
    if (type.equals("Ground")){
      return "Sandshrew";
    }
    if (type.equals("Rock")){
      return "Geodude";
    }
    if (type.equals("Bug")){
      return "Butterfree";
    }
    if (type.equals("Fire")){
      return "Moltres";
    }
    if (type.equals("Water")){
      return "Starmie";
    }
    if (type.equals("Grass")){
      return "Scyther";
    }
    if (type.equals("Electric")){
      return "Zapdos";
    }
    if (type.equals("Psychic")){
      return "Mewtwo";
    }
    if (type.equals("Ice")){
      return "Articuno";
    }
    if (type.equals("Dragon")){
      return "Dragonite";
    }
    
    return "Pikachu";
  }
  
  public void display() {
    noStroke();
    String imgName=getName()+".png";
    PImage boss = loadImage(imgName);
    image(boss, width/2, height/5);
    
    textSize(15);
    textAlign(CENTER, CENTER);
    text(getName()+"\n "+getType()+" Type", width/2 , height/5 - 127);
    //shapeMode(CORNER);
    //fill(#F5FC24);
    //rect(width/2 - 75, height/5 - 75, 150, 150);
  }
  
  public void modifyBoard(Pokemon[][] t) {
      for (int i = 0; i < t.length; i++) {
        if (getType().equals("Water") || getType().equals("Dragon") || getType().equals("Ice") || getType().equals("Poison"))  {
          if (!t[i][t.length-1].isEmpty()) t[i][t.length-1-i].setFrozen(true);
        }
        if (getType().equals("Flying") || getType().equals("Electric") || getType().equals("Normal") || getType().equals("Grass") || getType().equals("Bug") || getType().equals("Rock")) {
          t[i][0].setRock();
        }
        if (getType().equals("Fighting") || getType().equals("Psychic") || getType().equals("Steel") || getType().equals("Ground") || getType().equals("Fire")) {
          t[i][i].setBlock();
        }
      }
  }
    
}
