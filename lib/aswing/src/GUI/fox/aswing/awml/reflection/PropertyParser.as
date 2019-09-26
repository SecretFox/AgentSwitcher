/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.util.Delegate;
import GUI.fox.aswing.util.Reflection;

/**
 *  Parses property AWML reflection element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.reflection.PropertyParser extends AbstractParser {
	
	private static var ATTR_NAME:String = "name";
	
	/**
	 * Constructor.
	 */
	public function PropertyParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, object:Object) {
	
		// get property name
		var name:String = getAttributeAsString(awml, ATTR_NAME, null);
		
		try {
			super.parse(awml, Delegate.create(this, setProperty, object, name));
		} catch (e:Error) {
			trace("AWML Warning: Appropriate property is not found for node: " + awml.toString());	
		}
	}

	private function parseChild(awml:XMLNode, nodeName:String, setter:Function):Void {
		
		super.parseChild(awml, nodeName);

		if (AwmlUtils.isPropertyNode(nodeName)) {
			var value = AwmlParser.parse(awml);
			if (value !== undefined) {
				setter(value);
			}
		}
	}

	private function setProperty(value, instance, propertyName:String):Void {
		Reflection.setProperty(instance, propertyName, value);
	}

}