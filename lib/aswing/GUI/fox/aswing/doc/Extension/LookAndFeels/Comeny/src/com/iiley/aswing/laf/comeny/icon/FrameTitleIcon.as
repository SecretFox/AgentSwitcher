/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.Component;
import org.aswing.ComponentDecorator;
import org.aswing.graphics.Graphics;
import org.aswing.Icon;
import org.aswing.plaf.UIResource;
import org.aswing.UIManager;
import org.aswing.util.AdvancedColor;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.icon.FrameTitleIcon extends ComponentDecorator implements Icon, UIResource {
	
	private var color:AdvancedColor;
	private var width:Number;
	private var height:Number;
	
	public function FrameTitleIcon(){
		color = AdvancedColor.getAdvancedColor(UIManager.getColor("controlLight"));
		width = 30;
		height = 28;
	}
	
	public function getIconWidth() : Number {
		return width;
	}

	public function getIconHeight() : Number {
		return height;
	}
	
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
	}

	public function uninstallIcon(com : Component) : Void {
		removeDecorateMC(com);
	}

	
}