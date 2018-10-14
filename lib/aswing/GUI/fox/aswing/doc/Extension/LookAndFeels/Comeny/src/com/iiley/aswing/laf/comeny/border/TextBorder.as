/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.border.LineBorder;
import org.aswing.plaf.UIResource;
import org.aswing.UIManager;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.border.TextBorder extends LineBorder implements UIResource{
	
	public function TextBorder(){
		super(null, UIManager.getColor("control"), 2);
	}
	
}