/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlTabInfo;

/**
 *  Parses tabs for tab-based components.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.tab.AbstractTabParser extends AbstractParser {
	
	/**
	 * Constructor.
	 */
	private function AbstractTabParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, tab:AwmlTabInfo, namespace:AwmlNamespace) {
		
		if (tab == null) {
			tab = new AwmlTabInfo();
		}
		
		tab = super.parse(awml, tab, namespace);
		
		return tab;
	}

}