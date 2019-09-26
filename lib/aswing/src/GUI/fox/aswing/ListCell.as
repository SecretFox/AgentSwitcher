/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.Cell;
import GUI.fox.aswing.JList;

/**
 * @author iiley
 */
interface GUI.fox.aswing.ListCell extends Cell{
	/**
	 * Sets the table cell status, include the owner-JList, isSelected, the cell index.
	 * @param the cell's owner, a JList
	 * @param isSelected true to set the cell selected, false to set not selected.
	 * @param index the index of the list item
	 */
	public function setListCellStatus(list:JList, isSelected:Boolean, index:Number):Void;
}
