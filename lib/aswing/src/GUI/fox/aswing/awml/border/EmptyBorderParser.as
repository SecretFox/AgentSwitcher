/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.border.DecorateBorderParser;
import GUI.fox.aswing.border.EmptyBorder;
import GUI.fox.aswing.Insets;

/**
 *  Parses {@link GUI.fox.aswing.border.EmptyBorder} level element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.border.EmptyBorderParser extends DecorateBorderParser {
	
	/**
	 * Constructor.
	 */
	public function EmptyBorderParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, border:EmptyBorder) {
		
		border = super.parse(awml, border);
		
		return border;
	}

	private function parseChild(awml:XMLNode, nodeName:String, border:EmptyBorder):Void {
		
		super.parseChild(awml, nodeName, border);

		switch(nodeName) {
			case AwmlConstants.NODE_INSETS:
				var insets:Insets = AwmlParser.parse(awml);
				if (insets != null) border.setInsets(insets);
				break; 
		}
	}
	
    private function getClass(Void):Function {
    	return EmptyBorder;	
    }
	
}