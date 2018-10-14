/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.ASColor;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.JRadioButton;
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;
 
/**
 *
 * @author iiley
 */
class org.aswing.plaf.winxp.icon.RadioButtonIcon implements Icon, UIResource{
  
    private var highlight:ASColor;
    private var upperGradUp:ASColor;
    private var lowerGradUp:ASColor;
    private var dotUpperGradUp:ASColor;
    private var dotLowerGradUp:ASColor;
  

	private static var instance:Icon;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Icon{
		if(instance == null){
			instance = new RadioButtonIcon();
		}
		return instance;
	}

	private function RadioButtonIcon(){
		super();
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		
		highlight = table.getColor("RadioButton.highlight");
		upperGradUp = table.getColor("RadioButton.upperGradUp");
		lowerGradUp = table.getColor("RadioButton.lowerGradUp");
		dotUpperGradUp = table.getColor("RadioButton.dotUpperGradUp");
		dotLowerGradUp = table.getColor("RadioButton.dotLowerGradUp");
	}

	public function getIconWidth():Number{
		return 13;
	}

	public function getIconHeight():Number{
		return 13;
	}

	public function paintIcon(com:Component, g:Graphics, x:Number, y:Number):Void{
		var rb:JRadioButton = JRadioButton(com);
		var model:ButtonModel = rb.getModel();
		var drawDot:Boolean = model.isSelected();
		
		var w:Number = getIconWidth();
		var h:Number = getIconHeight();
		var cx:Number = x + w/2;
		var cy:Number = y + h/2;
		var xr:Number = w/2;
		var yr:Number = h/2;
		
		// Set up colors per RadioButtonModel condition
		if (!model.isEnabled()) {
			
		} else if (model.isPressed()) {
			
		}
		var sbrush:SolidBrush = new SolidBrush(highlight);
		g.fillEllipse(sbrush, cx-xr, cy-yr, xr*2, yr*2);
		
		xr--;
		yr--;
		
		
	    var colors:Array = [upperGradUp.getRGB(), lowerGradUp.getRGB()];
		var alphas:Array = [100, 100];
    	var ratios:Array = [50, 150];
	    var matrix:Object = {matrixType:"box", x:cx-xr, y:cy-yr, w:xr*2, h:yr*2, r:(45/180)*Math.PI};        
	    var gBrush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		g.fillEllipse(gBrush, cx-xr, cy-yr, xr*2, yr*2);
				
		if(drawDot){
			xr = w/5;
			yr = h/5;
			
			colors = [dotUpperGradUp.getRGB(), dotLowerGradUp.getRGB()];
			alphas= [100, 100];
    		ratios = [50, 150];
	    	matrix = {matrixType:"box", x:cx-xr, y:cy-yr, w:xr*2, h:yr*2, r:(45/180)*Math.PI};        
	    	gBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
			g.fillEllipse(gBrush, cx-xr, cy-yr, xr*2, yr*2);
			
		}
	}
	public function uninstallIcon(com:Component):Void{
	}
}
