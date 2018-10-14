/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.plaf.UIResource;

import com.iiley.aswing.laf.comeny.icon.FrameTitleIcon;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.icon.FrameMaximizeIcon extends FrameTitleIcon implements Icon, UIResource {
		
	public function FrameMaximizeIcon(){
		super();
		width = 28;
	}
		
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var btn:AbstractButton = AbstractButton(com);
		var mc:MovieClip = getCreateDecorateMC(com);
		mc._x = x + width/2;
		mc._y = y + height/2 - 2;
		mc.clear();
		var w:Number = 19;
		var h:Number = 19;
		g = new Graphics(mc);
		var cl:ASColor = btn.getModel().isRollOver() ? color.luminanceAdjusted(0.2) : color;
		if(btn.getModel().isPressed()){
			g.beginFill(new SolidBrush(cl));
			g.circle(1, 1, w/2);
			g.circle(1, 1, w/4-0.5);
			g.endFill();
		}else{
			g.beginFill(new SolidBrush(color.luminanceAdjusted(-0.86)));
			g.circle(2, 2, w/2);
			g.circle(2, 2, w/4-0.5);
			g.endFill();
			
			g.beginFill(new SolidBrush(cl));
			g.circle(0, 0, w/2);
			g.circle(0, 0, w/4-0.5);
			g.endFill();
		}
	}
}