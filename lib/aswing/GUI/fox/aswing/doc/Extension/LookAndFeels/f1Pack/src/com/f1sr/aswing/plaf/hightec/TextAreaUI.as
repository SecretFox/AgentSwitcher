/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 

import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicTextAreaUI;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.hightec.TextAreaUI extends BasicTextAreaUI {
	
	private var sTextAreaUI:TextAreaUI;
	
	public function createInstance():TextAreaUI{
		if(sTextAreaUI == null){
			sTextAreaUI = new TextAreaUI();
		}
		return sTextAreaUI;
	}
	
	public function TextAreaUI() {
		super();
	}

    private function paintBackGround(c:Component, g:Graphics, r:Rectangle):Void
    {
    	  	
    	if(c.isOpaque() && c.isEnabled())
    	{
    		
    		var bg = UIManager.getColor("text");
    		var hl = UIManager.getColor("textText");
    		var hll = UIManager.getColor("textHighlightText");
			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
			
			g.fillRoundRect(new SolidBrush(c.getBackground()), x,y,w,h,4);
			
			var colors:Array = [bg.getRGB(), hll.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [0, 155];
			var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,x,y,w,h,3);
		    
    	}
    	
    }
}