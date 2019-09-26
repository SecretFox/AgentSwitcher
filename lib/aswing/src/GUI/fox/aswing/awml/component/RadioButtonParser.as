/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.ToggleButtonParser;
import GUI.fox.aswing.JRadioButton;

/**
 * Parses {@link GUI.fox.aswing.JRadioButton} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.RadioButtonParser extends ToggleButtonParser {
    
    /**
     * Constructor.
     */
    public function RadioButtonParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, radio:JRadioButton, namespace:AwmlNamespace) {
    	
        radio = super.parse(awml, radio, namespace);
        
        return radio;
	}
    
    private function getClass(Void):Function {
    	return JRadioButton;	
    }
    
}
