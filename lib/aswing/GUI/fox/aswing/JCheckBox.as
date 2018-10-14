/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JToggleButton;
 
/**
 * An implementation of a check box -- an item that can be selected or
 * deselected, and which displays its state to the user. 
 * By convention, any number of check boxes in a group can be selected.
 * @author iiley
 */
class GUI.fox.aswing.JCheckBox extends JToggleButton{
		
	/**
     * JCheckBox(text:String, icon:Icon)<br>
     * JCheckBox(text:String)<br>
     * JCheckBox(icon:Icon)
     * <p>
	 */		
	public function JCheckBox(text:String, icon:Icon) {
		super(text, icon);
		setName("JCheckBox");
	}
    
	public function getUIClassID():String{
		return "CheckBoxUI";
	}
	
	public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.asw.ASWingCheckBoxUI;
    }
}
