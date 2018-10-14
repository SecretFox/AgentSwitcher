/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.dnd.DropMotion;

/**
 * Remove the dragging movieclip directly.
 * @author iiley
 */
class GUI.fox.aswing.dnd.DirectlyRemoveMotion implements DropMotion{
	
	public function DirectlyRemoveMotion(){
	}
	
	public function startMotionAndLaterRemove(dragInitiator:Component, dragMC : MovieClip) : Void {
		dragMC.removeMovieClip();
	}

}