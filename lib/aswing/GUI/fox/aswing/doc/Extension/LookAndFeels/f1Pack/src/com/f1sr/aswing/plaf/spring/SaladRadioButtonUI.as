/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicRadioButtonUI;
import org.aswing.plaf.ComponentUI;
 

class com.f1sr.aswing.plaf.spring.SaladRadioButtonUI extends BasicRadioButtonUI{
	/*shared instance*/
	private static var saladRadioButtonUI:SaladRadioButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(saladRadioButtonUI == null){
    		saladRadioButtonUI = new SaladRadioButtonUI();
    	}
        return saladRadioButtonUI;
    }
    
    public function SaladRadioButtonUI(){
    	super();
    }	
}
