/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractColorChooserPanelParser;
import GUI.fox.aswing.colorchooser.JColorSwatches;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.awml.AwmlParser;

/**
 * Parses {@link GUI.fox.aswing.colorchooser.JColorSwatches} level elements.
 * 
 * @author Dina Nasy
 */
class GUI.fox.aswing.awml.component.ColorSwatchesParser extends AbstractColorChooserPanelParser
{
		
	public function ColorSwatchesParser(Void) {
		super();
	}
	
    public function parse(awml:XMLNode, colorSwatches:JColorSwatches, namespace:AwmlNamespace) {
    	
        colorSwatches = super.parse(awml, colorSwatches, namespace);
        
        return colorSwatches;
	}

    private function parseChild(awml:XMLNode, nodeName:String, colorSwatches:JColorSwatches, namespace:AwmlNamespace):Void {

        super.parseChild(awml, nodeName, colorSwatches, namespace);
        
        if (AwmlUtils.isComponentNode(nodeName)) {
            var component:Component = AwmlParser.parse(awml, null, namespace);
            if (component != null) { 
            	colorSwatches.addComponentColorSectionBar(component);
            }
        }   
    }   
	
	private function getClass(Void):Function {
    	return JColorSwatches;	
    }

}
