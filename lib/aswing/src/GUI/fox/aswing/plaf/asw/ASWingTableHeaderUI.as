/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.plaf.asw.ASWingGraphicsUtils;
import GUI.fox.aswing.plaf.basic.BasicTableHeaderUI;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingTableHeaderUI extends BasicTableHeaderUI {
	
	public function ASWingTableHeaderUI(){
		super();
	}
	    
	private function paintBackGround(c:Component, g:Graphics, b:Rectangle):Void{
		if(c.isOpaque()){
	 		var bgColor:ASColor = (c.getBackground() == null ? ASColor.WHITE : c.getBackground());
	    	ASWingGraphicsUtils.drawControlBackground(g, b, bgColor, Math.PI/2);
		}
	}
}