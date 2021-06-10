public class Pokemon{
  
  private int pNum;
  private String type;
  private boolean selected;
  private boolean frozen;
  private boolean rock;
  private boolean block;
  private boolean isMega;
  private int blockTurns;
  private String name;
  private int megaCounter;
  private int megaMax;
  
  Pokemon(String element, int temporary){
    selected=false;
    frozen = false;
    rock = false;
    block = false;
    pNum=temporary;
    type=element;
  }
  
  Pokemon(String n) {
    selected = false;
    frozen = false;
    rock = false;
    block = false;
    name = n;
    pNum = 0;
    setType();
  }
  
  Pokemon(String n, String t) {
    selected = false;
    frozen = false;
    rock = false;
    block = false;
    name = n;
    type=t;
    pNum = 0;
    setType();
  }
   
  public String getType() { return type; }
  public void setType(String newType) { type=newType; }
  
  public String getPokemonName() { return name; }
  
  public int getPNum() { return pNum; }
  public void setPNum(int newTemp) { pNum=newTemp; }
  
  public boolean isSelected() { return selected; }
  public void setSelect(boolean s) { selected = s; }
  
  public boolean isFrozen() { return frozen; }
  public boolean isEmpty() { return pNum == -4; }
  public void toggleFrozen() { frozen = !frozen; }
  public void setFrozen(boolean f) { frozen = f; }
  
  public boolean isRock() { return rock; }
  
  public boolean isBlock() { return block; }
  public int getBlockTurns() { return blockTurns; }
  public void decrementBlockTurns() { blockTurns--; }
  public boolean isMega(){ return isMega; }
  public void increaseMegaCounter(){megaCounter++;}
  public void checkMega(){ 
    if (megaCounter>=megaMax){
      isMega=true;
    } 
  }
    
  
  private void setType() {
    if (name.equals("Charmander")) { type = "Fire"; pNum = 0; }
    if (name.equals("Bulbasaur")) { type = "Grass"; pNum = 1; }
    if (name.equals("Dratini")) { type = "Dragon"; pNum = 2; }
    if (name.equals("Squirtle")) { type = "Water"; pNum = 3; }
    if (name.equals("Raticate")) { type = "Normal"; pNum = 4; }
    if (name.equals("Pidgeotto")) { type = "Flying"; pNum = 5; }
    if (name.equals("Pikachu")) { type = "Electric"; pNum = 6; }
    if (name.equals("Sandshrew")) { type = "Ground"; pNum = 7; }
  }
  
  public void setRock() {
    pNum = -2;
    name = "Rock";
    rock = true;
  }
  
  public void setBlock() {
    pNum = -3;
    name = "Block";
    block = true;
    blockTurns = 5;
  }
  
  public void setEmpty() {
    pNum = -4;
    name = "Empty";
  }
  
  public PImage getPImage(int s){
    PImage pic=loadImage(getPokemonName()+".png");
    pic.resize(s, s);
    return pic;
  }
  
  //Very slow when displaying board b/c you are loading 36 PIamges opposed to 4
  public void display(int x, int y, int s) {
    PImage pic = loadImage(getPokemonName() + ".png");
    pic.resize(s, s);
    image(pic, x, y);
  }
  
  public void setName(String newName){
    name=newName;
  }
 
  public float effectiveness(String bossElement){
    if (this.type.equals("Normal")){
      if (bossElement.equals("Rock")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Fighting")){
      if (bossElement.equals("Normal")){
        return 2;
      }
      if (bossElement.equals("Flying")){
        return 0.5;
      }
      if (bossElement.equals("Poison")){
        return 0.5;
      }
      if (bossElement.equals("Rock")){
        return 2;
      }
      if (bossElement.equals("Bug")){
        return 0.5;
      }
      if (bossElement.equals("Psychic")){
        return 0.5;
      }
      if (bossElement.equals("Ice")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Flying")){
      if (bossElement.equals("Fighting")){
        return 2;
      }
      if (bossElement.equals("Rock")){
        return 0.5;
      }
      if (bossElement.equals("Bug")){
        return 2;
      }
      if (bossElement.equals("Grass")){
        return 2;
      }
      if (bossElement.equals("Electric")){
        return 0.5;
      }
      return 1;
    }
    
    if (this.type.equals("Poison")){
      if (bossElement.equals("Poison")||bossElement.equals("Ground")||
        bossElement.equals("Rock")){
        return 0.5;
      }
      if (bossElement.equals("Bug")||bossElement.equals("Grass")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Ground")){
      if (bossElement.equals("Bug")||bossElement.equals("Grass")){
        return 0.5;
      }
      if (bossElement.equals("Poison")||bossElement.equals("Rock")||
      bossElement.equals("Fire")||bossElement.equals("Electric")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Rock")){
      if (bossElement.equals("Fighting")||bossElement.equals("Ground")){
        return 0.5;
      }
      if (bossElement.equals("Flying")||bossElement.equals("Bug")||
      bossElement.equals("Fire")||bossElement.equals("Ice")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Bug")){
      if (bossElement.equals("Fighting")||bossElement.equals("Flying")||
      bossElement.equals("Fire")){
        return 0.5;
      }
      if (bossElement.equals("Poison")||bossElement.equals("Grass")||
      bossElement.equals("Psychic")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Fire")){
      if (bossElement.equals("Rock")||bossElement.equals("Fire")||
      bossElement.equals("Water")||bossElement.equals("Dragon")){
        return 0.5;
      }
      if (bossElement.equals("Bug")||bossElement.equals("Grass")||
      bossElement.equals("Ice")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Water")){
      if (bossElement.equals("Water")||bossElement.equals("Grass")||
      bossElement.equals("Dragon")){
        return 0.5;
      }
      if (bossElement.equals("Ground")||bossElement.equals("Rock")||
      bossElement.equals("Fire")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Grass")){
      if (bossElement.equals("Flying")||bossElement.equals("Poison")||
      bossElement.equals("Bug")||bossElement.equals("Fire")||bossElement.equals("Grass")
      ||bossElement.equals("Dragon")){
        return 0.5;
      }
      if (bossElement.equals("Ground")||bossElement.equals("Rock")||
      bossElement.equals("Water")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Electric")){
      if (bossElement.equals("Grass")||bossElement.equals("Electric")||
      bossElement.equals("Dragon")){
        return 0.5;
      }
      if (bossElement.equals("Flying")||bossElement.equals("Water")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Psychic")){
      if (bossElement.equals("Fighting")||bossElement.equals("Ground")){
        return 0.5;
      }
      if (bossElement.equals("Psychic")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Ice")){
      if (bossElement.equals("Water")||bossElement.equals("Ice")){
        return 0.5;
      }
      if (bossElement.equals("Flying")||bossElement.equals("Ground")||
      bossElement.equals("Grass")||bossElement.equals("Dragon")){
        return 2;
      }
      return 1;
    }
    if (this.type.equals("Dragon")){
      if (bossElement.equals("Dragon")){
        return 2;
      }
      return 1;
    }
    return 1;
  }
 
}
