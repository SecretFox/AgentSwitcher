/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.Container;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.CellRendererPane extends Container {
	
	public function CellRendererPane() {
		super();
		setName("CellRendererPane");
		setTriggerEnabled(false);
	}
	/**
	 * @return true always here.
	 */
	public function isValidateRoot():Boolean{
		return true;
	}
	
	/**
	 * Clears and then eturns a graphics of the Component.
	 */
	public function clearGraphics():Graphics{
		target_mc.clear();
		return getGraphics();
	}	
	
	/**
	 * Makes it do nothing.
	 */
	private function paint(b:Rectangle):Void{
	}
}