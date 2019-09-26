/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Point;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.graphics.SolidBrush;
import GUI.fox.aswing.Insets;

/**
 * @author iiley
 */
class GUI.fox.aswing.tree.list.ListTreeCellBorder implements Border {
	
	private var arrowSize:Number;
	private var gap:Number;
	private var lastPaintedCom:Component;
	private var leaf:Boolean;
	private var expanded:Boolean;
	private var indent:Number;
	
	public function ListTreeCellBorder(indent:Number){
		this.indent = (indent == undefined ? 0 : indent);
		arrowSize = 8;
		gap = 2;
		leaf = false;
		expanded = false;
	}
	
	public function setLeaf(l:Boolean):Void{
		leaf = l;
	}

	public function setExpanded(b : Boolean) : Void {
		expanded = b;
	}
	
	public function setIndent(i:Number):Void{
		indent = i;
	}
	
	public function getIndent():Number{
		return indent;
	}
	
	public function getArrowSizeAmount():Number{
		return arrowSize + gap*2;
	}
	
	public function paintBorder(c : Component, g : Graphics, bounds : Rectangle) : Void {
		var b:Rectangle = bounds;
		
		//paint tree arrow here
		if(!leaf){
			var w:Number = arrowSize;
			var cx:Number = b.x + indent + gap + w/2;
			var cy:Number = b.y + b.height/2;
			var arrow:Number = expanded ? Math.PI/2 : 0;
			var center:Point = new Point(cx, cy);
			var ps1:Array = new Array();
			ps1.push(center.nextPoint(arrow, w/2/2));
			var back:Point = center.nextPoint(arrow + Math.PI, w/2/2);
			ps1.push(back.nextPoint(arrow - Math.PI/2, w/2));
			ps1.push(back.nextPoint(arrow + Math.PI/2, w/2));
		
			g.fillPolygon(new SolidBrush(ASColor.BLACK), ps1);
		}
	}

	public function uninstallBorder(c : Component) : Void {
	}

	public function getBorderInsets(c : Component, bounds : Rectangle) : Insets {
		return new Insets(0, indent + arrowSize + gap*2, 0, 0);
	}

}