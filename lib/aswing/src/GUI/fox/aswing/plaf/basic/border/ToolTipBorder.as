/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.border.LineBorder;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIManager;

/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.border.ToolTipBorder extends LineBorder implements UIResource{
	
	private static var instance:Border;
	/**
	 * this make shared instance.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new ToolTipBorder(UIManager.getColor("ToolTip.borderColor"));
		}
		return instance;
	}
	
	public function ToolTipBorder(color:ASColor) {
		super(null, color, 1);
	}

}
