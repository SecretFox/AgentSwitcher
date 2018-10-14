/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.JMenuItem;
import GUI.fox.aswing.plaf.basic.icon.MenuCheckIcon;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.icon.CheckBoxMenuItemCheckIcon extends MenuCheckIcon {
	
	public function CheckBoxMenuItemCheckIcon() {
		super();
	}
	
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var menu:JMenuItem = JMenuItem(com);
		if(menu.isSelected()){
			g.beginDraw(new Pen(ASColor.BLACK, 2));
			g.moveTo(x, y+4);
			g.lineTo(x+3, y+7);
			g.lineTo(x+7, y+2);
			g.endDraw();
		}
	}
}