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
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.office2003.border.ListBorder implements Border, UIResource{
	
    private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
	
	private static var instance:Border;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new ListBorder();
		}
		return instance;
	}
	
	private function ListBorder(){
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		this.shadow = table.getColor("Button.shadow");
		this.darkShadow = table.getColor("Button.darkShadow");
		this.highlight = table.getColor("Button.light");
		this.lightHighlight = table.getColor("Button.highlight");
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, bounds:Rectangle):Void{
		    var x1:Number = bounds.x;
			var y1:Number = bounds.y;
			var w:Number = bounds.width;
			var h:Number = bounds.height;
		
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
	
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets{
    	return new Insets(2, 2, 2, 2);
    }
    
    public function uninstallBorder(c:Component):Void{
    }
	

	
}