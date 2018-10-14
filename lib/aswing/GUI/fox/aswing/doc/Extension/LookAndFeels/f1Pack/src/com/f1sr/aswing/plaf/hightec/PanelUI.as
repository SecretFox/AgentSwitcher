/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicPanelUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.PanelUI;
 

class com.f1sr.aswing.plaf.hightec.PanelUI extends BasicPanelUI{
	/*shared instance*/
	private static var panelUI:PanelUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(panelUI == null){
    		panelUI = new PanelUI();
    	}
        return panelUI;
    }
    
    public function PanelUI(){
    	super();
    }	
}
