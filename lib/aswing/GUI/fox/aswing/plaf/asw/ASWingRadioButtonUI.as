/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.plaf.basic.BasicRadioButtonUI;
import GUI.fox.aswing.plaf.ComponentUI;
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingRadioButtonUI extends BasicRadioButtonUI{
	/*shared instance*/
	private static var asWingRadioButtonUI:ASWingRadioButtonUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(asWingRadioButtonUI == null){
    		asWingRadioButtonUI = new ASWingRadioButtonUI();
    	}
        return asWingRadioButtonUI;
    }
    
    public function ASWingRadioButtonUI(){
    	super();
    }	
}
