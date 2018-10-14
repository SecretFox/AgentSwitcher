/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.Component;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.JWindow;
import org.aswing.plaf.basic.BasicWindowUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.grey.GreyWindowUI extends BasicWindowUI
{
	/*shared instance*/
	private static var greyWindowUI:GreyWindowUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(greyWindowUI == null){
    		greyWindowUI = new GreyWindowUI();
    	}
        return greyWindowUI;
    }
    
    public function GreyWindowUI(){
    	super();
    }
	
    public function create(c:Component):Void
    {
    	var window:JWindow = JWindow(c);
    	var modalMC:MovieClip = window.getModalMC();
		var g:Graphics = new Graphics(modalMC);
		g.fillRectangle(new SolidBrush(UIManager.getColor("Window.modalColor").getRGB(), 100), 0, 0, 1, 1);
		
    	window.resetModalMC();
    }    
 	
	
}
