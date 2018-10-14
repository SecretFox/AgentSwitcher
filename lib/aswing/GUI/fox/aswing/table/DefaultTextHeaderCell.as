/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.JTable;
import GUI.fox.aswing.table.DefaultTextCell;
import GUI.fox.aswing.table.JTableHeader;
import GUI.fox.aswing.UIManager;

/**
 * Default table header cell to render text
 * @author iiley
 */
class GUI.fox.aswing.table.DefaultTextHeaderCell extends DefaultTextCell {
	
	public function DefaultTextHeaderCell() {
		super();
		setHorizontalAlignment(CENTER);
		setBorder(UIManager.getBorder("TableHeader.cellBorder"));
		setOpaque(false);
	}
	
	public function setTableCellStatus(table:JTable, isSelected:Boolean, row:Number, column:Number):Void{
		var header:JTableHeader = table.getTableHeader();
		if(header != null){
			setBackground(header.getBackground());
			setForeground(header.getForeground());
			setFont(table.getFont());
		}
	}
}