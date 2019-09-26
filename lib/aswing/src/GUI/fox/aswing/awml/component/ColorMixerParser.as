/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.AbstractColorChooserPanelParser;
import GUI.fox.aswing.colorchooser.JColorMixer;

/**
 * Parses {@link GUI.fox.aswing.colorchooser.JColorMixer} level elements.
 * 
 * @author Dina Nasy
 */
class GUI.fox.aswing.awml.component.ColorMixerParser extends AbstractColorChooserPanelParser
{
		
	public function ColorMixerParser(Void) {
		super();
	}
	
    public function parse(awml:XMLNode, colorMixer:JColorMixer, namespace:AwmlNamespace) {
    	
        colorMixer = super.parse(awml, colorMixer, namespace);
        
        return colorMixer;
	}

	private function getClass(Void):Function {
    	return JColorMixer;	
    }

}
