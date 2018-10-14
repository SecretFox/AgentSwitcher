/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.Insets;
import org.aswing.plaf.basic.frame.TitleBarUI;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.frame.ComenyTitleBarUI extends TitleBarUI {
	
	//can't share instance
    public function ComenyTitleBarUI(){
    	super();
    }
    
	private function installComponents() : Void {
		super.installComponents();
		var insets:Insets = new Insets(0, 0, 0, 0);
		iconifiedButton.setOpaque(false);
		iconifiedButton.setMargin(insets);
		resizeButton.setOpaque(false);
		resizeButton.setMargin(insets);
		closeButton.setOpaque(false);
		closeButton.setMargin(insets);
	}
	
	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
		//paint nothing
	}
}