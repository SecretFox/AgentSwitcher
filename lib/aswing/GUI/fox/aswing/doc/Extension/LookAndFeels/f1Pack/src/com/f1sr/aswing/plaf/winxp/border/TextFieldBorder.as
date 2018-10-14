/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.ASColor;
import org.aswing.border.Border;
import org.aswing.UIManager;

import com.f1sr.aswing.plaf.winxp.border.TextBorder;


 
class com.f1sr.aswing.plaf.winxp.border.TextFieldBorder extends TextBorder 
{
	
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