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
import org.aswing.UIManager;
 

class com.f1sr.aswing.plaf.winxp.button.TitleBarRedButtonUI extends BasicButtonUI{

    public function TitleBarRedButtonUI(){
    	super();
    	//trace("--TitleBarRedButtonUI()--");
    }
    
	public function installUI(c:Component):Void{
    }
    

	private function installDefaults(b:AbstractButton):Void
	{
	}    
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	var c:AbstractButton = AbstractButton(com);
    	paintButtonBackGround(c, g, b);
    	//trace("paintBackGround()");
    }
    
    public static function paintButtonBackGround(c:AbstractButton, g:Graphics, b:Rectangle):Void{
		var bgColor:ASColor = (c.getBackground() == null ? ASColor.WHITE : c.getBackground());


		if(c.isOpaque())
		{

 			var control:ASColor = new ASColor(0xE03802);//UIManager.getColor("inactiveCaption").brighter(0.9);//UIManager.getColor("control");
 			var light:ASColor = new ASColor(0xF9C0B1);//UIManager.getColor("controlHighlight");
 			
 			var active:ASColor = UIManager.getColor("activeCaption");
 				active = c.getModel().isPressed() ? active : light;		
	    	
	    	var x:Number = b.x-1;
			var y:Number = b.y-1;
			var w:Number = b.width+2;
			var h:Number = b.height+2;
			
			var brush:SolidBrush = new SolidBrush(control.darker(0.95));
		    //g.fillRoundRect(brush,x,y,w,h,4);
		    g.fillRoundRectRingWithThickness(brush, x, y, w, h, 4, 1);
		    
		   	var colors:Array = [light.getRGB(),control.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [0, 175];
			
			var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(45/180)*Math.PI};        
		    var gbrush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(gbrush,x+1,y+1,w-2,h-2,3);		    
		    
		}    	
    }
	
}