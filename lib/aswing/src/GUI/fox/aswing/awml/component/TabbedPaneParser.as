/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractTabbedPaneParser;
import GUI.fox.aswing.JTabbedPane;

/**
 * Parses {@link GUI.fox.aswing.JTabbedPane} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.TabbedPaneParser extends AbstractTabbedPaneParser {
    
	private static var ATTR_TAB_PLACEMENT:String = "tab-placement";
	
	private static var TAB_PLACEMENT_TOP:String = "top";
	private static var TAB_PLACEMENT_LEFT:String = "left";
	private static var TAB_PLACEMENT_RIGHT:String = "right";
	private static var TAB_PLACEMENT_BOTTOM:String = "bottom";
    
    
    /**
     * Constructor.
     */
    public function TabbedPaneParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, pane:JTabbedPane, namespace:AwmlNamespace) {
    	
        pane = super.parse(awml, pane, namespace);
        
        // init tab placement
        var placement:String = getAttributeAsString(awml, ATTR_TAB_PLACEMENT);
        switch (placement) {
        	case TAB_PLACEMENT_TOP:
        		pane.setTabPlacement(JTabbedPane.TOP);
        		break;
        	case TAB_PLACEMENT_LEFT:
        		pane.setTabPlacement(JTabbedPane.LEFT);
        		break;
        	case TAB_PLACEMENT_RIGHT:
        		pane.setTabPlacement(JTabbedPane.RIGHT);
        		break;
        	case TAB_PLACEMENT_BOTTOM:
        		pane.setTabPlacement(JTabbedPane.BOTTOM);
        		break;
        }
        
        return pane;
	}
    
    private function getClass(Void):Function {
    	return JTabbedPane;	
    }
    
}
