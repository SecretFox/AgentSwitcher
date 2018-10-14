/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicButtonUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.ComenyButtonUI extends BasicButtonUI {
	
	/*shared instance*/
	private static var comenyButtonUI:ComenyButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(comenyButtonUI == null){
    		comenyButtonUI = new ComenyButtonUI();
    	}
        return comenyButtonUI;
    }
    
    public function ComenyButtonUI(){
    	super();
    }
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	var c:AbstractButton = AbstractButton(com);
    	paintASWingLAFButtonBackGround(c, g, b);
    }
    
    public static function paintASWingLAFButtonBackGround(c:AbstractButton, g:Graphics, b:Rectangle):Void{
    	b = b.clone();
    	b.width -= 1;
    	b.height -= 1;
		var bgColor:ASColor = (c.getBackground() == null ? UIManager.getColor("control") : c.getBackground());
		var shadow:ASColor = UIManager.getColor("Button.shadow");
		var light:ASColor = UIManager.getColor("Button.light");
		
		if(c.isOpaque()){
			var r:Number = b.height/2;
			if(!c.isEnabled()){
				b.move(1, 1);
				g.fillRoundRect(new SolidBrush(bgColor), b.x, b.y, b.width, b.height, r);
				return;
			}
			if(c.getModel().isPressed() || c.getModel().isSelected()){
				b.move(1, 1);
				g.fillRoundRect(new SolidBrush(light), b.x, b.y, b.width, b.height, r);
				return;
			}
			if(c.getModel().isRollOver()){
				b.move(1, 1);
				g.fillRoundRect(new SolidBrush(shadow), b.x, b.y, b.width, b.height, r);
				b.move(-1, -1);
				g.fillRoundRect(new SolidBrush(light), b.x, b.y, b.width, b.height, r);
			}else{
				b.move(1, 1);
				g.fillRoundRect(new SolidBrush(shadow), b.x, b.y, b.width, b.height, r);
				b.move(-1, -1);
				g.fillRoundRect(new SolidBrush(bgColor), b.x, b.y, b.width, b.height, r);
			}
		}    	
    }
	
}