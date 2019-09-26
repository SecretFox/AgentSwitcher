/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.Component;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.plaf.basic.icon.FrameIcon;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.icon.FrameIconifiedIcon extends FrameIcon {

	/**
	 * @param width the width of the icon square.
	 */
	public function FrameIconifiedIcon(){
		super(DEFAULT_ICON_WIDTH);
	}
	
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var w:Number = width/2;
		var h:Number = w/3;
		g.fillRectangle(new SolidBrush(getColor()), x+h, y+w+h, w, h);		
	}
}
