/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.ContainerParser;
import GUI.fox.aswing.JPanel;

/**
 * Parses {@link GUI.fox.aswing.JPanel} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.PanelParser extends ContainerParser {
    
    /**
     * Constructor.
     */
    public function PanelParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, panel:JPanel, namespace:AwmlNamespace) {
    	
        panel = super.parse(awml, panel, namespace);
        
        return panel;
	}
 
    private function getClass(Void):Function {
    	return JPanel;	
    }
    
}
