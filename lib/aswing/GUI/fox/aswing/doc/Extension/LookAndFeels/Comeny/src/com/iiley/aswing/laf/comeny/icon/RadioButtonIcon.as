/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.plaf.UIResource;
import org.aswing.UIManager;
import org.aswing.util.AdvancedColor;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.icon.RadioButtonIcon implements Icon, UIResource {
	
	private static var instance:Icon;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Icon{
		if(instance == null){
			instance = new RadioButtonIcon();
		}
		return instance;
	}
	
	private var radius:Number;
	
	public function RadioButtonIcon(){
		radius = 20;
	}
	
	public function getIconWidth() : Number {
		return radius;
	}

	public function getIconHeight() : Number {
		return radius;
	}

	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var outC:AdvancedColor = AdvancedColor.getAdvancedColor(UIManager.getColor("RadioButton.shadow"));
		var bgC:AdvancedColor = outC.luminanceAdjusted(0.9);
		var lightC:AdvancedColor = AdvancedColor.getAdvancedColor(UIManager.getColor("RadioButton.light"));
		var inC:AdvancedColor = lightC;
		
		var b:AbstractButton = AbstractButton(com);
		var m:ButtonModel = b.getModel();
		
		if(m.isRollOver()){
			outC = lightC;
		}
		if(!b.isEnabled()){
			inC = inC.saturationAdjusted(-0.5);
			bgC = outC.luminanceAdjusted(0.6);
		}
		
		var r:Number = radius/2;
		x += r;
		y += r;
		var thinkness:Number = 4;
		var gap:Number = 1;
		
		g.fillCircle(new SolidBrush(outC), x, y, r);
		
		g.fillCircle(new SolidBrush(bgC), x, y, r-thinkness);
		
		if(m.isPressed() || m.isSelected()){
			g.fillCircle(new SolidBrush(inC), x, y, r-thinkness-gap);
		}
	}

	public function uninstallIcon(com : Component) : Void {
	}

}