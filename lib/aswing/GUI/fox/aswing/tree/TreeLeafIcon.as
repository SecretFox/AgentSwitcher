﻿/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.GradientBrush;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.plaf.UIResource;

/**
 * The default leaf icon for JTree.
 * TODO draw a nicer icon
 * @author iiley
 */
class GUI.fox.aswing.tree.TreeLeafIcon implements Icon, UIResource{
	
	public function TreeLeafIcon(){
	}
	
	public function getIconWidth() : Number {
		return 16;
	}

	public function getIconHeight() : Number {
		return 16;
	}

	public function paintIcon(com : Component, g : Graphics, x : Number, y : Number) : Void {
		var b:Rectangle = new Rectangle(0, 0, 16, 16);
		b.grow(-4, -4);
		b.move(x, y);
		
        var colors:Array = [0xFFFFFF, 0x257434];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
	    var matrix:Object = {matrixType:"box", x:b.x-2, y:b.y-2, w:b.width+2, h:b.height+2, r:0};        
        var brush:GradientBrush = new GradientBrush(GradientBrush.RADIAL, colors, alphas, ratios, matrix);
        g.fillEllipse(brush, b.x, b.y, b.width, b.height);
	}

	public function uninstallIcon(com : Component) : Void {
	}

	
}