/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.ToggleButtonParser;
import GUI.fox.aswing.JCheckBox;

/**
 * Parses {@link GUI.fox.aswing.JCheckBox} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.CheckBoxParser extends ToggleButtonParser {
    
    /**
     * Constructor.
     */
    public function CheckBoxParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, check:JCheckBox, namespace:AwmlNamespace) {
    	
        check = super.parse(awml, check, namespace);
        
        return check;
	}
	
    private function getClass(Void):Function {
    	return JCheckBox;	
    }
	    
}
