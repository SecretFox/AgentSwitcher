/*
 Copyright aswing.org, see the LICENCE.txt.
*/
/**
* @author firdosh
*/
import org.aswing.AbstractButton;
import org.aswing.ASWingUtils;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.Icon;
import org.aswing.Insets;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.winxp.WinXpToggleButtonUI;
import org.aswing.UIManager;

class org.aswing.plaf.winxp.WinXpRadioButtonUI extends WinXpToggleButtonUI{
	 // Shared UI object
    private static var radioButtonUI:WinXpRadioButtonUI;
    
    private var defaultIcon:Icon;
    private var defaults_radiobutton_initialized:Boolean;
    private static var propertyPrefix:String = "RadioButton" + ".";

    // ********************************
    //          Create PLAF
    // ********************************
    public static function createInstance(c:Component):ComponentUI {
    	if(radioButtonUI == null){
    		radioButtonUI = new WinXpRadioButtonUI();
    	}
        return radioButtonUI;
    }

    private function getPropertyPrefix():String {
        return propertyPrefix;
    }
    
    public function WinXpRadioButtonUI() {
    	super();
    	defaults_radiobutton_initialized = false;
    	checkRectsForCountLayout();
    }
    
    // ********************************
    //        Install PLAF 
    // ********************************
    private function installDefaults(b:AbstractButton):Void{
        super.installDefaults(b);
        if(!defaults_radiobutton_initialized) {
            defaultIcon = UIManager.getIcon(getPropertyPrefix() + "icon");
            defaults_radiobutton_initialized = true;
        }
    }

    // ********************************
    //        Uninstall PLAF 
    // ********************************
    private function uninstallDefaults(b:AbstractButton):Void{
        super.uninstallDefaults(b);
        defaults_radiobutton_initialized = false;
    }

    public function getDefaultIcon():Icon {
        return defaultIcon;
    }    
    
    /* These rectangles/insets are allocated once for all 
     * ButtonUI.paint() calls.  Re-using rectangles rather than 
     * allocating them in each paint call substantially reduced the time
     * it took paint to run.  Obviously, this method can't be re-entered.
     */
	private static var viewRect:Rectangle;
    private static var textRect:Rectangle;
    private static var iconRect:Rectangle;
       
    private static function checkRectsForCountLayout():Void{
    	if(viewRect == null){
			viewRect = new Rectangle();
    		textRect = new Rectangle();
    		iconRect = new Rectangle();
    	}
    }
    
    public function paint(c:Component, g:Graphics, r:Rectangle):Void{
    	var b:AbstractButton = AbstractButton(c);
    	var model:ButtonModel = b.getModel();
    	paintBackGround(b, g, r);
    	
    	var insets:Insets = b.getMargin();
    	if(insets != null){
    		r = insets.getInsideBounds(r);
    	}
    	viewRect.setRect(r);
    	
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;

		var altIcon:Icon = b.getIcon();

        // layout the text and icon
        var text:String = ASWingUtils.layoutCompoundLabel(
            c.getFont(), b.getText(), altIcon != null ? altIcon : getDefaultIcon(), 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getText() == null ? 0 : b.getIconTextGap());
		// Paint the radio button
		if (altIcon != null) {
			if (!model.isEnabled()) {
				if (model.isSelected()) {
					altIcon = b.getDisabledSelectedIcon();
				} else {
					altIcon = b.getDisabledIcon();
				}
			} else if (model.isPressed()) {
				altIcon = b.getPressedIcon();
				if (altIcon == null) {
					// Use selected icon
					altIcon = b.getSelectedIcon();
				}
			} else if (model.isSelected()) {
				if (b.isRollOverEnabled() && model.isRollOver()) {
					altIcon = b.getRollOverSelectedIcon();
					if (altIcon == null) {
						altIcon = b.getSelectedIcon();
					}
				} else {
					altIcon = b.getSelectedIcon();
				}
			} else if (b.isRollOverEnabled() && model.isRollOver()) {
				altIcon = b.getRollOverIcon();
			}

			if (altIcon == null) {
				altIcon = b.getIcon();
			}
		} else {
			altIcon = getDefaultIcon();
		}
		unistallLastPaintIcon(b, altIcon);
		altIcon.paintIcon(b, g, iconRect.x, iconRect.y);
    	setJustPaintedIcon(b, altIcon);
	    
	    //paint text
        if (text != null && text != ""){
			paintText(b, textRect, text);
        }
    }
    
    //just fill rect with background color
    private function paintBackGround(c:Component, g:Graphics, b:Rectangle):Void{
    	fillBackGround(c, g, b);
    }
    
    public function getPreferredSize(c:Component):Dimension{
    	var b:AbstractButton = AbstractButton(c);
    	var icon:Icon = b.getIcon();
    	if(icon == null) icon = getDefaultIcon();
    	var text:String = b.getText();
    	return getButtonPreferredSize(b, icon, text);
    }

    public function getMinimumSize(c:Component):Dimension{
    	var b:AbstractButton = AbstractButton(c);
    	var icon:Icon = b.getIcon();
    	if(icon == null) icon = getDefaultIcon();
    	var text:String = b.getText();
    	return getButtonMinimumSize(b, icon, text);
    }  
}
