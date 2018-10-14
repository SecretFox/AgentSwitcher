/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.AbstractButton;
import GUI.fox.aswing.DefaultButtonModel;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.plaf.ButtonUI;
import GUI.fox.aswing.UIManager;
 
/**
 * An implementation of a "push" button.
 * @author iiley
 */
class GUI.fox.aswing.JButton extends AbstractButton{
	
	/**
     * JButton(text:String, icon:Icon)<br>
     * JButton(text:String)<br>
     * JButton(icon:Icon)
     * <p>
	 */
	public function JButton(text, icon:Icon){
		super(text, icon);
		setName("JButton");
    	setModel(new DefaultButtonModel());
		updateUI();
	}
	
    public function updateUI():Void{
    	setUI(ButtonUI(UIManager.getUI(this)));
    }
	
	public function getUIClassID():String{
		return "ButtonUI";
	}
	
    public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.asw.ASWingButtonUI;
    }
}
