/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.Insets;

import com.f1sr.aswing.graphics.ExtraGraphicsUtils;

class com.f1sr.aswing.plaf.hightec.border.ButtonBorder extends org.aswing.plaf.basic.border.ButtonBorder{
	
	
	//private static var aswInstance:Border;
	/**
	 * this make shared instance and construct when use.
	 */
	/* 	
	public static function createInstance():Border{
		if(aswInstance == null){
			aswInstance = new ButtonBorder();
		}
		return aswInstance;
	}
	*/
	
	private function ButtonBorder(){
		super();
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, bounds:Rectangle):Void{
    	var isPressed:Boolean = false;
    	var radius:Number = 4;
		if(c instanceof AbstractButton)
		{
			var model:ButtonModel = (AbstractButton(c)).getModel();
			isPressed = model.isPressed() || model.isSelected();
		}
		ExtraGraphicsUtils.drawRoundedBorder(g, bounds, radius, isPressed, shadow,
                                   darkShadow, highlight, lightHighlight);
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets
	{
    	return new Insets(2, 2, 2, 2);
    }
    
}
