/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.Insets;
import org.aswing.UIManager;

class com.f1sr.aswing.plaf.office2003.border.ButtonBorder extends org.aswing.plaf.basic.border.ButtonBorder{
	
	
	//private static var aswInstance:Border;
	/**
	 * this make shared instance and construct when use.
	 */
	/* 	
	public static function createInstance():Border{
		if(aswInstance == null){
			aswInstance = new ButtonBorder();
		}
		return aswInstance;
	}
	*/
	
	private function ButtonBorder(){
		super();
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, b:Rectangle):Void{
    	var isPressed:Boolean = false;
    	var radius:Number = 4;

		var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;
		
		var bColor:ASColor = UIManager.getColor("controlBorder");

	   	var colors:Array = [bColor.getRGB(),bColor.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		
		var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		g.fillRoundRectRingWithThickness(brush, x, y, w, h, 4, 1);
		
		colors = [lightHighlight.getRGB(),lightHighlight.getRGB()];
		alphas = [100, 100];
		ratios = [0, 255];
		
		matrix = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
	    brush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    		
		//var brush:SolidBrush=new SolidBrush(darkShadow,100);
		//g.fillRoundRectRingWithThickness(brush, x+1, y+1, w-2, h-2, 4, 1);

    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets
	{
    	return new Insets(2, 2, 2, 2);
    }
    
}
