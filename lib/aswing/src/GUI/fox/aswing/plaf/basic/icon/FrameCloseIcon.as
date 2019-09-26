/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.Component;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.plaf.basic.icon.FrameIcon;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.icon.FrameCloseIcon extends FrameIcon {

	/**
	 * @param width the width of the icon square.
	 */	
	public function FrameCloseIcon(){
		super(DEFAULT_ICON_WIDTH);
	}
	
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var w:Number = width/2;
		g.drawLine(
			new Pen(getColor(), w/3), 
			x+(width-w)/2, y+(width-w)/2,
			x+(width+w)/2, y+(width+w)/2);
		g.drawLine(
			new Pen(getColor(), w/3), 
			x+(width-w)/2, y+(width+w)/2,
			x+(width+w)/2, y+(width-w)/2);		
	}
}
