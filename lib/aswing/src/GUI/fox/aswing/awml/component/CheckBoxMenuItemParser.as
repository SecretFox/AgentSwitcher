/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.MenuItemParser;
import GUI.fox.aswing.JCheckBoxMenuItem;

/**
 * Parses {@link GUI.fox.aswing.JCheckBoxMenuItem} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.CheckBoxMenuItemParser extends MenuItemParser {
    
    /**
     * Constructor.
     */
    public function CheckBoxMenuItemParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, item:JCheckBoxMenuItem, namespace:AwmlNamespace) {
    	
        item = super.parse(awml, item, namespace);
        
        return item;
	}
    
    private function getClass(Void):Function {
    	return JCheckBoxMenuItem;	
    }
    
}
