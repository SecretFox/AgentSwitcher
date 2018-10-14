/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.plaf.basic.BasicPanelUI;
import GUI.fox.aswing.plaf.ComponentUI;
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingPanelUI extends BasicPanelUI{
	/*shared instance*/
	private static var asWingPanelUI:ASWingPanelUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(asWingPanelUI == null){
    		asWingPanelUI = new ASWingPanelUI();
    	}
        return asWingPanelUI;
    }
    
    public function ASWingPanelUI(){
    	super();
    }	
}
