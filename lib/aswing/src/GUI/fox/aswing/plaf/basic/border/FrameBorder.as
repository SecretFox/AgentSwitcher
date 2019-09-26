/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.Insets;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIManager;

/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.border.FrameBorder implements Border, UIResource {
	
	private static var BAR:Number = 2;
	
	private var activeColor:ASColor;
	private var inactiveColor:ASColor;
	
	public function FrameBorder(){
		activeColor   = UIManager.getColor("Frame.activeCaptionBorder");
		inactiveColor = UIManager.getColor("Frame.inactiveCaptionBorder");   
	}
	
	public function paintBorder(c : Component, g : Graphics, bounds : Rectangle) : Void {
		var frame:JFrame = JFrame(c);
		var color:ASColor = frame.isActive() ? activeColor : inactiveColor;
		
		//fill alpha rect
		g.beginFill(new SolidBrush(new ASColor(color.getRGB(), 40)));
		g.roundRect(bounds.x, bounds.y+BAR, bounds.width, bounds.height-BAR, 4, 4, 0, 0);
    	g.rectangle(bounds.x+BAR, bounds.y+BAR+1, bounds.height-BAR*2, bounds.height-BAR-2);
    	g.endFill();
    	
		//border
		g.beginFill(new SolidBrush(color));
		g.roundRect(bounds.x+BAR, bounds.y, bounds.width-BAR*2, bounds.height-BAR, 5,5,0,0);
		g.roundRect(bounds.x+BAR+1, bounds.y+1, bounds.width-BAR*2-2, bounds.height-BAR-2, 5,5,0,0);
		g.endFill();
		//highlight
		g.beginFill(new SolidBrush(color.brighter(0.9)));
		g.roundRect(bounds.x+BAR+1, bounds.y+1, bounds.width-BAR*2-2, bounds.height-BAR-2, 5,5,0,0);	
		g.roundRect(bounds.x+BAR+2, bounds.y+2, bounds.width-BAR*2-4, bounds.height-BAR-4, 4,4,0,0);
		g.endFill();
	}
	
	public function getBorderInsets(c : Component, bounds : Rectangle) : Insets {
		return new Insets(2, BAR+2, BAR+2, BAR+2);;
	}

	public function uninstallBorder(c : Component) : Void {
	}
	

}
