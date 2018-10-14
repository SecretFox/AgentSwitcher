/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AbstractParser;
import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.JTable;

/**
 *  Parses table column list.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.table.TableColumnsParser extends AbstractParser {
	
	/**
	 * Constructor.
	 */
	public function TableColumnsParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, table:JTable) {
		super.parse(awml, table);
	}

	private function parseChild(awml:XMLNode, nodeName:String, table:JTable):Void {

		super.parseChild(awml, nodeName, table);
		
		if (nodeName == AwmlConstants.NODE_TABLE_COLUMN) {
			AwmlParser.parse(awml, table);
		}
	}

}