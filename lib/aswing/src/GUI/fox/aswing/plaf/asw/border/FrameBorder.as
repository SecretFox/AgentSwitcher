import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.Insets;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.border.FrameBorder implements Border, UIResource {
		
	private static var GLASS:Number = 4;
	
	private var activeColor:ASColor;
	private var inactiveColor:ASColor;
	
	public function FrameBorder(){
		activeColor   = UIManager.getColor("Frame.activeCaptionBorder");
		inactiveColor = UIManager.getColor("Frame.inactiveCaptionBorder");   
	}
	
	public function paintBorder(c : Component, g : Graphics, b : Rectangle) : Void {
		var frame:JFrame = JFrame(c);
		var color:ASColor = frame.isActive() ? activeColor : inactiveColor;
		
		//fill alpha rect
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+0.5, b.y+0.5, b.width-1, b.height-1, 
			GLASS + 4);
		g.drawRoundRect(
			new Pen(ASColor.WHITE, 1), 
			b.x+1.5, b.y+1.5, b.width-3, b.height-3, 
			GLASS + 3);
		g.fillRoundRectRingWithThickness(
			new SolidBrush(color.getRGB(), 20),
			b.x + 2, b.y + 2, b.width - 4, b.height - 4,
			GLASS+2, GLASS, GLASS+1);
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+2.5+GLASS, b.y+2.5+GLASS, b.width-5-GLASS*2, b.height-5-GLASS*2, 
			GLASS, GLASS, 0, 0);
	}
	
	public function getBorderInsets(c : Component, bounds : Rectangle) : Insets {
		var w:Number = GLASS + 3;
		return new Insets(w, w, w, w);
	}

	public function uninstallBorder(c : Component) : Void {
	}
}