/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.event.TableModelEvent;

/**
 * TableModelListener defines the interface for an object that listens
 * to changes in a TableModel.
 * @author iiley
 */
interface GUI.fox.aswing.event.TableModelListener {
    /**
     * This fine grain notification tells listeners the exact range
     * of cells, rows, or columns that changed.
     */
    public function tableChanged(e:TableModelEvent):Void;
}