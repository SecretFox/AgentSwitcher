/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.Icon;
import org.aswing.plaf.basic.BasicTabbedPaneUI;
import org.aswing.plaf.basic.icon.ArrowIcon;
import org.aswing.plaf.ComponentUI;


class com.f1sr.aswing.plaf.spring.SaladTabbedPaneUI extends BasicTabbedPaneUI {
	

	private static var saladTabbedPaneUI:SaladTabbedPaneUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(saladTabbedPaneUI == null){
    		saladTabbedPaneUI = new SaladTabbedPaneUI();
    	}
        return saladTabbedPaneUI;
    }
	
	public function SaladTabbedPaneUI() {
		super();
	}

    
	
    private function createArrowIcon(direction:Number, enable:Boolean):Icon{
    	var icon:Icon;
    	if(enable){
    		icon = new ArrowIcon(direction, 12,
				    new ASColor(0x000000,100),
				   new ASColor(0x085004,100),
				   new ASColor(0xEAFFA2,100),
				    new ASColor(0xFF0000,100));
    	}else{
    		icon = new ArrowIcon(direction, 12,
				    new ASColor(0x000000,100),
				   new ASColor(0xEAFFA2,100),
				   new ASColor(0x085004,100),
				    new ASColor(0xFF0000,100));
    	}
		return icon;
    }
        

}