/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicRadioButtonUI;
import org.aswing.plaf.ComponentUI;
 

class com.f1sr.aswing.plaf.office2003.RadioButtonUI extends BasicRadioButtonUI{
	/*shared instance*/
	private static var sRadioButtonUI:RadioButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(sRadioButtonUI == null){
    		sRadioButtonUI = new RadioButtonUI();
    	}
        return sRadioButtonUI;
    }
    
    public function RadioButtonUI(){
    	super();
    }	
}
