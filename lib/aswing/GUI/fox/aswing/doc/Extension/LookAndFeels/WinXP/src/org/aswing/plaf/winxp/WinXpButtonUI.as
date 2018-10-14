/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.plaf.basic.BasicButtonUI;
import org.aswing.plaf.ButtonUI;
import org.aswing.UIDefaults;
import org.aswing.UIManager;
 
/**
 *
 * @author Firdosh
 */
class org.aswing.plaf.winxp.WinXpButtonUI extends BasicButtonUI{
	
	private static var xpInstance:WinXpButtonUI;
	private var upperGrad:ASColor;
	private var lowerGrad:ASColor;
	private var background:ASColor;
    // ********************************
    //          Create WINXP
    // ********************************
    public static function createInstance(c:Component):ButtonUI {
    	if(xpInstance == null){
    		xpInstance = new WinXpButtonUI();
    	}
        return xpInstance;
    }
    
    public function WinXpButtonUI(){
    	super();    	
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
				 var ratios:Array = [0, 50];
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
