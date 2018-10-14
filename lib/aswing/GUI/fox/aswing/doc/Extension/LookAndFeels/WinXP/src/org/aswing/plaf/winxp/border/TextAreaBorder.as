/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.ASColor;
import org.aswing.border.Border;
import org.aswing.plaf.winxp.border.TextBorder;
import org.aswing.UIManager;

/**
 * @author iiley
 */
class org.aswing.plaf.winxp.border.TextAreaBorder extends TextBorder {
		
	private static var instance:Border;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new TextAreaBorder(
							UIManager.getColor("TextArea.shadow"),
							UIManager.getColor("TextArea.darkShadow"),
							UIManager.getColor("TextArea.light"),
							UIManager.getColor("TextArea.highlight")		
			);
		}
		return instance;
	}
	
	public function TextAreaBorder(shadow : ASColor, darkShadow : ASColor, light : ASColor, highlight : ASColor) {
		super(shadow, darkShadow, light, highlight);
	}

}
