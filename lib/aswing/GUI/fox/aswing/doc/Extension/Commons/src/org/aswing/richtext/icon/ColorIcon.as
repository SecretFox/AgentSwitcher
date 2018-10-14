/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;

/**
 * @author iiley
 */
class org.aswing.richtext.icon.ColorIcon implements Icon {
	
	private var color:ASColor;
	
	public function ColorIcon(c:ASColor){
		if(c === undefined){
			color = ASColor.BLACK;
		}else{
			color = c;
		}
	}
	
	public function setColor(c:ASColor):Void{
		color = c;
	}
	
	public function getColor():ASColor{
		return color;
	}
	
	public function getIconWidth() : Number {
		return 18;
	}

	public function getIconHeight() : Number {
		return 17;
	}

	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var w:Number = getIconWidth();
		var h:Number = getIconHeight();
		if(color != null){
			g.fillRectangle(new SolidBrush(color), x, y, w, h);
		}else{
			g.fillRectangle(new SolidBrush(ASColor.WHITE), x, y, w, h);
			g.drawLine(new Pen(ASColor.RED, 2), x+1, y+h-1, x+w-1, y+1);
		}
		g.drawRectangle(new Pen(ASColor.GRAY), x+0.5, y+0.5, w-1, h-1);
	}

	public function uninstallIcon(com : Component) : Void {
	}

}