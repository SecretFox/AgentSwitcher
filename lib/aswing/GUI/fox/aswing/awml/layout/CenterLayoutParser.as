/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.layout.EmptyLayoutParser;
import GUI.fox.aswing.CenterLayout;

/**
 * Parses {@link GUI.fox.aswing.CenterLayout}.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.layout.CenterLayoutParser extends EmptyLayoutParser {
	
	/**
     * Constructor.
     */
	public function CenterLayoutParser(Void) {
		super();
	}

	public function parse(awml:XMLNode, layout:CenterLayout) {
		
		layout = super.parse(awml, layout);
		
		return layout;
	}
	
    private function getClass(Void):Function {
    	return CenterLayout;	
    }
		
}