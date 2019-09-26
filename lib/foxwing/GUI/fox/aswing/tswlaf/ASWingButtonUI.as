/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.AbstractButton;
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.plaf.asw.ASWingGraphicsUtils;
import GUI.fox.aswing.tswlaf.BasicButtonUI;
import GUI.fox.aswing.plaf.ComponentUI;
 
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.tswlaf.ASWingButtonUI extends BasicButtonUI{
	/*shared instance*/
	private static var asWingButtonUI:ASWingButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(asWingButtonUI == null){
    		asWingButtonUI = new ASWingButtonUI();
    	}
        return asWingButtonUI;
    }
    
    public function ASWingButtonUI(){
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
		var bgColor:ASColor = (c.getBackground() == null ? ASColor.WHITE : c.getBackground());

		if(c.isOpaque()){
			if(c.getModel().isPressed() || c.getModel().isSelected()){
				g.fillRectangle(new SolidBrush(bgColor), b.x, b.y, b.width, b.height);
				return;
			}
			ASWingGraphicsUtils.drawControlBackground(g, b, bgColor, Math.PI/2);
		}    	
    }
	
}
