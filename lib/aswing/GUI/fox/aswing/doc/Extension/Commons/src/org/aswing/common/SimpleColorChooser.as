/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.border.BevelBorder;
import org.aswing.BorderLayout;
import org.aswing.colorchooser.JColorSwatches;
import org.aswing.geom.Point;
import org.aswing.JPopup;

/**
 * A simple color chooser popup a switcher to let user select on color and then 
 * close the popup and fire the selection event.
 * 
 * @author iiley
 */
class org.aswing.common.SimpleColorChooser {
	
	private var window:JPopup;
	private var switcher:JColorSwatches;
	private var handler:Function;
	
	private static var instance:SimpleColorChooser;
	private static function getInstance():SimpleColorChooser{
		if(instance == null){
			instance = new SimpleColorChooser();
		}
		return instance;
	}
	
	private function SimpleColorChooser(){
		switcher = new JColorSwatches();
		switcher.setOpaque(true);
		window = new JPopup(null, true);
		window.append(switcher, BorderLayout.CENTER);
		window.setBorder(new BevelBorder(null, BevelBorder.RAISED));
		
		switcher.addChangeListener(__colorChanged, this);
	}
	
	/**
	 * Shows the chooser
	 * @param gp the global position of the chooser popup
	 * @param color default selected color
	 * @param handler when user finish selection, handler(newColor:ASColor) will be called, null means user canceled.
	 * @param down is pop-up down, false means pop-up up
	 * @param alpha whether show the alpha selector
	 */
	public static function showChooser(gp:Point, color:ASColor, handler:Function, down:Boolean, alpha:Boolean):Void{
		getInstance().show(gp, color, handler, down, alpha);
	}
	
	private function __colorChanged():Void{
		if(window.isShowing()){//make sure it is selected by user changing
			Mouse.removeListener(this);
			window.dispose();
			handler(switcher.getSelectedColor());
		}
	}
	
	private function show(gp:Point, color:ASColor, handler:Function, down:Boolean, alpha:Boolean):Void{
		this.handler = handler;
		switcher.setSelectedColor(color);
		switcher.setAlphaSectionVisible(alpha);
		window.pack();
		window.show();
		if(!down){
			gp.y -= window.getHeight();
		}
		window.setGlobalLocation(gp);
		Mouse.removeListener(this);
		Mouse.addListener(this);
	}
	
	private function onMouseDown():Void{
		if(!window.hitTestMouse()){
			Mouse.removeListener(this);
			window.dispose();
			handler(null);
		}
	}
	
}