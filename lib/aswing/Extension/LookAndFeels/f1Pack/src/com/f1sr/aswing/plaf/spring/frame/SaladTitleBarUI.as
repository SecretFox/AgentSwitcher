/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.plaf.basic.frame.TitleBarUI;
 
class com.f1sr.aswing.plaf.spring.frame.SaladTitleBarUI extends TitleBarUI{

	//can't share instance
    public function SaladTitleBarUI(){
    	super();
    }
	
	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
		if(!com.isOpaque()){
			 return;
		}
        var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;
	    var colors:Array = [0x57D602, 0xFFFC00];
		var alphas:Array = [100, 25];
		var ratios:Array = [125, 255];
		var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);    

        colors = [0xFFFFDC, 0xFFFFDC];
		alphas = [80, 0];
		ratios = [0, 155];
	    matrix = {matrixType:"box", x:x, y:y, w:b.width, h:b.height, r:(90/180)*Math.PI};        
        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRoundRect(brush, x, y, w, h-h/4, 4, 4, 0, 0);
        var penTool:Pen=new Pen(activeBorderColor);
        g.drawLine(penTool, x, y+h-1, x+w, y+h-1);
           
        if (frame.isActive())
        {
        }
        else
        {
		    colors= [0xB0EC75, 0xEAFFA2];
			alphas= [100, 25];
			ratios = [125, 255];
			matrix = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
		    brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);  			
			
			colors = [0xFFFFFF, 0xFFFFFF];
			alphas = [45, 0];
			ratios = [0, 155];
		    matrix = {matrixType:"box", x:x, y:y, w:b.width, h:b.height, r:(90/180)*Math.PI};        
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush, x, y, w, h-h/4, 4, 4, 0, 0);
			//g.fillRoundRect(new SolidBrush(new ASColor(0xEAFFA2), 15), x, y ,w, h, 4, 4, 0, 0);
         	
			//g.fillRoundRect(new SolidBrush(ASColor.BLACK.getRGB(), 15), x, y ,w, h, 4, 4, 0, 0);
        }
	}
}
