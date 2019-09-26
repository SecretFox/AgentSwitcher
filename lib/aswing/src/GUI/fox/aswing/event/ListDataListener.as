/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.event.ListDataEvent;

/**
 * @see GUI.fox.aswing.JList
 * @author iiley
 */
interface GUI.fox.aswing.event.ListDataListener{
    /** 
     * Sent after the indices in the index0,index1 
     * interval have been inserted in the data model.
     * The new interval includes both index0 and index1.
     *
     * @param e  a <code>ListDataEvent</code> encapsulating the
     *    event information
     */
    public function intervalAdded(e:ListDataEvent):Void;

    
    /**
     * Sent after the indices in the index0,index1 interval
     * have been removed from the data model.  The interval 
     * includes both index0 and index1.
     *
     * @param e  a <code>ListDataEvent</code> encapsulating the
     *    event information
     */
    public function intervalRemoved(e:ListDataEvent):Void;


    /** 
     * Sent when the contents of the list has changed in a way 
     * that's too complex to characterize with the previous 
     * methods. For example, this is sent when an item has been
     * replaced. Index0 and index1 bracket the change.
     *
     * @param e  a <code>ListDataEvent</code> encapsulating the
     *    event information
     */
    public function contentsChanged(e:ListDataEvent):Void;	
}
