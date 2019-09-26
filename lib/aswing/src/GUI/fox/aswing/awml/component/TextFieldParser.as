/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.TextComponentParser;
import GUI.fox.aswing.JTextField;

/**
 * Parses {@link GUI.fox.aswing.JTextField} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.TextFieldParser extends TextComponentParser {
	
	private static var ATTR_COLUMNS:String = "columns";
	
	/**
	 * Constructor.
	 */
	public function TextFieldParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, text:JTextField, namespace:AwmlNamespace) {
		
		text = super.parse(awml, text, namespace);
		
		// init columns
		text.setColumns(getAttributeAsNumber(awml, ATTR_COLUMNS, text.getColumns()));
		
        // init events
        attachEventListeners(text, JTextField.ON_ACT, getAttributeAsEventListenerInfos(awml, ATTR_ON_ACTION));
		
		return text;
	}
	
    private function getClass(Void):Function {
    	return JTextField;	
    }
	
}
