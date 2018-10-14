/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.Insets;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIDefaults;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.border.TableHeaderCellBorder implements Border, UIResource{
	
	private static var aswInstance:TableHeaderCellBorder;
	
	private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
    
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(aswInstance == null){
			aswInstance = new TableHeaderCellBorder();
		}else{
			aswInstance.reloadColors();
		}
		return aswInstance;
	}
	
	private function TableHeaderCellBorder(){
		super();
		reloadColors();
	}
	
	private function reloadColors():Void{
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		shadow = table.getColor("Button.shadow");
		darkShadow = table.getColor("Button.darkShadow");
		highlight = table.getColor("Button.light");
		lightHighlight = table.getColor("Button.highlight");
	}
	
	public function paintBorder(c : Component, g : Graphics, b : Rectangle) : Void {
		var pen:Pen = new Pen(darkShadow, 1);
		g.drawLine(pen, b.x+b.width-0.5, b.y+4, b.x+b.width-0.5, Math.max(b.y+b.height-2, b.y+4));
		g.fillRectangle(new SolidBrush(darkShadow), b.x, b.y+b.height-1, b.width, 1);
	}

	public function uninstallBorder(c : Component) : Void {
	}

	public function getBorderInsets(c : Component, bounds : Rectangle) : Insets {
		return new Insets(0, 0, 1, 1);
	}

}