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
class com.iiley.aswing.laf.comeny.icon.FrameIconifiedIcon extends FrameTitleIcon implements Icon, UIResource {
	
	public function FrameIconifiedIcon(){
		super();
		width = 34;
	}
		
	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var btn:AbstractButton = AbstractButton(com);
		var mc:MovieClip = getCreateDecorateMC(com);
		mc._rotation = -10;
		mc._x = x + width/2;
		mc._y = y + height/2;
		mc.clear();
		var w:Number = 20;
		var h:Number = 7;
		g = new Graphics(mc);
		var cl:ASColor = btn.getModel().isRollOver() ? color.luminanceAdjusted(0.2) : color;
		if(btn.getModel().isPressed()){
			g.fillEllipse(new SolidBrush(cl), -w/2 + 1, -h/2 + 1, w, h);
		}else{
			g.fillEllipse(new SolidBrush(color.luminanceAdjusted(-0.86)), -w/2 + 2, -h/2 + 2, w, h);
			g.fillEllipse(new SolidBrush(cl), -w/2, -h/2, w, h);
		}
	}
}