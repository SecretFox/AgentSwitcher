/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.Container;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.LayoutManager;
import GUI.fox.aswing.plaf.basic.frame.TitleBarLayout;
import GUI.fox.aswing.plaf.ComponentUI;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.frame.FrameTitleBar extends Container {
	
	
	private var frame:JFrame;
	
	public function FrameTitleBar(frame:JFrame) {
		super();
		setName("FrameTitleBar");
		this.frame = frame;
		//updateUI is called in FrameUI to make it be controlled by FrameUI
		//updateUI();
	}
	
	public function setLayout(l:LayoutManager):Void{
		if(l instanceof TitleBarLayout){
			super.setLayout(l);
		}else{
			trace("FrameTitleBar just can accept FrameTitleBar!");
			throw new Error("FrameTitleBar just can accept FrameTitleBar!");
		}
	}
		
	public function getFrame():JFrame{
		return frame;
	}
	
    public function updateUI():Void{
    	//trace("FrameTitleBar is a instanceof Container? : " + (this instanceof Container));
    	setUI(UIManager.getUI(this));
    }
    
    public function setUI(newUI:ComponentUI):Void{
    	//trace("FrameTitleBar setUI : " + this);
    	super.setUI(newUI);
    }
	
	public function getUIClassID():String{
		return "Frame.titleBarUI";
	}
}
