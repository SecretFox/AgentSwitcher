/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.GradientBrush;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.Pen;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.plaf.UIResource;

/**
 * The default folder icon for JTree.
 * TODO draw a nicer icon
 * @author iiley
 */
class GUI.fox.aswing.tree.TreeFolderIcon implements Icon, UIResource{
	
	public function TreeFolderIcon(){
	}
	
	public function getIconWidth() : Number {
		return 16;
	}

	public function getIconHeight() : Number {
		return 16;
	}

	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var b:Rectangle = new Rectangle(0, 0, 16, 16);
		b.grow(-2, -2);
		b.move(x, y);
		g.drawRectangle(new Pen(ASColor.BLACK, 0.5), b.x, b.y, b.width, b.height);
		
        var colors:Array = [0xE6E9EE, 0x8E94BD];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
	    var matrix:Object = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:0};        
        var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRectangle(brush, b.x, b.y, b.width, b.height);
	}

	public function uninstallIcon(com : Component) : Void {
	}

}