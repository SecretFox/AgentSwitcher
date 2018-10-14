/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.JSplitPane;

/**
 *  Parses components for {@link GUI.fox.aswing.JSplitPane}.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.split.SplitComponentParser extends AbstractParser {
	
	/**
	 * Constructor.
	 */
	public function SplitComponentParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, split:JSplitPane, namespace:AwmlNamespace) {

		for (var i = 0; i < awml.childNodes.length; i++) {
			if(AwmlUtils.isComponentNode(AwmlUtils.getNodeName(awml.childNodes[i]))) {
				var component:Component = Component(AwmlParser.parse(awml.childNodes[i], null, namespace));
				if (component != null) return component;
			}	
		}
		
		return null;
	}

}