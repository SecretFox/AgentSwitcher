/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicCheckBoxUI;
import org.aswing.plaf.ComponentUI;
 

class com.f1sr.aswing.plaf.spring.SaladCheckBoxUI extends BasicCheckBoxUI{
	/*shared instance*/
	private static var saladCheckBoxUI:SaladCheckBoxUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(saladCheckBoxUI == null){
    		saladCheckBoxUI = new SaladCheckBoxUI();
    	}
        return saladCheckBoxUI;
    }
    
    public function SaladCheckBoxUI(){
    	super();
    }	
}
