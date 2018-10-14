/*
 Copyright aswing.org, see the LICENCE.txt.
*/
/**
 * @author firdosh
 */
import org.aswing.AbstractButton;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.Icon;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.winxp.WinXpButtonUI;
import org.aswing.UIDefaults;
import org.aswing.UIManager;


class org.aswing.plaf.winxp.WinXpToggleButtonUI extends WinXpButtonUI{
	 // Shared UI object
    private static var toggleButtonUI:WinXpToggleButtonUI;
    
    private static var propertyPrefix:String = "ToggleButton" + ".";

    // ********************************
    //          Create PLAF
    // ********************************
    public static function createInstance(c:Component):ComponentUI {
    	if(toggleButtonUI == null){
    		toggleButtonUI = new WinXpToggleButtonUI();
    	}
        return toggleButtonUI;
    }

    private function getPropertyPrefix():String {
        return propertyPrefix;
    }
    
    public function WinXpToggleButtonUI() {
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
    
    /**
     * Paint gradient background for AsWing LAF Buttons.
     */
    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
    	var c:AbstractButton = AbstractButton(com);
    	paintWinXPLAFButtonBackGround(c, g, b);
    }
    
    public function paintWinXPLAFButtonBackGround(c:AbstractButton, g:Graphics, b:Rectangle):Void{
    	
    	
		if(c.isOpaque()){
			if(c.getModel().isPressed() || c.getModel().isSelected()){
				var table:UIDefaults = UIManager.getLookAndFeelDefaults();		
				this.upperGrad = table.getColor("Button.upperBgGradDown");
				this.lowerGrad = table.getColor("Button.lowerBgGradDown");
				 var colors:Array = [upperGrad.getRGB(), lowerGrad.getRGB()];
				 var alphas:Array = [100,100];
				 var ratios:Array = [0, 100];
				 var matrix:Object = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};        
	    		 var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);    	
     			 g.fillRoundRect(brush, b.x, b.y, b.width, b.height,3,3,3,3);
			}
			else{
				var table:UIDefaults = UIManager.getLookAndFeelDefaults();		
				this.upperGrad = table.getColor("Button.upperBgGradUp");
				this.lowerGrad = table.getColor("Button.lowerBgGradUp");	
				
				 var colors:Array = [upperGrad.getRGB(), lowerGrad.getRGB()];
				 var alphas:Array = [100,100];
				 var ratios:Array = [200, 255];
				 var matrix:Object = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};        
	    		 var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);    	
     			 g.fillRoundRect(brush, b.x, b.y, b.width, b.height,3,3,3,3);
				
			}    	
	   
			}
    }
	
	
}
