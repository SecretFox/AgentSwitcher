/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.colorchooser.AbstractColorChooserPanel;
import GUI.fox.aswing.plaf.ColorMixerUI;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.colorchooser.JColorMixer extends AbstractColorChooserPanel {
	
	public function JColorMixer() {
		super();
		updateUI();
	}

	public function setUI(ui:ColorMixerUI):Void{
		super.setUI(ui);
	}
	
	public function getUI():ColorMixerUI{
		return ColorMixerUI(ui);
	}
	
	public function updateUI():Void{
		setUI(ColorMixerUI(UIManager.getUI(this)));
	}
	
	public function getUIClassID():String{
		return "ColorMixerUI";
	}
	
	public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.basic.BasicColorMixerUI;
    }
}