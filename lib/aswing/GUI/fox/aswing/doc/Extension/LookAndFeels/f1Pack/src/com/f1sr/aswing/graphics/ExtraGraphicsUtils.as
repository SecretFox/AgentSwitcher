/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.ASColor;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
 
 
class com.f1sr.aswing.graphics.ExtraGraphicsUtils extends org.aswing.plaf.basic.BasicGraphicsUtils
{


	public static function drawRoundedBorderInset(g:Graphics, 
												r:Rectangle,
												radius,
                                    			shadow:ASColor, 
                                    			darkShadow:ASColor, 
                                 				highlight:ASColor, 
                                 				lightHighlight:ASColor):Void
	{
		
		var x1:Number = r.x;
		var y1:Number = r.y;
		var w:Number = r.width;
		var h:Number = r.height;
		
		

	   	var colors:Array = [shadow.getRGB(),highlight.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		
		var matrix:Object = {matrixType:"box", x:x1, y:y1, w:w, h:h, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		g.fillRoundRectRingWithThickness(brush, x1, y1, w, h, 4, 1);
		
		colors = [lightHighlight.getRGB(),lightHighlight.getRGB()];
		alphas = [100, 100];
		ratios = [0, 255];
		
		matrix = {matrixType:"box", x:x1, y:y1, w:w, h:h, r:(90/180)*Math.PI};        
	    brush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		g.fillRoundRectRingWithThickness(brush, x1+1, y1+1, w-2, h-2, 4, 1);
		
	}
	
	public static function drawRoundedBorderOutset(g:Graphics, 
												r:Rectangle,
												radius,
                                    			shadow:ASColor, 
                                    			darkShadow:ASColor, 
                                 				highlight:ASColor, 
                                 				lightHighlight:ASColor):Void
	{
		
		var x1:Number = r.x;
		var y1:Number = r.y;
		var w:Number = r.width;
		var h:Number = r.height;
		
		var brush:SolidBrush=new SolidBrush(shadow,100);
		g.fillRoundRectRingWithThickness(brush, x1, y1, w, h, 4, 1);
		
		/*
	   	var colors:Array = [highlight.getRGB(),shadow.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		
		var matrix:Object = {matrixType:"box", x:x1, y:y1, w:w, h:h, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		g.fillRoundRectRingWithThickness(brush, x1, y1, w, h, 4, 1);
		
		colors = [lightHighlight.getRGB(),lightHighlight.getRGB()];
		alphas = [100, 100];
		ratios = [0, 255];
		
		matrix = {matrixType:"box", x:x1, y:y1, w:w, h:h, r:(90/180)*Math.PI};        
	    brush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		g.fillRoundRectRingWithThickness(brush, x1+1, y1+1, w-2, h-2, 4, 1);

		*/
	}
	
	public static function drawRoundedBorder(g:Graphics, 
											rect:Rectangle,
											radius, 
											isPressed:Boolean, 
                                    		shadow:ASColor, 
                                    		darkShadow:ASColor, 
                                 			highlight:ASColor, 
                                 			lightHighlight:ASColor):Void
   {
                                 
        if(isPressed) 
        {
            drawRoundedBorderOutset(g, rect, radius, shadow, darkShadow, highlight, lightHighlight);
        }
        else 
        {
        	drawRoundedBorderInset(g, rect,radius, shadow, darkShadow, highlight, lightHighlight);
        }
	}
}