/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.Icon;

/**
 * Wraps custom icon.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.icon.IconWrapperParser extends AbstractParser {
	
	/**
	 * Constructor.
	 */
	public function IconWrapperParser(Void) {
		super();
	}
	
	/**
	 * Searches for {@link GUI.fox.aswing.Icon} implementation among child nodes, creates icon 
	 * instance and returns it.
	 */
	public function parse(awml:XMLNode):Icon {
		
		for (var i = 0; i < awml.childNodes.length; i++) {
			if(AwmlUtils.isIconNode(AwmlUtils.getNodeName(awml.childNodes[i]))) {
				var icon:Icon = Icon(AwmlParser.parse(awml.childNodes[i]));
				if (icon != null) return icon;
			}	
		}
		
		return null;
	}

}