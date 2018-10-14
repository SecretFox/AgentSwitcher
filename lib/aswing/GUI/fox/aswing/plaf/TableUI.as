/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.geom.Dimension;
import GUI.fox.aswing.JTable;
import GUI.fox.aswing.plaf.ComponentUI;

/**
 * Pluggable look and feel interface for JTable.
 * @author iiley
 */
class GUI.fox.aswing.plaf.TableUI extends ComponentUI {
    /**
     * Returns the view size.
     */    
	public function getViewSize(table:JTable):Dimension{
		trace("Error : Subclass must override this method!");
		throw new Error("Subclass must override this method!");
		return null;
	}
}