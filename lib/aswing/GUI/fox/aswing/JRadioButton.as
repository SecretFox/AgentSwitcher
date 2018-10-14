﻿/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JToggleButton;
import GUI.fox.aswing.RadioButtonModel;

/**
 * An implementation of a radio button -- an item that can be selected or
 * deselected, and which displays its state to the user.
 * Used with a {@link ButtonGroup} object to create a group of buttons
 * in which only one button at a time can be selected. (Create a ButtonGroup
 * object and use its <code>append</code> method to include the JRadioButton objects
 * in the group.)
 * <blockquote>
 * <strong>Note:</strong>
 * The ButtonGroup object is a logical grouping -- not a physical grouping.
 * To create a button panel, you should still create a {@link JPanel} or similar
 * container-object and add a {@link GUI.fox.aswing.border.Border} to it to set it off from surrounding
 * components.
 * </blockquote>
 * @author iiley
 */
class GUI.fox.aswing.JRadioButton extends JToggleButton{
	
	public function JRadioButton(text:String, icon:Icon) {
		super(text, icon);
		setName("JRadioButton");
		setModel(new RadioButtonModel());
	}
    
	public function getUIClassID():String{
		return "RadioButtonUI";
	}
	
	public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.asw.ASWingRadioButtonUI;
    }
}
