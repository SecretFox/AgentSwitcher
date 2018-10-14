/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.Component;
import org.aswing.plaf.basic.BasicCheckBoxUI;
import org.aswing.plaf.ComponentUI;
 
/**
 *
 * @author iiley
 */
class org.aswing.plaf.winxp.WinXpCheckBoxUI extends BasicCheckBoxUI{
	/*shared instance*/
	private static var winxpCheckBoxUI:WinXpCheckBoxUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(winxpCheckBoxUI == null){
    		winxpCheckBoxUI = new WinXpCheckBoxUI();
    	}
        return winxpCheckBoxUI;
    }
    
    public function WinXpCheckBoxUI(){
    	super();
    }	
}
