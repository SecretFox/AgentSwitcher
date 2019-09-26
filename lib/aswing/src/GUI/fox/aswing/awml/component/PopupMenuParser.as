/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.awml.component.ComponentParser;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.JPopupMenu;

/**
 * Parses {@link GUI.fox.aswing.JPopupMenu} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.PopupMenuParser extends ComponentParser {
    
    /**
     * Constructor.
     */
    public function PopupMenuParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, popup:JPopupMenu, namespace:AwmlNamespace) {
    	
        popup = super.parse(awml, popup, namespace);
        
        return popup;
	}
	
    private function parseChild(awml:XMLNode, nodeName:String, popup:JPopupMenu, namespace:AwmlNamespace):Void {

        super.parseChild(awml, nodeName, popup, namespace);

		if (AwmlUtils.isMenuItemNode(nodeName)) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) popup.append(component); 	
		}
    }	

    private function getClass(Void):Function {
    	return JPopupMenu;	
    }

}
