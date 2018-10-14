/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.Component;
import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.LookAndFeel;
import GUI.fox.aswing.plaf.ComponentUI;
import GUI.fox.aswing.plaf.PanelUI;
 
/**
 * Basic Panel implementation.
 * To implement a Diff Panel UI, generally you should:
 * <ul>
 * 	<li>initialize differnt UI defaults for buttons in your LAF class, for example: Button.border, 
 * 	Button.font, ToggleButton.backgound XxxButton.foreground...
 * </ul>
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.BasicPanelUI extends PanelUI{

    // Shared UI object
    private static var panelUI:PanelUI;

    public static function createInstance(c:Component):ComponentUI {
		if(panelUI == null) {
            panelUI = new BasicPanelUI();
		}
        return panelUI;
    }
    
    private function BasicPanelUI(){
    }
    
    public function installUI(c:Component):Void {
        var p:JPanel = JPanel(c);
        installDefaults(p);
    }

    public function uninstallUI(c:Component):Void {
        var p:JPanel = JPanel(c);
        uninstallDefaults(p);
    }

    private function installDefaults(p:JPanel):Void {
    	var pp:String = "Panel.";
        LookAndFeel.installColorsAndFont(p, pp + "background", pp + "foreground", pp + "font");
        LookAndFeel.installBorder(p, "Panel.border");
        LookAndFeel.installBasicProperties(p, pp);
    }

    private function uninstallDefaults(p:JPanel):Void {
        LookAndFeel.uninstallBorder(p);
    }
}
