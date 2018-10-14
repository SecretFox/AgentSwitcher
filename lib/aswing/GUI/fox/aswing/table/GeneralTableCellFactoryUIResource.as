/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.table.GeneralTableCellFactory;

/**
 * @author iiley
 */
class GUI.fox.aswing.table.GeneralTableCellFactoryUIResource extends GeneralTableCellFactory implements UIResource{
	public function GeneralTableCellFactoryUIResource(cellClass:Function){
		super(cellClass);
	}
}