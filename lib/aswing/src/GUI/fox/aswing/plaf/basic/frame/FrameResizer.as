/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.resizer.DefaultResizer;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.frame.FrameResizer extends DefaultResizer {
	
	public function FrameResizer() {
		super();
		setResizeArrowColor(UIManager.getColor("Frame.resizeArrow"));
		setResizeArrowLightColor(UIManager.getColor("Frame.resizeArrowLight"));
		setResizeArrowDarkColor(UIManager.getColor("Frame.resizeArrowDark"));
	}

}