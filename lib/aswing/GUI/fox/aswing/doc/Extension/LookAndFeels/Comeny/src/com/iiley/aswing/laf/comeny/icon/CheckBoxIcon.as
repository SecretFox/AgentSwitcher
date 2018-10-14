/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.geom.Point;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.plaf.UIResource;
import org.aswing.UIManager;
import org.aswing.util.AdvancedColor;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.icon.CheckBoxIcon implements Icon, UIResource {
		
	private static var instance:Icon;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Icon{
		if(instance == null){
			instance = new CheckBoxIcon();
		}
		return instance;
	}
	
	private var w:Number;
	
	public function CheckBoxIcon(){
		w = 25;
	}
	
	public function getIconWidth() : Number {
		return w;
	}

	public function getIconHeight() : Number {
		return w;
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
		
		var margin:Number = 2;
		var t:Number = 3;
		var offset:Number = 2;
		
		g.fillRectangle(new SolidBrush(outC), x+margin, y+margin, w-margin*2, w-margin*2);
		
		g.fillRectangle(new SolidBrush(bgC), x+t+margin, y+t+margin, w-t*2-margin*2, w-t*2-margin*2);
		
		if(m.isPressed() || m.isSelected()){
			var ps:Array = [new Point(2, 15), 
							new Point(7, 11.5), 
							new Point(10.5, 17.5), 
							new Point(23, 2), 
							new Point(23, 10), 
							new Point(11, 22)];
			for(var i:Number=0; i<ps.length; i++){
				var p:Point = Point(ps[i]);
				p.move(x + offset-1, y + offset-1);
			}
			fillV(g, ps, inC.luminanceAdjusted(-0.86));
			
			for(var i:Number=0; i<ps.length; i++){
				var p:Point = Point(ps[i]);
				p.move(-offset, -offset);
			}
			fillV(g, ps, inC);
		}
	}
	
	private function fillV(g:Graphics, ps:Array, c:ASColor):Void{
		g.beginFill(new SolidBrush(c));
		g.moveTo(ps[0].x, ps[0].y);
		g.lineTo(ps[1].x, ps[1].y);
		g.lineTo(ps[2].x, ps[2].y);
		g.curveTo((ps[2].x + ps[3].x)/2-1, (ps[2].y + ps[3].y)/2-3, 
			ps[3].x, ps[3].y);
		g.lineTo(ps[4].x, ps[4].y);
		g.curveTo((ps[4].x + ps[5].x)/2, (ps[4].y + ps[5].y)/2-3, 
			ps[5].x, ps[5].y);
		g.curveTo((ps[0].x + ps[5].x)/2-1, (ps[0].y + ps[5].y)/2-2, 
				ps[0].x, ps[0].y);
		g.endFill();
	}

	public function uninstallIcon(com : Component) : Void {
	}
	
}