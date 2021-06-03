public class Pokemon{
  
  private int pNum;
  private String type;
  private boolean selected;
  private String name;
  
  Pokemon(String element, int temporary){
    selected=false;
    pNum=temporary;
    type=element;
  }
  
  Pokemon(String n) {
    selected = false;
    name = n;
    pNum = 0;
    setType();
  }
  Pokemon(String n, String t) {
    selected = false;
    name = n;
    type=t;
    pNum = 0;
    setType();
  }
   
  public String getType(){
    return type;
  }
  
  public String getPokemonName(){
    return name;
  }
  
  public int getPNum(){
    return pNum;  
  }
  
  public void setPNum(int newTemp){
    pNum=newTemp;
  }
  
  public boolean isSelected(){
    return selected;
  }
  
  public void toggleSelect() {
    selected = !selected;
  }
  
  private void setType() {
    if (name.equals("Charmander")) { type = "Grass"; pNum = 0; }
    if (name.equals("Bulbasaur")) { type = "Water"; pNum = 1; }
    if (name.equals("Dratini")) { type = "Fire"; pNum = 2; }
    if (name.equals("Squirtle")) { type = "Ice"; pNum = 3; }
  }
  
  public void setType(String newType){
    type=newType;
  }
  
  public PImage getPImage(){
    String picName=getPokemonName()+".png";
    PImage pic=loadImage(picName);
    pic.resize(120,120);
    return pic;
  }
  
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
