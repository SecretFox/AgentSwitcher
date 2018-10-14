/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.JSlider;
import GUI.fox.aswing.JTextField;
import GUI.fox.aswing.plaf.ComponentUI;

/**
 * Pluggable look and feel interface for JAdjuster.
 * 
 * @author iiley
 */
class GUI.fox.aswing.plaf.AdjusterUI extends ComponentUI {
	
	public function AdjusterUI() {
		super();
	}
	
	public function getInputText():JTextField{
		trace("Subclass should override this method!");
		throw new Error("Subclass should override this method!");
		return null;
	}
	
	public function getPopupSlider():JSlider{
		trace("Subclass should override this method!");
		throw new Error("Subclass should override this method!");
		return null;
	}
}