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
    shapeMode(CORNER);
    fill(#F5FC24);
    rect(width/2 - 75, height/5 - 75, 150, 150);
    
    fill(#64454D);
    rect(width/2 - 107, height/5 + 120, 214, 20);
    
    //actual bar
    fill(#FC527C);
    rect(width/2 - 100, height/5 + 125, 200 - (200 * score / getNeededScore()), 10);
    
    fill(0);
    textSize(15);
    textAlign(CENTER, CENTER);
    text("HP", width/2 - 130, height/5 + 127);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(getType(), width/2 , height/5 - 127);
  }
    
}
