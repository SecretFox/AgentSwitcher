/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;

/**
 *  Parses text for {@link GUI.fox.aswing.JTextComponent}.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.text.TextParser extends AbstractParser {
	
	/**
	 * Constructor.
	 */
	public function TextParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode):String {
		
		super.parse(awml);
		
		// init text
		var text:String = "";
		
		for (var i = 0; i < awml.childNodes.length; i++) {
			text += getValueAsString(awml.childNodes[i], "");	
		}
			
		return text;
	}

}