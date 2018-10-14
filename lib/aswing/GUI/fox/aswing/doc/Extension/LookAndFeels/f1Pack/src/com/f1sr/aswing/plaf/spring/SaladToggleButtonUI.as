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

import com.f1sr.aswing.plaf.spring.SaladButtonUI;


class com.f1sr.aswing.plaf.spring.SaladToggleButtonUI extends BasicToggleButtonUI{
	
	
    
    public function SaladToggleButtonUI(){
    	super();
    }
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	if(com.isOpaque())
    	{
	    	var c:AbstractButton = AbstractButton(com);
			if(c.getModel().isSelected() || c.getModel().isPressed())
			{
				
	    		g.fillRectangle(new SolidBrush(UIManager.getColor("control")), b.x, b.y, b.width, b.height);
	    		//ButtonUI.paintLAFButtonBackGround(c, g, b);
	    	
			}
			else
			{
				
				SaladButtonUI.paintSaladLAFButtonBackGround(c, g, b);
			}
			
    	}
    	
    	
    }    
}
