/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.geom.Dimension;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.plaf.asw.ASWingGraphicsUtils;
import GUI.fox.aswing.plaf.basic.BasicGraphicsUtils;
import GUI.fox.aswing.plaf.basic.BasicSliderUI;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingSliderUI extends BasicSliderUI {
	
	public function ASWingSliderUI(){
		super();
	}
	
    private function paintThumb(g:Graphics, size:Dimension):Void{
    	var x:Number = 2;
    	var y:Number = 2;
    	var rw:Number = size.width - 4;
    	var rh:Number = size.height - 4;
    	var rect:Rectangle = new Rectangle(x, y, rw, rh);
    	var enabled:Boolean = slider.isEnabled();
    	
    	var borderC:ASColor = enabled ? thumbDarkShadowColor : thumbColor;
    	var fillC:ASColor = enabled ? thumbColor : thumbColor;
    	if(!enabled){
	    	g.beginDraw(new Pen(borderC));
	    	g.beginFill(new SolidBrush(fillC));
	    	g.rectangle(x, y, rw, rh);
	    	g.endFill();
	    	g.endDraw();
    	}else{
    		ASWingGraphicsUtils.drawControlBackground(
    			g, 
    			rect, 
    			fillC,
    			!isSliderVertical() ? 0 : Math.PI/2);
			g.drawRectangle(new Pen(borderC), x, y, rw, rh);
    	}
    }	
}