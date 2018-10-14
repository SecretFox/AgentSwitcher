/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicButtonUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;
 

class com.f1sr.aswing.plaf.spring.SaladButtonUI extends BasicButtonUI{
	/*shared instance*/
	private static var saladButtonUI:SaladButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(saladButtonUI == null){
    		saladButtonUI = new SaladButtonUI();
    	}
        return saladButtonUI;
    }
    
    public function SaladButtonUI(){
    	super();
    }
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	var c:AbstractButton = AbstractButton(com);
    	paintSaladLAFButtonBackGround(c, g, b);
    }
    
    public static function paintSaladLAFButtonBackGround(c:AbstractButton, g:Graphics, b:Rectangle):Void{
		var bgColor:ASColor = (c.getBackground() == null ? ASColor.WHITE : c.getBackground());

		if(c.isOpaque())
		{
			if(c.getModel().isPressed() || c.getModel().isSelected())
			{
				//g.fillRectangle(new SolidBrush(bgColor), b.x, b.y, b.width, b.height);
				//return;
			}
			//trace(c.getModel().isPressed());
			g.fillRectangle(new SolidBrush(UIManager.getColor("control")), b.x, b.y, b.width, b.height);
			var x1:Number = b.x;
			var y1:Number = b.y;
			var x2:Number = b.width;
			var y2:Number = b.height;
			
	    	var colors:Array = [0x57D602, 0xFFFC00];
			var alphas:Array = [100, 65];
			var ratios:Array = [75, 255];
			
		    var matrix:Object = {matrixType:"box", x:x1, y:y1, w:x2, h:y2, r:(90/180)*Math.PI};        
	        var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRectangle(brush,x1,y1,x2,y2);
	        
	        colors = [0xFFFFDC, 0xFFFFDC];
			alphas = [70, 0];
			ratios = [0, 155];
		    matrix = {matrixType:"box", x:x1, y:y1, w:x2, h:y2, r:(90/180)*Math.PI};        
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush, x1, y1, x2, y2/1.5,1);
	        //var penTool:Pen=new Pen(new ASColor(0xfefefe));
	       // g.drawLine(penTool, x1, y1+y2-1, x1+x2, y1+y2-1);	        

		}    	
    }
	
}
