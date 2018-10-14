/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.Component;
import GUI.fox.aswing.JViewport;
import GUI.fox.aswing.LookAndFeel;
import GUI.fox.aswing.plaf.ComponentUI;
import GUI.fox.aswing.plaf.ViewportUI;
 
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.BasicViewportUI extends ViewportUI{

    // Shared UI object
    private static var viewportUI:ViewportUI;

    public static function createInstance(c:Component):ComponentUI {
		if(viewportUI == null) {
            viewportUI = new BasicViewportUI();
		}
        return viewportUI;
    }
    
    public function installUI(c:Component):Void {
        var p:JViewport = JViewport(c);
        installDefaults(p);
    }

    public function uninstallUI(c:Component):Void {
        var p:JViewport = JViewport(c);
        uninstallDefaults(p);
    }

    private function installDefaults(p:JViewport):Void {
    	var pp:String = "Viewport.";
        LookAndFeel.installColorsAndFont(p, pp + "background", pp + "foreground", pp + "font");
        LookAndFeel.installBorder(p, "Viewport.border");
        LookAndFeel.installBasicProperties(p, pp);
    }

    private function uninstallDefaults(p:JViewport):Void {
        LookAndFeel.uninstallBorder(p);
    }
}
