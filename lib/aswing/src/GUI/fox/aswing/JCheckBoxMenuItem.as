/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JMenuItem;
import GUI.fox.aswing.ToggleButtonModel;

/**
 * A menu item that can be selected or deselected. If selected, the menu
 * item typically appears with a checkmark next to it. If unselected or
 * deselected, the menu item appears without a checkmark. Like a regular
 * menu item, a check box menu item can have either text or a graphic
 * icon associated with it, or both.
 * @author iiley
 */
class GUI.fox.aswing.JCheckBoxMenuItem extends JMenuItem {
	
	public function JCheckBoxMenuItem(text, icon : Icon) {
		super(text, icon);
		setName("JCheckBoxMenuItem");
    	setModel(new ToggleButtonModel());
	}

	public function getUIClassID():String{
		return "CheckBoxMenuItemUI";
	}
	
	public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.basic.BasicCheckBoxMenuItemUI;
    }
}