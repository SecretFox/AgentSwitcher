/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.plaf.basic.BasicCheckBoxUI;
import GUI.fox.aswing.plaf.ComponentUI;
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingCheckBoxUI extends BasicCheckBoxUI{
	/*shared instance*/
	private static var asWingCheckBoxUI:ASWingCheckBoxUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(asWingCheckBoxUI == null){
    		asWingCheckBoxUI = new ASWingCheckBoxUI();
    	}
        return asWingCheckBoxUI;
    }
    
    public function ASWingCheckBoxUI(){
    	super();
    }	
}
