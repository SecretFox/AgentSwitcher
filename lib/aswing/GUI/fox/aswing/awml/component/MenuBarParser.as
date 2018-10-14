/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.component.ComponentParser;
import GUI.fox.aswing.JMenu;
import GUI.fox.aswing.JMenuBar;

/**
 * Parses {@link GUI.fox.aswing.JMenuBar} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.MenuBarParser extends ComponentParser {
    
    /**
     * Constructor.
     */
    public function MenuBarParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, bar:JMenuBar, namespace:AwmlNamespace) {
    	
        bar = super.parse(awml, bar, namespace);
        
        return bar;
	}
	
    private function parseChild(awml:XMLNode, nodeName:String, bar:JMenuBar, namespace:AwmlNamespace):Void {

        super.parseChild(awml, nodeName, bar, namespace);

		if (nodeName == AwmlConstants.NODE_MENU) {
			var	menu:JMenu = AwmlParser.parse(awml, null, namespace);
			if (menu != null) bar.append(menu);
		}
    }	

    private function getClass(Void):Function {
    	return JMenuBar;	
    }

}
