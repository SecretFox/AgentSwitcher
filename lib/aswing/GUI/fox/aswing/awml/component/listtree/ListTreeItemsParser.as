/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlParser;

/**
 *  Parses list tree items collection.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.listtree.ListTreeItemsParser extends AbstractParser {
	
	/**
	 * Constructor.
	 */
	public function ListTreeItemsParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, collection:Array):Array {
		
		if (collection == null) {
			collection = new Array();	
		}	
	
		super.parse(awml, collection);
	
		return collection;
	}

	private function parseChild(awml:XMLNode, nodeName:String, collection:Array):Void {

		super.parseChild(awml, nodeName, collection);
		
		switch (nodeName) {
			case AwmlConstants.NODE_LIST_TREE_ITEM:
				var item:Object = AwmlParser.parse(awml);
				if (item != null) collection.push(item);
				break;
		}
	}

}