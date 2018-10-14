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
import org.aswing.graphics.Pen;
import org.aswing.Insets;
import org.aswing.JTextComponent;
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.hightec.border.TextBorder implements Border, UIResource 
{
	
	
    private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
	
	public function TextBorder(shadow:ASColor, darkShadow:ASColor, light:ASColor, highlight:ASColor){
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		
		this.shadow = shadow;
		this.darkShadow = darkShadow;
		this.highlight = light;
		this.lightHighlight = highlight;
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, r:Rectangle):Void{
	    var x1:Number = r.x;
		var y1:Number = r.y;
		var w:Number = r.width;
		var h:Number = r.height;
		var textCom:JTextComponent = JTextComponent(c);
		if(textCom.isEditable() && textCom.isEnabled())
		{
			//just can't judge which is better of bottom two ways, both has flaw.:(
			//g.drawRectangle(new Pen(highlight, 1), x1+0.5, y1+0.5, w-1, h-1);
			//g.fillRectangleRingWithThickness(new SolidBrush(highlight), x1,y1,w,h, 1);

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
		    g.fillRoundRectRingWithThickness(brush, x1+1, y1+1, w-2, h-2, 3, 1);
		}
		else
			g.drawRoundRect(new Pen(highlight, 1), x1+1, y1+1, w-2, h-2,3);
		//g.fillRectangleRingWithThickness(new SolidBrush(lightHighlight), x1+1,y1+1,w-2,h-2, 1);
				
		
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets{
    	return new Insets(2, 2, 2, 2);
    }
    
    public function uninstallBorder(c:Component):Void{
    }
	
}
