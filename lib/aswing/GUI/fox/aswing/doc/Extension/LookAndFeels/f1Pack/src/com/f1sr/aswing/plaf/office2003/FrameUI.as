/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.plaf.basic.BasicFrameUI;
import org.aswing.UIManager;
 
class com.f1sr.aswing.plaf.office2003.FrameUI extends BasicFrameUI
{

    	
	public function FrameUI() 
	{
		super();
	} 
	
	
	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void
 	{
 		//trace(com.getBackground()+":"+UIManager.getColor("Window.modalColor"));
 		
 		var clr1:Number = UIManager.getColor("controlHighlight").getRGB();
 		var clr2:Number = UIManager.getColor("control").getRGB();
 		
    	var x1:Number = b.x;
		var y1:Number = b.y;
		var x2:Number = x1 + b.width;
		var y2:Number = y1 + b.height;
			
	   	var colors:Array = [clr1,clr2];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		
		var matrix:Object = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(50/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRect(brush,x1,y1,x2,y2,5);
    }
	
}
