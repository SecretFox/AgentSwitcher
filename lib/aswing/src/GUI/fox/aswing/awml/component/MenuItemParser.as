/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractButtonParser;
import GUI.fox.aswing.JMenuItem;

/**
 * Parses {@link GUI.fox.aswing.JMenuItem} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.MenuItemParser extends AbstractButtonParser {
    
    /**
     * Constructor.
     */
    public function MenuItemParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, item:JMenuItem, namespace:AwmlNamespace) {
    	
        item = super.parse(awml, item, namespace);
        
        //TODO add ket accelerator support
        
        return item;
	}
    
    private function getClass(Void):Function {
    	return JMenuItem;	
    }
    
}
