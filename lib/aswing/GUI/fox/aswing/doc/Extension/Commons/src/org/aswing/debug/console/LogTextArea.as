/*
 CopyRight @ 2005 XLands.com INC. All rights reserved.
*/

import org.aswing.richtext.RichTextArea;

/**
 * @author iiley
 */
class org.aswing.debug.console.LogTextArea extends RichTextArea {
	
	public function LogTextArea(text : String, rows : Number, columns : Number) {
		super(text, rows, columns);
	}
	
	public function getPrivateTextField():TextField{
		return getTextField();
	}
}