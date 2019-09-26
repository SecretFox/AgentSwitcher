/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractButtonParser;
import GUI.fox.aswing.JButton;

/**
 * Parses {@link GUI.fox.aswing.JButton} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.ButtonParser extends AbstractButtonParser {
    
    /**
     * Constructor.
     */
    public function ButtonParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, button:JButton, namespace:AwmlNamespace) {
    	
        button = super.parse(awml, button, namespace);
        
        return button;
	}
    
    private function getClass(Void):Function {
    	return JButton;	
    }
    
}
