/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractButtonParser;
import GUI.fox.aswing.JToggleButton;

/**
 * Parses {@link GUI.fox.aswing.JToggleButton} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.ToggleButtonParser extends AbstractButtonParser {
        
    /**
     * Constructor.
     */
    public function ToggleButtonParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, button:JToggleButton, namespace:AwmlNamespace) {
    	
        button = super.parse(awml, button, namespace);
        
        return button;
	}
    
    private function getClass(Void):Function {
    	return JToggleButton;	
    }
    
}
