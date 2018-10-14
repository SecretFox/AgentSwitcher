import GUI.fox.aswing.JButton;
import GUI.fox.aswing.geom.Dimension;
import GUI.fox.aswing.JFrame;
/**
 * @author Fox
	Removes maximize button from the titlebar and makes minimize button work for minimizing/normalizing the window.
	By default this class would use maximize button(With changed icon) to change back to original size
 */
class GUI.fox.aswing.tswlaf.TitleBarUI extends GUI.fox.aswing.plaf.basic.frame.TitleBarUI {
	public function TitleBarUI() {
		super();
	}
	//Don't add max button
	private function installComponents() : Void {
		iconifiedButton = new JButton(null, iconifiedIcon);
		closeButton     = new JButton(null, closeIcon);
		titleBar.append(iconifiedButton);
		titleBar.append(closeButton);
		
		iconifiedButton.addActionListener(__iconifiedPressed, this);
		closeButton.addActionListener(__closePressed, this);
	}
	//Don't hide mini button
	private function __stateChanged():Void{
		var state:Number = frame.getState();
		if(state != JFrame.ICONIFIED
			&& state != JFrame.NORMAL
			&& state != JFrame.MAXIMIZED_HORIZ
			&& state != JFrame.MAXIMIZED_VERT
			&& state != JFrame.MAXIMIZED)
		{
			state = JFrame.NORMAL;
		}
		if(state == JFrame.ICONIFIED){
			switchResizeIcon();
			var iconifiedSize:Dimension = titleBar.getMinimumSize();
			stateChangeSize = true;
			frame.setSize(frame.getInsets().getOutsideSize(iconifiedSize));
			stateChangeSize = false;
			Stage.removeListener(stageChangedListener);
		}else if(state == JFrame.NORMAL){
			stateChangeSize = true;
			frame.setBounds(lastNormalStateBounds);
			stateChangeSize = false;
			switchToNormalButton();
			Stage.removeListener(stageChangedListener);
		}else{
			//setSizeToFixMaxmimized();
			//Had to comment this out,otherwise double-clicking the title would still maximize the window
		}
		frame.revalidateIfNecessary();
	}
	
	//change minimize icon instead of maximize
	public function switchToMaximizButton():Void{
		iconifiedButton.setIcon(normalIcon);
	}
	//change minimize icon instead of maximize
	public function switchToNormalButton():Void{
		iconifiedButton.setIcon(iconifiedIcon);
	}
	//check minimize icon instead
	public function isNormalIcon():Boolean{
		return iconifiedButton.getIcon() == iconifiedIcon;
	}
	//check whether to return to normal or minimize
	private function __iconifiedPressed():Void{
		if(isNormalIcon()){
			frame.setState(JFrame.ICONIFIED);
		}else{
			frame.setState(JFrame.NORMAL);
		}
	}
	//always show mini button when resizeable
		private function isNeedToViewIconifiedButton():Boolean{
		return frame.isResizable();
	}
}
