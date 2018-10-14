/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.AdvancedPen;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicSliderUI;
import org.aswing.UIManager;
import org.aswing.util.AdvancedColor;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.ComenySliderUI extends BasicSliderUI {
		
	private var control:AdvancedColor;
	private var light:AdvancedColor;
		
	public function ComenySliderUI(){
		super();
	}
	
	private function installDefaults():Void{
		super.installDefaults();
    	
    	control = AdvancedColor.getAdvancedColor(UIManager.getColor("Slider.shadow"));
    	light = AdvancedColor.getAdvancedColor(UIManager.getColor("Slider.light"));
	}
	
    private function paintTrack(g:Graphics, trackRect:Rectangle):Void{
    	var drawRect:Rectangle = getTrackDrawRect(trackRect);
    	
    	var x:Number = drawRect.x;
    	var y:Number = drawRect.y;
    	var w:Number = drawRect.width;
    	var h:Number = drawRect.height;
    	
    	var colors:Array = [control.getRGB(), light.getRGB()];
		var alphas:Array = [light.getAlpha(), light.getAlpha()];
		var ratios:Array = [0, 255];
		var dir:Number = isSliderVertical() ? -Math.PI : 0;
	    var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:dir};
	    var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    var radius:Number = isSliderVertical() ? w/2 : h/2;
	    g.fillRoundRect(brush, x, y, w, h, radius);
    }
    
    private function paintTrackProgress(g:Graphics, trackDrawRect:Rectangle):Void{
    }  
      
    private function paintThumb(g:Graphics, size:Dimension):Void{
    	var x:Number = 0;
    	var y:Number = 0;
    	var w:Number = size.width;
    	var h:Number = w;
    	
    	var colors:Array = [0xFFFFFF, light.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		var dir:Number = 0;
	    var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:dir};
	    var brush:GradientBrush = new GradientBrush(GradientBrush.RADIAL, colors, alphas, ratios, matrix);
    	g.fillEllipse(brush, x, w, w, h);
    }
}