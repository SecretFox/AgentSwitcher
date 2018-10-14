/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.util.Reflection;
import GUI.fox.aswing.awml.core.ObjectParser;

/**
 *  Creates classes instance from the AWML reflection element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.reflection.InstanceParser extends ObjectParser {
	
	private static var ATTR_CLASS:String = "class";
	
	/**
	 * Constructor.
	 */
	public function InstanceParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode) {
	
		// get class name
		var className:String = getAttributeAsString(awml, ATTR_CLASS);
	
		// get constructors arguments
		var args = new Array();
		
		var constructorNode:XMLNode = AwmlUtils.getNodeChild(awml, AwmlConstants.NODE_CONSTRUCTOR);
		if (constructorNode != null) {
			args = AwmlParser.parse(constructorNode);
		}
		
		// get reference to class constructor
		var constructor:Function = Reflection.getClass(className);
		
		// create class instance
		var instance;
		
		try {
		 	instance = Reflection.createInstance(constructor, args);
		 	super.parse(awml, instance);
		} catch (e:Error) {
			trace("AWML Warning: Can't create instance for node: " + awml.toString());	
		}
	
		return instance;
	}

}