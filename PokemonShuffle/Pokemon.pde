public class Pokemon{
  
  private int temp;
  private String type;
  private boolean selected;
  
  Pokemon(String element){
    selected=false;
    type=element;
  }
   
  public String getType(){
    return type;
  }
  
  public int getTemp(){
    return temp;  
  }
  
  public boolean isSelected(){
    return selected;
  }
 
}
