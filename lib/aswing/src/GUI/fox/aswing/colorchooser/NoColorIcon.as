/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.Icon;

/**
 * @author iiley
 */
class GUI.fox.aswing.colorchooser.NoColorIcon implements Icon {
	private var width:Number;
	private var height:Number;
	
	public function NoColorIcon(width:Number, height:Number){
		this.width = width;
		this.height = height;
	}

	/**
	 * Return the icon's width.
	 */
	public function getIconWidth():Number{
		return width;
	}
	
	/**
	 * Return the icon's height.
	 */
	public function getIconHeight():Number{
		return height;
	}
	
	/**
	 * Draw the icon at the specified location.
	 */
	public function paintIcon(com:Component, g:Graphics, x:Number, y:Number):Void{
		g.beginDraw(new Pen(ASColor.BLACK, 1));
		g.beginFill(new SolidBrush(ASColor.WHITE));
		var w:Number = width/2 + 1;
		var h:Number = height/2 + 1;
		x = x + w/2 - 1;
		y = y + h/2 - 1;
		g.rectangle(x, y, w, h);
		g.endFill();
		g.endDraw();
		g.drawLine(new Pen(ASColor.RED, 2), x+1, y+h-1, x+w-1, y+1);
	}
	
	public function uninstallIcon(com:Component):Void{
	}	
}