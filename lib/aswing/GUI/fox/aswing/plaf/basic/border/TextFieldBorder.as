/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.plaf.basic.border.TextBorder;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.border.TextFieldBorder extends TextBorder {
		
	private static var instance:Border;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new TextFieldBorder(
							UIManager.getColor("TextField.shadow"),
							UIManager.getColor("TextField.darkShadow"),
							UIManager.getColor("TextField.light"),
							UIManager.getColor("TextField.highlight")		
			);
		}
		return instance;
	}
	
	public function TextFieldBorder(shadow : ASColor, darkShadow : ASColor, light : ASColor, highlight : ASColor) {
		super(shadow, darkShadow, light, highlight);
	}

}
