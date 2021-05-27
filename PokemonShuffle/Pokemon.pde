public class Pokemon{
  
  private int pNum;
  private String type;
  private boolean selected;
  
  Pokemon(String element, int temporary){
    selected=false;
    pNum=temporary;
    type=element;
  }
   
  public String getType(){
    return type;
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
 
}
