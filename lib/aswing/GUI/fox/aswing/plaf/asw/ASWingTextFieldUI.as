/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.plaf.basic.BasicTextFieldUI;

/**
 * @author Tomato
 */
class GUI.fox.aswing.plaf.asw.ASWingTextFieldUI extends BasicTextFieldUI {
	
	private var aswTextUI:ASWingTextFieldUI;
	
	public function createInstance():ASWingTextFieldUI{
		if(aswTextUI == null){
			aswTextUI = new ASWingTextFieldUI();
		}
		return aswTextUI;
	}
	
	public function ASWingTextFieldUI() {
		super();
	}

}
