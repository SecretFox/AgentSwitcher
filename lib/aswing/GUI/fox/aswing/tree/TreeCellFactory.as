/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.tree.TreeCell;

/**
 * TreeCellFactory for create cells for tree
 * @author iiley
 */
interface GUI.fox.aswing.tree.TreeCellFactory {
	/**
	 * Creates a new tree cell.
	 * @return the tree cell
	 */
	public function createNewCell():TreeCell;
}