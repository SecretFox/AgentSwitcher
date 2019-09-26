/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.MenuItemParser;
import GUI.fox.aswing.JRadioButtonMenuItem;

/**
 * Parses {@link GUI.fox.aswing.JRadioButtonMenuItem} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.RadioButtonMenuItemParser extends MenuItemParser {
    
    /**
     * Constructor.
     */
    public function RadioButtonMenuItemParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, item:JRadioButtonMenuItem, namespace:AwmlNamespace) {
    	
        item = super.parse(awml, item, namespace);
        
        return item;
	}
    
    private function getClass(Void):Function {
    	return JRadioButtonMenuItem;	
    }
    
}
