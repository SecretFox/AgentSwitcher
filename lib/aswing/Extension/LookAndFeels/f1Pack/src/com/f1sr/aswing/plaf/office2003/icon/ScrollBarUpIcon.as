/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Point;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Icon;
import org.aswing.plaf.UIResource;
 

class com.f1sr.aswing.plaf.office2003.icon.ScrollBarUpIcon implements Icon, UIResource{
	private var arrow:Number;
	private var width:Number;
	private var height:Number;
	private var background:ASColor;
	private var shadow:ASColor;
	private var darkShadow:ASColor;
	private var highlight:ASColor;
	
	public function ScrollBarUpIcon(arrow:Number, size:Number, background:ASColor, shadow:ASColor,
			 darkShadow:ASColor, highlight:ASColor){
		this.arrow = arrow;
		this.width = size;
		this.height = size-size/3;
		this.background = background;
		this.shadow = shadow;
		this.darkShadow = darkShadow;
		this.highlight = highlight;
	}

	/**
	 * Return the icon's width.
	 */
	public function getIconWidth():Number{
		return width;
	}
	
	/**
	 * Return the icon's height.
	 */
	public function getIconHeight():Number{
		return height;
	}
	
	/**
	 * Draw the icon at the specified location.
	 */
	public function paintIcon(com:Component, g:Graphics, x:Number, y:Number):Void{
		
		var w:Number = com.getWidth();
		var h:Number = com.getHeight();
		var xOffset:Number = w/4;
		var yOffset:Number = h/2-2;
		
		var p:Point = new Point(xOffset+4,yOffset+0);
		var ps1:Array = new Array();
		ps1.push(new Point(xOffset+8,yOffset+4));
		ps1.push(new Point(xOffset+7,yOffset+5));
		ps1.push(new Point(xOffset+4,yOffset+2));
		ps1.push(new Point(xOffset+1,yOffset+5));
		ps1.push(new Point(xOffset+0,yOffset+4));
		ps1.push(new Point(xOffset+4,yOffset+0));
		
		g.fillPolygon(new SolidBrush(darkShadow), ps1);
	}
	
	public function uninstallIcon(com:Component):Void{
	}	
}
