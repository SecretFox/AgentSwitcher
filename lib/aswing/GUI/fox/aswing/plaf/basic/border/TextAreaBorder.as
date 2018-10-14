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
class GUI.fox.aswing.plaf.basic.border.TextAreaBorder extends TextBorder {
		
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
	
	public function TextAreaBorder(shadow : ASColor, darkShadow : ASColor, light : ASColor, lighlight : ASColor) {
		super(shadow, darkShadow, light, lighlight);
	}

}
