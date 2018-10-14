/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.table.TableColumnModel;
import GUI.fox.aswing.table.TableColumnModelEvent;

/**
 * TableColumnModelListener defines the interface for an object that listens
 * to changes in a TableColumnModel.
 * 
 * @author iiley
 */
interface GUI.fox.aswing.table.TableColumnModelListener {

    /** Tells listeners that a column was added to the model. */
    public function columnAdded(e:TableColumnModelEvent):Void;

    /** Tells listeners that a column was removed from the model. */
    public function columnRemoved(e:TableColumnModelEvent):Void;

    /** Tells listeners that a column was repositioned. */
    public function columnMoved(e:TableColumnModelEvent):Void;

    /** Tells listeners that a column was moved due to a margin change. */
    public function columnMarginChanged(source:TableColumnModel):Void;

    /**
     * Tells listeners that the selection model of the
     * TableColumnModel changed.
     */
    public function columnSelectionChanged(source:TableColumnModel, firstIndex:Number, lastIndex:Number):Void;
}