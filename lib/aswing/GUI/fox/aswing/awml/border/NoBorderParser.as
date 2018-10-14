/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.core.ObjectParser;

/**
 *  Parses {@link GUI.fox.aswing.border.EmptyBorder} level element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.border.NoBorderParser extends ObjectParser {
	
	/**
	 * Constructor.
	 */
	public function NoBorderParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode) {
		return null;
	}

}