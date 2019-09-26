/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.MenuItemParser;
import GUI.fox.aswing.JMenu;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.awml.AwmlParser;

/**
 * Parses {@link GUI.fox.aswing.JMenu} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.MenuParser extends MenuItemParser {
    
    private static var ATTR_DELAY:String = "delay";
    private static var ATTR_POPUP_MENU_VISIBLE:String = "popup-menu-visible";
    
    /**
     * Constructor.
     */
    public function MenuParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, menu:JMenu, namespace:AwmlNamespace) {
    	
        menu = super.parse(awml, menu, namespace);
        
        // init popup menu
        menu.setDelay(getAttributeAsNumber(awml, ATTR_DELAY, menu.getDelay()));
        menu.setPopupMenuVisible(getAttributeAsBoolean(awml, ATTR_POPUP_MENU_VISIBLE, menu.isPopupMenuVisible()));
        
        return menu;
	}
	
    private function parseChild(awml:XMLNode, nodeName:String, menu:JMenu, namespace:AwmlNamespace):Void {
    	super.parseChild(awml, nodeName, menu, namespace);
    	
		if (AwmlUtils.isMenuItemNode(nodeName)) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) menu.append(component); 	
		}
    }	
    
    private function getClass(Void):Function {
    	return JMenu;	
    }
    
}
