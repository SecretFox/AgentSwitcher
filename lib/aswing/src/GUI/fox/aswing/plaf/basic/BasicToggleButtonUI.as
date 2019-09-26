/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.AbstractButton;
import GUI.fox.aswing.ButtonModel;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.plaf.basic.BasicButtonUI;
import GUI.fox.aswing.plaf.ComponentUI;
 
/**
 * Basic ToggleButton implementation.
 * To implement a Diff ToggleButton UI, generally you should:
 * <ul>
 * 	<li>extends your ButtonUI to inherite diff features of buttons.
 * 	<li>initialize differnt UI defaults for buttons in your LAF class, for example: Button.border, 
 * 	Button.font, ToggleButton.backgound XxxButton.foreground...
 * </ul>
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.BasicToggleButtonUI extends BasicButtonUI{
	
    // Shared UI object
    private static var toggleButtonUI:BasicToggleButtonUI;
    
    private static var propertyPrefix:String = "ToggleButton" + ".";

    // ********************************
    //          Create PLAF
    // ********************************
    public static function createInstance(c:Component):ComponentUI {
    	if(toggleButtonUI == null){
    		toggleButtonUI = new BasicToggleButtonUI();
    	}
        return toggleButtonUI;
    }

    private function getPropertyPrefix():String {
        return propertyPrefix;
    }
    
    public function BasicToggleButtonUI() {
    	super();
    }
        
    /**
     * Overriden so that the text will not be rendered as shifted for
     * Toggle buttons and subclasses.
     */
    private function getTextShiftOffset():Number{
    	return 0;
    }
    
    private function paintIcon(b:AbstractButton, g:Graphics, iconRect:Rectangle):Void{
        var model:ButtonModel = b.getModel();
        var icon:Icon = b.getIcon();

		if (!model.isEnabled()) {
			if (model.isSelected()) {
				icon = b.getDisabledSelectedIcon();
			} else {
				icon = b.getDisabledIcon();
			}
		} else if (model.isPressed()) {
			icon = b.getPressedIcon();
			if (icon == null) {
				// Use selected icon
				icon = b.getSelectedIcon();
			}
		} else if (model.isSelected()) {
			if (b.isRollOverEnabled() && model.isRollOver()) {
				icon = b.getRollOverSelectedIcon();
				if (icon == null) {
					icon = b.getSelectedIcon();
				}
			} else {
				icon = b.getSelectedIcon();
			}
		} else if (b.isRollOverEnabled() && model.isRollOver()) {
			icon = b.getRollOverIcon();
		}

		if (icon == null) {
			icon = b.getIcon();
		}

        unistallLastPaintIcon(b, icon);
        icon.paintIcon(b, g, iconRect.x, iconRect.y);
    	setJustPaintedIcon(b, icon);
    }
    
	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
		super.paintBackGround(com, g, b);
	}
}
