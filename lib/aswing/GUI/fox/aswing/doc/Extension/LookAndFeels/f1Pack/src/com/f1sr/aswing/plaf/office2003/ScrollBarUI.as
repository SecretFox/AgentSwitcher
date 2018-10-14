/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.JButton;
import org.aswing.plaf.basic.BasicScrollBarUI;
import org.aswing.plaf.basic.icon.ArrowIcon;

import com.f1sr.aswing.plaf.office2003.button.ScrollBarButtonUI;
import com.f1sr.aswing.plaf.office2003.icon.ScrollBarDownIcon;
import com.f1sr.aswing.plaf.office2003.icon.ScrollBarUpIcon;




 
 
class com.f1sr.aswing.plaf.office2003.ScrollBarUI extends BasicScrollBarUI
{
	
    
    public function ScrollBarUI(){
    	super();
    	
    	//trace("ComboBoxUI()");
    }	
   
    private function createArrowIcon(direction:Number):Icon{
    	var icon:Icon = new ArrowIcon(direction, scrollBarWidth/3-1,
				    new ASColor(0x000000,100),
				   new ASColor(0x666666,100),
				   new ASColor(0x666666,100),
				    new ASColor(0xFF0000,100));
		return icon;
    }
    
    private function createIcons():Void{
    	leftIcon = createArrowIcon(Math.PI);
    	rightIcon = createArrowIcon(0);
    	upIcon = new ScrollBarUpIcon(
    				Math.PI/2, 16,
				    new ASColor(0x000000,100),
				   new ASColor(0x4D6185,100),
				   new ASColor(0x4D6185,100),
				    new ASColor(0xFF0000,100)
    			);
    	downIcon = new ScrollBarDownIcon(
    	
    				Math.PI/2, 16,
				    new ASColor(0x000000,100),
				   new ASColor(0x4D6185,100),
				   new ASColor(0x4D6185,100),
				    new ASColor(0xFF0000,100)    	
    			);
    }
    
    private function createArrowButton():JButton{
		var b:JButton = new JButton();
			b.setUI(new ScrollBarButtonUI());
		return b;
    }
    
    private function setButtonIcons():Void{
    	if(isVertical()){
    		incrButton.setIcon(downIcon);
    		decrButton.setIcon(upIcon);
    	}else{
    		incrButton.setIcon(rightIcon);
    		decrButton.setIcon(leftIcon);
    	}
    }
   
   private function paintThumb(thumMC:MovieClip, size:Dimension):Void
   {
    	var w:Number = size.width;
    	var h:Number = size.height;
	    var x:Number = 0;
		var y:Number = 0;
		    	
    	var direction:Number =isVertical() ? 1 : 90;
    	
    	thumMC.clear();
    	var g:Graphics = new Graphics(thumMC);
    	
 		var control:ASColor = new ASColor(0xB0C4F2);//UIManager.getColor("inactiveCaption").brighter(0.9);//UIManager.getColor("control");
 		var light:ASColor = new ASColor(0xE6EEFC);//UIManager.getColor("controlHighlight");
			
		var brush:SolidBrush = new SolidBrush(control.darker(0.95));
		   //g.fillRoundRect(brush,x,y,w,h,4);
		g.fillRoundRectRingWithThickness(brush, x, y, w, h, 4, 1);
		    
		var colors:Array = [light.getRGB(),control.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 205];
			
		var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(direction/180)*Math.PI};        
		var gbrush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		g.fillRoundRect(gbrush,x+1,y+1,w-2,h-2,3);		
		        	
    	
    	var p:Pen = new Pen(new ASColor(0x4D6185), 0);
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
    		
    		var bg = new ASColor(0xEEEDE5);//thumbColor.getRGB();
    		var hl = bg.brighter(0.1);

			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
			
			g.fillRoundRect(new SolidBrush(bg), x,y,w,h,4);
			
			var colors:Array = [bg.getRGB(),hl.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [0, 255];
			var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(direction/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,x,y,w,h,4);
		    
    		var sbrush:SolidBrush = new SolidBrush(new ASColor(0xcccccc));
    		g.fillRoundRectRingWithThickness(brush, x+1, y+1, w-2, h-2, 4, 1);
    }     

}