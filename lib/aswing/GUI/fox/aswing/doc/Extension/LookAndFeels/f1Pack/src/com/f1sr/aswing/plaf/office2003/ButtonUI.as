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
 

class com.f1sr.aswing.plaf.office2003.ButtonUI extends BasicButtonUI{
	/*shared instance*/
	private static var buttonUI:ButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(buttonUI == null){
    		buttonUI = new ButtonUI();
    	}
        return buttonUI;
    }
    
    public function ButtonUI(){
    	super();
    }
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	var c:AbstractButton = AbstractButton(com);
    	paintLAFButtonBackGround(c, g, b);
    }
    
    public static function paintLAFButtonBackGround(c:AbstractButton, g:Graphics, b:Rectangle):Void{
		var bgColor:ASColor = (c.getBackground() == null ? ASColor.WHITE : c.getBackground());

		if(c.isOpaque())
		{

			/*
			if(c.getModel().isPressed() || c.getModel().isSelected())
			{
				g.fillRectangle(new SolidBrush(bgColor), b.x, b.y, b.width, b.height);
				return;
			}*/
			
 			var control:ASColor = UIManager.getColor("control");
 			var light:ASColor = UIManager.getColor("controlLtHighlight");
 			var active:ASColor = UIManager.getColor("activeCaption");
 				active = c.getModel().isPressed() ? active : light;		
	    	var x:Number = b.x-1;
			var y:Number = b.y-1;
			var w:Number = b.width+2;
			var h:Number = b.height+2;
				
		   	var colors:Array = [light.getRGB(),control.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [55, 255];
			
			var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    var sbrush:SolidBrush = new SolidBrush(control);
		    g.fillRoundRect(brush,x,y,w,h,4);
		    
	        colors = [light.getRGB(), control.darker(0.8).getRGB()];//0x00A4E0];
			alphas = [50,75];
			ratios = [0, 255];
		    matrix = {matrixType:"box", x:x, y:y, w:w, h:h, r:(70/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRectRingWithThickness(brush, x, y, w, h, 4, 1);
	        
	        alphas = [50,50];
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRectRingWithThickness(brush, x+1, y+1, w-2, h-2, 3, 1);
	        
	        
	        //sbrush = new SolidBrush(control.darker(0.8).getRGB(),85);
	       // g.fillRoundRectRingWithThickness(sbrush, x, y, w, h, 3, 1);
	        
	        //sbrush = new SolidBrush(control.darker(0.7).getRGB(),65);
	       // g.fillRoundRectRingWithThickness(sbrush, x+1, y+1, w-2, h-2, 2, 1);	        

	        
	    			
			//g.fillRoundRect();
			/*
			g.fillRectangle(new SolidBrush(bgColor), b.x, b.y, b.width, b.height);
			var x1:Number = b.x;
			var y1:Number = b.y;
			var x2:Number = x1 + b.width;
			var y2:Number = y1 + b.height;
			
	   		var colors:Array = [0x57D602, 0xFFFC00];
			var alphas:Array = [85, 20];
			var ratios:Array = [75, 255];
		
		    var matrix:Object = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(90/180)*Math.PI};        
	        var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRectangle(brush,x1,y1,x2-3,y2);
	        
	        colors = [0xFFFFDC, 0xFFFFDC];
			alphas = [70, 0];
			ratios = [0, 155];
		    matrix = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(90/180)*Math.PI};        
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush, x1, y1, x2, y2/1.5,1);
	       
	       */
	       
	        //var penTool:Pen=new Pen(new ASColor(0xfefefe));
	       // g.drawLine(penTool, x1, y1+y2-1, x1+x2, y1+y2-1);	        

		}    	
    }
	
}
