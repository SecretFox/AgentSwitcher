/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.JLabel;
import org.aswing.UIManager;
import org.aswing.util.Delegate;

/**
 * A label has button actions.
 * @author iiley
 * @version 1.0 2006.7.11
 */
class org.aswing.common.XLabelButton extends JLabel {
	
	private static var NORMAL:ASColor;
	private static var HIGHT_LIGHT:ASColor;
	private static var DISABLED:ASColor;
	
	private var normalColor:ASColor;
	private var lightColor:ASColor;
	private var disabledColor:ASColor;
	
	/**
	 * You may need to change the color styles here
	 */
	private static function checkColors():Void{
		if(NORMAL == null){
			NORMAL = new ASColor(0x669900);
			HIGHT_LIGHT = UIManager.getColor("Button.light");
			DISABLED = UIManager.getColor("Button.foreground");
		}
	}
	
	public function XLabelButton(text, icon, horizontalAlignment : Number) {
		super(text, icon, horizontalAlignment);
		
		checkColors();
		normalColor = NORMAL;
		lightColor = HIGHT_LIGHT;
		disabledColor = DISABLED;
		
		setUseHandCursor(true);
		
		var lis:Object = new Object();
		lis[JLabel.ON_ROLLOVER] = Delegate.create(this, __highlight);
		lis[JLabel.ON_ROLLOUT] = Delegate.create(this, __normal);
		lis[JLabel.ON_PRESS] = lis[JLabel.ON_ROLLOUT];
		addEventListener(lis);
		__normal();
		setFocusable(true);
		addEventListener(JLabel.ON_KEY_UP, __onXLabelKeyUp, this);
	}
	
	private function __onXLabelKeyUp():Void{
		if(Key.getCode() == Key.SPACE){
			fireActionEvent();
		}
	}
	
    /**
     * addActionListener(fuc:Function, obj:Object)<br>
     * addActionListener(fuc:Function)
     * <p>
     * Adds a action listener to this button. Buttons fire a action event when 
     * user released on it.
     * @param fuc the listener function.
     * @param Context in which to run the function of param func.
     * @return the listener just added.
     * @see EventDispatcher#ON_ACT
     * @see Component#ON_RELEASE
     */
    public function addActionListener(fuc:Function, obj:Object):Object{
    	return addEventListener(ON_ACT, fuc, obj);
    }
	
	public function setEnabled(b:Boolean):Void{
		if(b != isEnabled()){
			if(b){
				setForeground(normalColor);
			}else{
				setForeground(disabledColor);
			}
			repaint();
		}
		super.setEnabled(b);
	}
	
	public function __highlight():Void{
		setForeground(lightColor);
		repaint();
	}
	
	public function __normal():Void{
		setForeground(normalColor);
		repaint();
	}
	
	public function setNormalColor(c:ASColor):Void{
		if(getForeground() == normalColor){
			normalColor = c;
			__normal();
		}else{
			normalColor = c;
		}
	}
	public function setLightColor(c:ASColor):Void{
		if(getForeground() == lightColor){
			lightColor = c;
			__highlight();
		}else{
			lightColor = c;
		}
	}
	public function setDisabledColor(c:ASColor):Void{
		if(getForeground() == disabledColor){
			disabledColor = c;
			setForeground(disabledColor);
			repaint();
		}else{
			disabledColor = c;
		}
	}
	
	//------------------action listener implementation-----------
	private function __onRelease():Void{
		super.__onRelease();
		dispatchEvent(ON_ACT, createEventObj(ON_ACT));
	}
}