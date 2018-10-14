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
 
class com.f1sr.aswing.plaf.hightec.frame.HightecTitleBarUI extends TitleBarUI{

	//can't share instance
    public function HightecTitleBarUI(){
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


	    var colors:Array = [0xFFFFFFF,0xCBCED0];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 155];
		var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);    


        colors = [0xFFFFFF, 0xFFFFFF];//0x00A4E0];
		alphas = [0,55];
		ratios = [185, 255];
	    matrix = {matrixType:"box", x:x, y:y, w:b.width, h:b.height, r:(90/180)*Math.PI};
	           
        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRoundRect(brush, x+1, y+h/2-1, w-2, h-h/2, 0, 0, 0, 0);
       
        var penTool:Pen=new Pen(activeBorderColor);
        g.drawLine(penTool, x, y+h-1, x+w, y+h-1);
        
        //var penHighlight = new Pen(0x00A4E0,1,55);
        //g.drawRoundRect(penHighlight,x+1,y+1,w-2,h-2,3,3,0,0);
        //penHighlight = new Pen(0x00A4E0,1,35);
       // g.drawRoundRect(penHighlight,x+2,y+2,w-4,h-4,2.5,2.5,0,0);
       // penHighlight = new Pen(0x00A4E0,1,20);
        //g.drawRoundRect(penHighlight,x+3,y+3,w-6,h-6,2,2,0,0);                   
        if (frame.isActive())
        {
        	
        }
        else
        {
		    colors = [0xFFFFFFF,0xE8E9EA];//0xCBCED0];
			alphas = [100, 100];
			ratios = [0, 255];
			matrix = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
		    brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);    
	
	
	        colors = [0xFFFFFF, 0xFFFFFF];//0x00A4E0];
			alphas = [0,55];
			ratios = [185, 255];
		    matrix = {matrixType:"box", x:x, y:y, w:b.width, h:b.height, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush, x+1, y+h/2-1, w-2, h-h/2, 0, 0, 0, 0);
	       
        }
	}
}
