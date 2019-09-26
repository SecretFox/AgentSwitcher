/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.ASFont;
import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.border.DecorateBorderParser;
import GUI.fox.aswing.border.SimpleTitledBorder;

/**
 *  Parses {@link GUI.fox.aswing.border.SimpleTitledBorder} level element.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.border.SimpleTitledBorderParser extends DecorateBorderParser {
	
	private static var ATTR_TITLE:String = "title";
	private static var ATTR_OFFSET:String = "offset";
	private static var ATTR_ALIGN:String = "align";
	private static var ATTR_POSITION:String = "position";
	
	private static var POSITION_TOP:String = "top";
	private static var POSITION_BOTTOM:String = "bottom";
	
	private static var ALIGN_LEFT:String = "left";
	private static var ALIGN_CENTER:String = "center";
	private static var ALIGN_RIGHT:String = "right"; 
	
	/**
	 * Constructor.
	 */
	public function SimpleTitledBorderParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, border:SimpleTitledBorder) {
		
		border = super.parse(awml, border);
		
		// init title
		border.setTitle(getAttributeAsString(awml, ATTR_TITLE, border.getTitle()));
		
		// init offset
		border.setOffset(getAttributeAsNumber(awml, ATTR_OFFSET, border.getOffset()));
		
		// init position
		var position:String = getAttributeAsString(awml, ATTR_POSITION, null);
		switch (position) {
			case POSITION_TOP:
				border.setPosition(SimpleTitledBorder.TOP);
				break;
			case POSITION_BOTTOM:
				border.setPosition(SimpleTitledBorder.BOTTOM);	
				break;
		}

		// init align
		var align:String = getAttributeAsString(awml, ATTR_ALIGN, null);
		switch (align) {
			case ALIGN_LEFT:
				border.setAlign(SimpleTitledBorder.LEFT);
				break;
			case ALIGN_CENTER:
				border.setAlign(SimpleTitledBorder.CENTER);	
				break;
			case ALIGN_RIGHT:
				border.setAlign(SimpleTitledBorder.RIGHT);	
				break;
		}
		
		return border;
	}

	private function parseChild(awml:XMLNode, nodeName:String, border:SimpleTitledBorder):Void {
		
		super.parseChild(awml, nodeName, border);

		switch(nodeName) {
			case AwmlConstants.NODE_COLOR:
				var color:ASColor = AwmlParser.parse(awml);
				if (color != null) border.setColor(color);
				break; 
			case AwmlConstants.NODE_FONT:
				var font:ASFont = AwmlParser.parse(awml);
				if (font != null) border.setFont(font);
				break; 
		}
	}
	
    private function getClass(Void):Function {
    	return SimpleTitledBorder;	
    }
	
}