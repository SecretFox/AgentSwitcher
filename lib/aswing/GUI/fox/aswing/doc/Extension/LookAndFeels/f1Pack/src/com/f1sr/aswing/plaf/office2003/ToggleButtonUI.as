/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.AbstractButton;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicToggleButtonUI;
import org.aswing.UIManager;

import com.f1sr.aswing.plaf.office2003.ButtonUI;

 
class com.f1sr.aswing.plaf.office2003.ToggleButtonUI extends BasicToggleButtonUI{
	/*shared instance*/
	
    
    public function ToggleButtonUI(){
    	super();
    }
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	if(com.isOpaque()){
	    	var c:AbstractButton = AbstractButton(com);
			if(c.getModel().isSelected() || c.getModel().isPressed())
			{
				
	    		g.fillRectangle(new SolidBrush(UIManager.getColor("control").brighter(0.2)), b.x, b.y, b.width, b.height);
	    		
	    		//ButtonUI.paintLAFButtonBackGround(c, g, b);
	    		
			}
			else
			{
				ButtonUI.paintLAFButtonBackGround(c, g, b);
				
			}
			
    	}
    	
    	
    }    
}
