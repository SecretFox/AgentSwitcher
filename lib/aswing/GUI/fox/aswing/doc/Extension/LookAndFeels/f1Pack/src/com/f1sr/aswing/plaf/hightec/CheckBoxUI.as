/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicCheckBoxUI;
import org.aswing.plaf.ComponentUI;
 

class com.f1sr.aswing.plaf.hightec.CheckBoxUI extends BasicCheckBoxUI{
	/*shared instance*/
	private static var sCheckBoxUI:CheckBoxUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(sCheckBoxUI == null){
    		sCheckBoxUI = new CheckBoxUI();
    	}
        return sCheckBoxUI;
    }
    
    public function CheckBoxUI(){
    	super();
    }	
}
