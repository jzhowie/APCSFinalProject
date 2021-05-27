public class Pokemon{
  
  private int temp;
  private String type;
  private boolean selected;
  
  Pokemon(String element, int temporary){
    selected=false;
    temp=temporary;
    type=element;
  }
   
  public String getType(){
    return type;
  }
  
  public int getTemp(){
    return temp;  
  }
  
  public void setTemp(int newTemp){
    temp=newTemp;
  }
  
  public boolean isSelected(){
    return selected;
  }
 
}
