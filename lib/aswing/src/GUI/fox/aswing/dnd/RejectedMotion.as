/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.dnd.DropMotion;
import GUI.fox.aswing.geom.Point;
import GUI.fox.aswing.util.EnterFrameImpulser;
import GUI.fox.aswing.util.Impulser;
import GUI.fox.aswing.util.MCUtils;

/**
 * The motion of the drop target does not accept the dropped initiator. 
 * @author iiley
 */
class GUI.fox.aswing.dnd.RejectedMotion implements DropMotion{
	
	private var timer:Impulser;
	private var initiatorPos:Point;
	private var dragMC:MovieClip;
	
	public function RejectedMotion(){
		timer = new EnterFrameImpulser(1);
		timer.addActionListener(__enterFrame, this);
	}
	
	private function startNewMotion(dragInitiator:Component, dragMC : MovieClip):Void{
		this.dragMC = dragMC;
		initiatorPos = dragInitiator.getGlobalLocation();
		if(initiatorPos == null){
			initiatorPos = new Point();
		}
		timer.start();
	}
	
	public function startMotionAndLaterRemove(dragInitiator:Component, dragMC : MovieClip) : Void {
		//create a new instance to do motion, avoid muiltiple motion shared instance
		var motion:RejectedMotion = new RejectedMotion();
		motion.startNewMotion(dragInitiator, dragMC);
	}
	
	private function __enterFrame():Void{
		//check first
		if(!MCUtils.isMovieClipExist(dragMC)){
			timer.stop();
			return;
		}
		var speed:Number = 0.25;
		
		var p:Point = new Point(dragMC._x, dragMC._y);
		dragMC._parent.localToGlobal(p);
		p.x += (initiatorPos.x - p.x) * speed;
		p.y += (initiatorPos.y - p.y) * speed;
		if(p.distance(initiatorPos) < 1){
			dragMC.removeMovieClip();
			timer.stop();
			return;
		}
		dragMC._parent.globalToLocal(p);
		dragMC._alpha += (4 - dragMC._alpha) * speed;
		dragMC._x = p.x;
		dragMC._y = p.y;
	}
}