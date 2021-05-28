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
    
}
