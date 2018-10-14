/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.ASColor;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.JCheckBox;
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;

/**
 *
 * @author iiley
 */
class org.aswing.plaf.winxp.icon.CheckBoxIcon implements Icon, UIResource{
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
			instance = new CheckBoxIcon();
		}
		return instance;
	}

	private function CheckBoxIcon(){
		super();
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		highlight = table.getColor("CheckBox.highlight");
		upperGradUp = table.getColor("CheckBox.upperGradUp");
		lowerGradUp = table.getColor("CheckBox.lowerGradUp");
		dotUpperGradUp = table.getColor("CheckBox.dotUpperGradUp");
		dotLowerGradUp = table.getColor("CheckBox.dotLowerGradUp");
	}

	public function getIconWidth():Number{
		return 13;
	}

	public function getIconHeight():Number{
		return 13;
	}

	public function paintIcon(com:Component, g:Graphics, x:Number, y:Number):Void{
		var rb:JCheckBox = JCheckBox(com);
		var model:ButtonModel = rb.getModel();
		var drawDot:Boolean = model.isSelected();
				
		
		var w:Number = getIconWidth();
		var h:Number = getIconHeight();
		var cx:Number = x + w/2;
		var cy:Number = y + h/2;
		var xr:Number = w/2;
		var yr:Number = h/2;
			
		var x1:Number = x;
		var y1:Number = y;
		var x2:Number = x1 + getIconWidth();
		var y2:Number = y1 + getIconHeight()-y;
		
		// Set up colors per RadioButtonModel condition
		if (!model.isEnabled()) {
			
		} else if (model.isPressed()) {
			
		}
		
				
		var brush:SolidBrush=new SolidBrush(highlight);
		g.fillRectangle(brush,x1, y1, x2, y2);
		
      
       var colors:Array = [upperGradUp.getRGB(), lowerGradUp.getRGB()];
		var alphas:Array = [100, 100];
    	var ratios:Array = [50, 150];
	    var matrix:Object = {matrixType:"box", x:cx-xr, y:cy-yr, w:xr*2, h:yr*2, r:(45/180)*Math.PI};        
	    var gBrush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRectangle(gBrush,x1+1, y1+1, x2-2, y2-2);
	    
       		
		if(drawDot){
			var pen:Pen = new Pen(dotUpperGradUp, 2);
			g.drawLine(pen, cx-w/2+3, cy, cx-w/2/3, cy+h/2-3);
			g.drawLine(pen, cx-w/2/3, cy+h/2-1, cx+w/2, cy-h/2+1);
		}
		
	}
	public function uninstallIcon(com:Component):Void{
	}
}
