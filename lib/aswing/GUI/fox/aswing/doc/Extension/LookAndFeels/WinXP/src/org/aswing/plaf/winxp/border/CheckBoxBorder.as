/**
 * @author firdosh
 */
 
import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.border.Border;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Insets;
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;
 
class org.aswing.plaf.winxp.border.CheckBoxBorder implements Border, UIResource{
	
	 private var darkShadow:ASColor;
    private var highlight:ASColor;	
	
	private static var winxpInstance:CheckBoxBorder;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():CheckBoxBorder{
		if(winxpInstance == null){
			winxpInstance = new CheckBoxBorder();
		}
		return winxpInstance;
	}
	
	private function CheckBoxBorder(){
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();		
		this.darkShadow = table.getColor("Button.darkShadow");
		this.highlight = table.getColor("Button.highlight");		
	}
	
	public function paintBorder(c:Component, g:Graphics, bounds:Rectangle):Void{
    	
    	var x1:Number = bounds.x;
		var y1:Number = bounds.y;
		var x2:Number = x1 + bounds.width;
		var y2:Number = y1 + bounds.height;
    	
    	var brush:SolidBrush=new SolidBrush(highlight);
		g.fillRectangle(brush,x1, y1, x2, y2);		
	   
    	var isPressed:Boolean = false;
		if(c instanceof AbstractButton){
			isPressed = (AbstractButton(c)).getModel().isPressed();
		}
		
		if(isPressed){
				
		}
		
        
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets{
    	return new Insets(1, 1, 1, 1);
    }
    
    public function uninstallBorder(c:Component):Void{
    }
}