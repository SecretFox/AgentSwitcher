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
import org.aswing.plaf.basic.BasicButtonUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;
 

class com.f1sr.aswing.plaf.hightec.ButtonUI extends BasicButtonUI{
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
			
 			var clr1:Number = UIManager.getColor("control").getRGB();
 			var clr2:Number = UIManager.getColor("controlLtHighlight").getRGB();
 			var active:Number = UIManager.getColor("activeCaption").getRGB();//"00BBFF
 				active = c.getModel().isPressed() ? active : 0xffffff;		
	    	var x1:Number = b.x-1;
			var y1:Number = b.y-1;
			var x2:Number = x1 + b.width+2;
			var y2:Number = y1 + b.height+2;
				
		   	var colors:Array = [clr2, clr1];
			var alphas:Array = [100, 100];
			var ratios:Array = [65, 255];
			
			var matrix:Object = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(90/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,x1,y1,x2,y2,4);
		    
	        colors = [0xFFFFFF, active];//0x00A4E0];
			alphas = [0,100];
			ratios = [175, 255];
		    matrix = {matrixType:"box", x:x1, y:y1, w:y2, h:y2, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush, x1+0.5, y1+y2/2-1, x2-2, y2-y2/2, 3);
		    
	    			
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
