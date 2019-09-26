/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.Insets;
import GUI.fox.aswing.JTextComponent;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIDefaults;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.border.TextBorder implements Border, UIResource {
	
	
    private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
	
	public function TextBorder(shadow:ASColor, darkShadow:ASColor, light:ASColor, highlight:ASColor){
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		
		this.shadow = shadow;
		this.darkShadow = darkShadow;
		this.highlight = highlight;
		this.lightHighlight = light;
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, r:Rectangle):Void{
	    var x1:Number = r.x;
		var y1:Number = r.y;
		var w:Number = r.width;
		var h:Number = r.height;
		var textCom:JTextComponent = JTextComponent(c);
		if(textCom.isEditable() && textCom.isEnabled()){
			//just can't judge which is better of bottom two ways, both has flaw.:(
			g.drawRectangle(new Pen(highlight, 1), x1+0.5, y1+0.5, w-1, h-1);
			//g.fillRectangleRingWithThickness(new SolidBrush(highlight), x1,y1,w,h, 1);
		}
		g.drawRectangle(new Pen(lightHighlight, 1), x1+1.5, y1+1.5, w-3, h-3);
		//g.fillRectangleRingWithThickness(new SolidBrush(lightHighlight), x1+1,y1+1,w-2,h-2, 1);
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets{
    	return new Insets(2, 2, 2, 2);
    }
    
    public function uninstallBorder(c:Component):Void{
    }
	
}
