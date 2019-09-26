/*
 CopyRight @ 2005 XLands.com INC. All rights reserved.
*/

import GUI.fox.aswing.Icon;
import GUI.fox.aswing.tree.list.AbstractListTreeCell;
import GUI.fox.aswing.tree.TreePath;

/**
 * @author iiley
 */
class GUI.fox.aswing.tree.list.DefaultListTreeCell extends AbstractListTreeCell {
	
	public function DefaultListTreeCell() {
		super();
	}
	
	//Override this
	private function getCellIcon(path:TreePath):Icon{
		return null;
	}
	
	//Override this
	private function getCellText(path:TreePath):String{
		return path.getLastPathComponent().toString();
	}
}