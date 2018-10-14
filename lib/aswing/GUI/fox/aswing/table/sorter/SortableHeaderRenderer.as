/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.table.sorter.SortableTextHeaderCell;
import GUI.fox.aswing.table.sorter.TableSorter;
import GUI.fox.aswing.table.TableCell;
import GUI.fox.aswing.table.TableCellFactory;

/**
 * @author iiley
 */
class GUI.fox.aswing.table.sorter.SortableHeaderRenderer implements TableCellFactory {
	
	private var tableSorter:TableSorter;
	private var originalRenderer:TableCellFactory;
	
	public function SortableHeaderRenderer(originalRenderer:TableCellFactory, tableSorter:TableSorter){
		this.originalRenderer = originalRenderer;
		this.tableSorter = tableSorter;
	}
	
	public function createNewCell(isHeader : Boolean) : TableCell {
		return new SortableTextHeaderCell(tableSorter);
	}
	
	public function getTableCellFactory():TableCellFactory{
		return null;
	}
}