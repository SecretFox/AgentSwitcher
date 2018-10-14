/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.ASColor;
import org.aswing.border.Border;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Insets;
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;

/**
 * @author iiley
 */
class org.aswing.plaf.winxp.border.TextBorder implements Border, UIResource {
	
	
  
    private var highlight:ASColor;
   
	
	public function TextBorder(shadow:ASColor, darkShadow:ASColor, light:ASColor, highlight:ASColor){
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		
		
		this.highlight = highlight;
		
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, r:Rectangle):Void{
			
		    var x1:Number = r.x;
			var y1:Number = r.y;
			var x2:Number = x1 + r.width;
			var y2:Number = y1 + r.height;
		
			g.fillRectangle(new SolidBrush(highlight), x1,y1,x2,y2);
			
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets{
    	return new Insets(1, 1, 1, 1);
    }
    
    public function uninstallBorder(c:Component):Void{
    }
	
}
