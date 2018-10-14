/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.awml.core.CreatableObjectParser;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.border.DecorateBorder;

/**
 *  Parses {@link GUI.fox.aswing.border.DecorateBorder} level element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.border.DecorateBorderParser extends CreatableObjectParser {
	
	/**
	 * Private Constructor.
	 */
	private function DecorateBorderParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, border:DecorateBorder) {
		
		if (border == null) {
			border = create(awml);	
		}
		
		super.parse(awml, border);
		
		return border;
	}

	private function parseChild(awml:XMLNode, nodeName:String, border:DecorateBorder):Void {
		
		super.parseChild(awml, nodeName, border);
		
		if (AwmlUtils.isBorderNode(nodeName)) {
			var interior:Border = AwmlParser.parse(awml);
			if (interior != null) border.setInterior(interior); 
		}
	}	

}