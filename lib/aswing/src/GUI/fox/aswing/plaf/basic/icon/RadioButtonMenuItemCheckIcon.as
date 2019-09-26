/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.JMenuItem;
import GUI.fox.aswing.plaf.basic.icon.MenuCheckIcon;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.icon.RadioButtonMenuItemCheckIcon extends MenuCheckIcon {
	
	public function RadioButtonMenuItemCheckIcon() {
		super();
	}
	
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var menu:JMenuItem = JMenuItem(com);
		if(menu.isSelected()){
			g.fillCircle(new SolidBrush(ASColor.BLACK), x+4, y+5, 3, 3);
		}
	}
}