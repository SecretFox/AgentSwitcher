/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.tree.TreeCell;
import GUI.fox.aswing.tree.TreeCellFactory;

/**
 * @author iiley
 */
class GUI.fox.aswing.tree.GeneralTreeCellFactory implements TreeCellFactory {
		
	private var cellClass:Function;
	
	/**
	 * GeneralTreeCellFactory(cellClass:Function)<br>
	 * <p>
	 * Creates a GeneralTreeCellFactory with specified cell class.
	 * @param cellClass the cell class
	 */
	public function GeneralTreeCellFactory(cellClass:Function){
		this.cellClass = cellClass;
	}
	
	/**
	 * Creates and returns a new tree cell.
	 * @return the tree cell
	 */
	public function createNewCell():TreeCell{
		return new cellClass();
	}
	
	public function toString():String{
		return "GeneralTreeCellFactory[cellClass:" + cellClass + "]";
	}
}