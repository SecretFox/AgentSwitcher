/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.awml.core.ComponentObjectParser;
import GUI.fox.aswing.Component;

/**
 *  Parses component AWML reflection element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.reflection.ComponentParser extends ComponentObjectParser {
	
	/**
	 * Constructor.
	 */
	public function ComponentParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, component:Component, namespace:AwmlNamespace) {
		
		component = super.parse(awml, component, namespace);
		
		return component;
	}

	private function parseChild(awml:XMLNode, nodeName:String, component:Component, namespace:AwmlNamespace):Void {
		
		super.parseChild(awml, nodeName, component, namespace);

		switch (nodeName) {
			case AwmlConstants.NODE_COMPONENT:
				var child:Component = AwmlParser.parse(awml, null, namespace);
				if (child != null) {
					if (component["getContentPane"] != null) {
						component["getContentPane"]().append(child);
					} else {
						component["append"](child);
					}
				}
				break;	
		}
	}

	private function getConstructorArgs(awml:XMLNode):Array {
		
		var args = new Array();
		
		var constructorNode:XMLNode = AwmlUtils.getNodeChild(awml, AwmlConstants.NODE_CONSTRUCTOR);
		if (constructorNode != null) {
			args = AwmlParser.parse(constructorNode);
		}
		
		return args;
	}

    private function getArguments(awml:XMLNode):Array {
    	return getConstructorArgs(awml);	
    }

}