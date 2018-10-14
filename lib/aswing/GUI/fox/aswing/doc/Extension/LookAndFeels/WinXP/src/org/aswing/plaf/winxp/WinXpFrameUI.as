/*
 Copyright aswing.org, see the LICENCE.txt.
*/
/**
 * @author firdosh
 */
import org.aswing.Component;
import org.aswing.plaf.basic.BasicFrameUI;
import org.aswing.plaf.ComponentUI;
 
class org.aswing.plaf.winxp.WinXpFrameUI extends BasicFrameUI{
	
	public function WinXpFrameUI() {
		super();
	}  
    public static function createInstance(c:Component):ComponentUI {
        return new WinXpFrameUI();
    }
	
}
