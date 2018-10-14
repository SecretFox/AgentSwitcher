﻿/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.plaf.basic.icon.SolidArrowIcon;
import GUI.fox.aswing.plaf.UIResource;

/**
 * The default arrow icon for menu
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.icon.MenuArrowIcon extends SolidArrowIcon implements UIResource {
		
	public function MenuArrowIcon(){
		super(0, 8, ASColor.BLACK);
	}
}