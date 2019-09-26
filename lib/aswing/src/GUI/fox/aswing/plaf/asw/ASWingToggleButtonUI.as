/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.AbstractButton;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.plaf.basic.BasicToggleButtonUI;
import GUI.fox.aswing.plaf.ComponentUI;
 
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingToggleButtonUI extends BasicToggleButtonUI{
	/*shared instance*/
	private static var asWingToggleButtonUI:ASWingToggleButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(asWingToggleButtonUI == null){
    		asWingToggleButtonUI = new ASWingToggleButtonUI();
    	}
        return asWingToggleButtonUI;
    }
    
    public function ASWingToggleButtonUI(){
    	super();
    }
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	if(com.isOpaque()){
	    	var c:AbstractButton = AbstractButton(com);
			if(c.getModel().isSelected() || c.getModel().isPressed()){
	    		g.fillRectangle(new SolidBrush(com.getBackground().darker(0.9)), b.x, b.y, b.width, b.height);
			}else{
				GUI.fox.aswing.plaf.asw.ASWingButtonUI.paintASWingLAFButtonBackGround(c, g, b);
			}
    	}
    }    
}
