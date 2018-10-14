/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.Component;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicScrollBarUI;

 
class com.f1sr.aswing.plaf.hightec.ScrollBarUI extends BasicScrollBarUI
{
	
    
    public function ScrollBarUI(){
    	super();
    	
    	//trace("ComboBoxUI()");
    }	
   
   private function paintThumb(thumMC:MovieClip, size:Dimension):Void
   {
    	var w:Number = size.width;
    	var h:Number = size.height;
    	var direction:Number =isVertical() ? 1 : 90;
    	
    	thumMC.clear();
    	
    	var g:Graphics = new Graphics(thumMC);
    	var b:SolidBrush = new SolidBrush(thumbLightShadowColor);
    	
    	g.fillRoundRect(b, 0, 0, w, h,4);
    	//b.setASColor(this.thumbColor);
    	//g.fillRoundRect(b, 1, 1, w-2, h-2,4);

    	var bg = thumbColor.getRGB();
    	var hl = thumbDarkShadowColor.brighter(0.1).getRGB();
    					
		var colors:Array = [hl, bg];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		var matrix:Object = {matrixType:"box", x:1, y:1, w:w-2, h:h-2, r:(direction/180)*Math.PI};        
		var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		g.fillRoundRect(brush,1,1,w-2,h-2,4);
		        	
    	
    	var p:Pen = new Pen(thumbDarkShadowColor, 0);
    	if(isVertical()){
	    	var ch:Number = h/2;
	    	g.drawLine(p, 3, ch, w-3, ch);
	    	g.drawLine(p, 3, ch+2, w-3, ch+2);
	    	g.drawLine(p, 3, ch-2, w-3, ch-2);
    	}else{
	    	var cw:Number = w/2;
	    	g.drawLine(p, cw, 3, cw, h-3);
	    	g.drawLine(p, cw+2, 3, cw+2, h-3);
	    	g.drawLine(p, cw-2, 3, cw-2, h-3);
    	}
    }
    
    private function paintBackGround(c:Component, g:Graphics, r:Rectangle):Void
    {
    	  	
    	 var direction:Number =isVertical() ? 1 : 90;
    		
    		var bg = thumbColor.getRGB();
    		var hl = thumbColor.brighter(0.02).getRGB();

			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
			
			g.fillRoundRect(new SolidBrush(bg), x,y,w,h,4);
			
			var colors:Array = [hl, bg];
			var alphas:Array = [50, 100];
			var ratios:Array = [0, 255];
			var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(direction/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,x,y,w,h,4);
		    
    	
    }     

}