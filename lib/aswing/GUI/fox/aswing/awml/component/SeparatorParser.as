/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.ComponentParser;
import GUI.fox.aswing.JSeparator;

/**
 * Parses {@link GUI.fox.aswing.JSeparator} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.SeparatorParser extends ComponentParser {
    
    private static var ATTR_ORIENTATION:String = "orientation";
    private static var ATTR_GAP:String = "gap";
    
    private static var ORIENTATION_HORIZONTAL:String = "horizontal";
    private static var ORIENTATION_VERTICAL:String = "vertical";
     
    
    /**
     * Constructor.
     */
    public function SeparatorParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, separator:JSeparator, namespace:AwmlNamespace) {
    	
        separator = super.parse(awml, separator, namespace);
        
        // init orientation
        var orientation:String = getAttributeAsString(awml, ATTR_ORIENTATION);
        switch (orientation) {
        	case ORIENTATION_HORIZONTAL:
        		separator.setOrientation(JSeparator.HORIZONTAL);
        		break;
        	case ORIENTATION_VERTICAL:
        		separator.setOrientation(JSeparator.VERTICAL);
        		break;	
        }
        
        // init gap
        separator.setGap(getAttributeAsNumber(awml, ATTR_GAP, separator.getGap()));
        
        return separator;
	}
    
    private function getClass(Void):Function {
    	return JSeparator;	
    }
    
}
