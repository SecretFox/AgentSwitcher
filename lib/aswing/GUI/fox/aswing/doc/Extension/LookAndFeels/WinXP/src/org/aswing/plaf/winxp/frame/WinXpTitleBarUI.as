/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.frame.TitleBarUI;
 
/**
 * @author firdosh
 */
class org.aswing.plaf.winxp.frame.WinXpTitleBarUI extends TitleBarUI{

	//can't share instance
    public function WinXpTitleBarUI(){
    	super();
    }
	
	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
        var x1:Number = b.x;
		var y1:Number = b.y;
		var x2:Number = x1 + b.width;
		var y2:Number = y1 + b.height;
	    var colors:Array = [0x0053e1, 0x026afe];
		var alphas:Array = [100, 100];
		var ratios:Array = [75, 255];
		var matrix:Object = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRectangle(brush,x1,y1,x2,y2);    
	   
	   var penTool:Pen=new Pen(new ASColor(0x2b90ff,100));
	    penTool.setThickness(2);
	    g.drawLine(penTool,x1,y1,x2,y1);	   
        penTool.setColor(0x0144d0);        
        penTool.setThickness(1);
         ///g=new Graphics(_titleBottomBorder);
        g.drawLine(penTool,x1,y2-1,x2,y2-1);
           
        if (frame.isActive()){
        }else{
			g.fillRectangle(new SolidBrush(ASColor.BLACK.getRGB(), 15),x1,y1,x2,y2);
        }
	}
}
