/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlTabInfo;
import GUI.fox.aswing.awml.component.AbstractColorChooserPanelParser;
import GUI.fox.aswing.colorchooser.AbstractColorChooserPanel;
import GUI.fox.aswing.JColorChooser;

/**
 * Parses {@link GUI.fox.aswing.JColorChooser} level elements.
 * 
 * @author Dina Nasy
 */
class GUI.fox.aswing.awml.component.ColorChooserParser extends AbstractColorChooserPanelParser
{
		
	public function ColorChooserParser(Void) {
		super();
	}
	
    public function parse(awml:XMLNode, colorChooser:JColorChooser, namespace:AwmlNamespace) {
    	
        colorChooser = super.parse(awml, colorChooser, namespace);
        
        return colorChooser;
	}

    private function parseChild(awml:XMLNode, nodeName:String, colorChooser:JColorChooser, namespace:AwmlNamespace):Void {
    	super.parseChild(awml, nodeName, colorChooser, namespace);
    	
    	if (nodeName == AwmlConstants.NODE_TAB) {
    		var tab:AwmlTabInfo = AwmlParser.parse(awml, null, namespace);
    		if (tab != null && AbstractColorChooserPanel(tab.component) != null) {
    			colorChooser.addChooserPanel(tab.title, AbstractColorChooserPanel(tab.component));	
    		}	
    	}
    }

	private function getClass(Void):Function {
    	return JColorChooser;	
    }

}
