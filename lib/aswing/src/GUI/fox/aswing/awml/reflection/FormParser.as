/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.reflection.ComponentParser;
import GUI.fox.aswing.Container;

/**
 *  Parses form component AWML reflection element (JFrame, JWindow, MCPanel).
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.reflection.FormParser extends ComponentParser {
	
	/**
	 * Constructor.
	 */
	public function FormParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, form:Container, namespace:AwmlNamespace) {
	
		form = super.parse(awml, form, namespace);
		
		return form;
	}

	private function getConstructorArgs(awml:XMLNode):Array {
		return ([getOwner(awml)]).concat(super.getConstructorArgs(awml)); 
	}
}