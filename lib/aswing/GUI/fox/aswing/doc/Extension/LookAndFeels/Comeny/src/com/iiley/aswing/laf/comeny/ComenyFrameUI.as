/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicFrameUI;
import org.aswing.UIManager;

import com.iiley.aswing.laf.comeny.frame.FrameLayout;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.ComenyFrameUI extends BasicFrameUI {
	    
	private var activeColor:ASColor;
	private var activeTextColor:ASColor;
	private var inactiveColor:ASColor;
	private var inactiveTextColor:ASColor;
	
	public static var OUT_ROUND:Number = 36;
	public static var IN_ROUND:Number = 26;
	public static var SIZE_BORDER:Number = 5;
	
	private var _frameLayout:FrameLayout;
		
	public function ComenyFrameUI(){
		super();
	}
	    
    private function installDefaults():Void{
    	super.installDefaults();
		activeColor         = UIManager.getColor("Frame.activeCaption");
		activeTextColor     = UIManager.getColor("Frame.activeCaptionText");
		inactiveColor       = UIManager.getColor("Frame.inactiveCaption");
		inactiveTextColor   = UIManager.getColor("Frame.inactiveCaptionText");
		_frameLayout = new FrameLayout(OUT_ROUND, IN_ROUND, SIZE_BORDER);
		frame.setLayout(_frameLayout);
    }
    
	public function paint(c:Component, g:Graphics, b:Rectangle):Void{
		var borderC:ASColor = frame.isActive() ? activeColor : inactiveColor;
		var bgC:ASColor = frame.getBackground();
		var titleHeight:Number = _frameLayout.getTitleBarMargin().getOutsideSize(titleBar.getSize()).height;
		var o_r:Number = OUT_ROUND;
		var i_r:Number = IN_ROUND;
		var s_b:Number = SIZE_BORDER;
		var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;
		
		var o_r_lt:Number = o_r;
		var o_r_rt:Number = o_r;
		var o_r_lb:Number = o_r;
		var o_r_rb:Number = o_r;
		if(h < 2*o_r){
			if(h >= o_r){
				o_r_lb = o_r_rb = Math.floor(h - o_r);
			}else{
				o_r_lt = o_r_rt = h;
				o_r_lb = o_r_rb = 0;
			}
		}
		var ch:Number = h - titleHeight;
		var i_r_lt:Number = i_r;
		var i_r_rt:Number = i_r;
		var i_r_lb:Number = i_r;
		var i_r_rb:Number = i_r;
		if(ch < 2*i_r){
			i_r_lt = i_r_rt = i_r_lb = i_r_rb = Math.floor(ch/2);
		}
		
		if(c.isOpaque()){
			g.fillRoundRect(
				new SolidBrush(borderC), 
				x, y, w, h, 
				o_r_lt, o_r_rt, o_r_lb, o_r_rb);
			if(ch > s_b){
				g.fillRoundRect(new SolidBrush(bgC), 
							x + s_b, y+titleHeight, w-s_b*2, h-s_b-titleHeight, 
							i_r_lt, i_r_rt, i_r_lb, i_r_rb);
			}
		}else{
			g.beginFill(new SolidBrush(borderC));
			g.roundRect(x, y, w, h, 
						o_r_lt, o_r_rt, o_r_lb, o_r_rb);
			if(ch > s_b){
				g.roundRect(x + s_b, y+titleHeight, w-s_b*2, h-s_b-titleHeight, 
						i_r_lt, i_r_rt, i_r_lb, i_r_rb);
			}
			g.endFill();
		}
    }
}