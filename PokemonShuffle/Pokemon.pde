public class Pokemon{
  
  private String type;
  private boolean selected;
  
  Pokemon(String element){
    selected=false;
    type=element;
  }
   
  public String getType(){
    return type;
  }
  
  public boolean isSelected(){
    return selected;
  }
 
}
