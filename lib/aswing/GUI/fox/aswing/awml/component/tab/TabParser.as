/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlTabInfo;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.awml.component.tab.AbstractTabParser;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.Icon;

/**
 *  Parses tabs for {@link GUI.fox.aswing.JTabbedPane} and
 *  {@link GUI.fox.aswing.JAccordion}.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.tab.TabParser extends AbstractTabParser {
	
	private static var ATTR_TITLE:String = "title";
	private static var ATTR_TOOL_TIP:String = "tool-tip";
	
	/**
	 * Constructor.
	 */
	public function TabParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, tab:AwmlTabInfo, namespace:AwmlNamespace) {

		tab = super.parse(awml, tab, namespace);
		
		// init title
		tab.title = getAttributeAsString(awml, ATTR_TITLE, "");
		
		// init tool tip
		tab.tooltip = getAttributeAsString(awml, ATTR_TOOL_TIP, null);

		return tab;
	}

    private function parseChild(awml:XMLNode, nodeName:String, tab:AwmlTabInfo, namespace:AwmlNamespace):Void {
    	super.parseChild(awml, nodeName, tab, namespace);
    
    	if (AwmlUtils.isIconNode(nodeName)) {
    		var icon:Icon = AwmlParser.parse(awml);
    		if (icon != null) tab.icon = icon;	
    	} else if (AwmlUtils.isComponentNode(nodeName)) {
    		var component:Component = AwmlParser.parse(awml, null, namespace);
    		if (component != null) tab.component = component;	
    	}
    }

}