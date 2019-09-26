/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JMenuItem;
import GUI.fox.aswing.plaf.UIResource;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.icon.MenuCheckIcon implements Icon, UIResource {
	
	public function MenuCheckIcon(){
	}
	
	public function getIconWidth() : Number {
		return 8;
	}

	public function getIconHeight() : Number {
		return 8;
	}

	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
//		var menu:JMenuItem = JMenuItem(com);
//		if(menu.isSelected()){
//			g.beginDraw(new Pen(ASColor.BLACK, 2));
//			g.moveTo(x, y+3);
//			g.lineTo(x+3, y+6);
//			g.lineTo(x+7, y+1);
//			g.endDraw();
//		}
		//paint nothing
	}

	public function uninstallIcon(com : Component) : Void {
	}

}