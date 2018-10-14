/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 


import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Insets;

class com.f1sr.aswing.plaf.office2003.border.TitleBarButtonBorder extends org.aswing.plaf.basic.border.ButtonBorder{
	
	
	
	function TitleBarButtonBorder(){
		super();
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, b:Rectangle):Void{
    	var isPressed:Boolean = false;
    	var radius:Number = 4;

		var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;
		
	    		
		var brush:SolidBrush=new SolidBrush(ASColor.WHITE,100);
		g.fillRoundRectRingWithThickness(brush, x, y, w, h, 4, 1);
		

    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets
	{
    	return new Insets(1, 1, 1, 1);
    }
    
}