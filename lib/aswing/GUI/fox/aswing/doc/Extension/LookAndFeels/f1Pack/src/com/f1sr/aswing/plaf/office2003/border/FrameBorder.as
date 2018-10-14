/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.ASColor;
import org.aswing.border.Border;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.Insets;
import org.aswing.JFrame;
import org.aswing.plaf.UIResource;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.office2003.border.FrameBorder implements Border, UIResource {
		
	private static var GLASS:Number = 3;
	
	private var activeColor:ASColor;
	private var inactiveColor:ASColor;
	private var darkShadow:ASColor;
	
	
	public function FrameBorder(){
		activeColor   = UIManager.getColor("Frame.activeCaptionBorder");
		inactiveColor = UIManager.getColor("Frame.inactiveCaptionBorder");
		darkShadow = UIManager.getColor("controlDkShadow");
		   
	}
	
	public function paintBorder(c : Component, g : Graphics, b : Rectangle) : Void {
		var frame:JFrame = JFrame(c);
		var color:ASColor = frame.isActive() ? activeColor : inactiveColor;
		var shadow:ASColor = frame.isActive() ? darkShadow : inactiveColor;

		
		//trace(color);
		
		var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;
		
		// brdr 3		
	   	var colors:Array = [color.darker(0.8).getRGB(),shadow.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [100, 255];
		var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(50/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);

	    g.fillRoundRectRingWithThickness(brush, x, y, w, h,GLASS+3,2);
		
		// brdr 2	    
	   	colors = [color.getRGB(),shadow.getRGB()];
		alphas = [100, 100];
		ratios = [75, 255];
		matrix = {matrixType:"box", x:x, y:y, w:w, h:h, r:(50/180)*Math.PI};        
	    brush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRectRingWithThickness(brush, x+1.5, y+1.5, w-3, h-3,GLASS+2,2);
	    
	    
	    /*		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		g.fillRoundRectRingWithThickness(brush, x+1, y+1, w-2, h-2, GLASS+3, 2);
		
		var sbrush:SolidBrush = new SolidBrush(color);
		g.fillRoundRectRingWithThickness(sbrush, x, y, w, h, GLASS+4, 1); 
		*/
		/*	

		//fill alpha rect
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+0.5, b.y+0.5, b.width-1, b.height-1, 
			GLASS + 1);
			  
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+1.5, b.y+1.5, b.width-3, b.height-3, 
			GLASS + 3);
		g.fillRoundRectRingWithThickness(
			new SolidBrush(color, frame.isActive() ? 100 : 70),
			b.x + 2, b.y + 2, b.width - 4, b.height - 4,
			GLASS+2, GLASS, GLASS+1);
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+2.5+GLASS, b.y+2.5+GLASS, b.width-5-GLASS*2, b.height-5-GLASS*2, 
			GLASS, GLASS, 0, 0);
		*/	
			
	}
	
	public function getBorderInsets(c : Component, bounds : Rectangle) : Insets {
		var w:Number = GLASS;
		return new Insets(w, w, w, w);
	}

	public function uninstallBorder(c : Component) : Void 
	{
	}
}