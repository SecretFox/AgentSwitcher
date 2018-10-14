/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.colorchooser.AbstractColorChooserPanel;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.plaf.ColorSwatchesUI;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.colorchooser.JColorSwatches extends AbstractColorChooserPanel {
		
	public function JColorSwatches() {
		super();
		updateUI();
	}

	public function setUI(ui:ColorSwatchesUI):Void{
		super.setUI(ui);
	}
	
	public function getUI():ColorSwatchesUI{
		return ColorSwatchesUI(ui);
	}
	
	public function updateUI():Void{
		setUI(ColorSwatchesUI(UIManager.getUI(this)));
	}
	
	public function getUIClassID():String{
		return "ColorSwatchesUI";
	}
	
	public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.basic.BasicColorSwatchesUI;
    }
	
	/**
	 * Adds a component to this panel's sections bar
	 * @param com the component to be added
	 */
	public function addComponentColorSectionBar(com:Component):Void{
		getUI().addComponentColorSectionBar(com);
	}
}