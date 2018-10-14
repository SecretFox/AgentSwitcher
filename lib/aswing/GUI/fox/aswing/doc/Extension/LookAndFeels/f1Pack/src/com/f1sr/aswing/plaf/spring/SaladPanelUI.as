/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicPanelUI;
import org.aswing.plaf.ComponentUI;
 

class com.f1sr.aswing.plaf.spring.SaladPanelUI extends BasicPanelUI{
	/*shared instance*/
	private static var saladPanelUI:SaladPanelUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(saladPanelUI == null){
    		saladPanelUI = new SaladPanelUI();
    	}
        return saladPanelUI;
    }
    
    public function SaladPanelUI(){
    	super();
    }	
}
