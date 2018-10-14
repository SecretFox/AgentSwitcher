/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.Insets;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.office2003.border.PanelBorder extends org.aswing.plaf.basic.border.ButtonBorder
{
	
	private function PanelBorder(){
		super();
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, b:Rectangle):Void{

		var ltBorder = UIManager.getColor("Panel.background");
		var dkBorder = UIManager.getColor("controlBorder");
		var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;
		var radius:Number = 5;

        var penTool:Pen=new Pen(ltBorder,1);
        g.drawLine(penTool, x+radius, y, x+w-radius, y);
        		
        penTool = new Pen(dkBorder,1);
        g.drawLine(penTool, x+radius, y+h, x+w-radius, y+h);
        
        
    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets
	{
    	return new Insets(2, 2, 2, 2);
    }	
}