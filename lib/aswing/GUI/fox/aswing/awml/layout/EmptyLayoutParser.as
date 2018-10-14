/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.core.CreatableObjectParser;
import GUI.fox.aswing.EmptyLayout;

/**
 *  Parses {@link GUI.fox.aswing.EmptyLayout} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.layout.EmptyLayoutParser extends CreatableObjectParser {
	
	/**
	 * Constructor.
	 */
	public function EmptyLayoutParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, layout:EmptyLayout) {
		
		if (layout == null) {
			layout = create(awml);	
		}	
	
		super.parse(awml, layout);
	
		return layout;
	}

    private function getClass(Void):Function {
    	return EmptyLayout;	
    }

}