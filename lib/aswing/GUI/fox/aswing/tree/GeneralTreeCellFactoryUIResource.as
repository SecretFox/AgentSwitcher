/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.tree.GeneralTreeCellFactory;

/**
 * @author iiley
 */
class GUI.fox.aswing.tree.GeneralTreeCellFactoryUIResource extends GeneralTreeCellFactory 
	implements UIResource{
	
	public function GeneralTreeCellFactoryUIResource(cellClass : Function) {
		super(cellClass);
	}

}