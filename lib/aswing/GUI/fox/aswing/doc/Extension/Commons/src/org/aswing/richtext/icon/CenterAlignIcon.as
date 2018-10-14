/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.Icon;

/**
 * @author iiley
 */
class org.aswing.richtext.icon.CenterAlignIcon implements Icon {
	
	public function CenterAlignIcon(){
	}
	
	public function getIconWidth() : Number {
		return 18;
	}

	public function getIconHeight() : Number {
		return 17;
	}

	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		y += 3;
		x += 1;
		var w:Number = 16;
		for(var i:Number=0; i<6; i++){
			g.drawLine(
				new Pen(ASColor.BLACK), 
				x + (i%2==0 ? 0 : 4), 
				y, 
				x + (i%2==0 ? 16 : 12), 
				y);
			y += 2;
		}
	}

	public function uninstallIcon(com : Component) : Void {
	}

}