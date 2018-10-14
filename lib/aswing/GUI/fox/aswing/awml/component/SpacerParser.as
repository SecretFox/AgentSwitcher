/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.ComponentParser;
import GUI.fox.aswing.JSpacer;

/**
 * Parses {@link GUI.fox.aswing.JSpacer} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.SpacerParser extends ComponentParser {
    
    /**
     * Constructor.
     */
    public function SpacerParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, spacer:JSpacer, namespace:AwmlNamespace) {
    	
        spacer = super.parse(awml, spacer, namespace);
        
        return spacer;
	}

    private function getClass(Void):Function {
    	return JSpacer;	
    }

}
