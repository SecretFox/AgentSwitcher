/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractTabbedPaneParser;
import GUI.fox.aswing.JAccordion;

/**
 * Parses {@link GUI.fox.aswing.JAccordion} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.AccordionParser extends AbstractTabbedPaneParser {
    
    /**
     * Constructor.
     */
    public function AccordionParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, accordion:JAccordion, namespace:AwmlNamespace) {
    	
        accordion = super.parse(awml, accordion, namespace);
        
        return accordion;
	}

    private function getClass(Void):Function {
    	return JAccordion;	
    }
    
}
