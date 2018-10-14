/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 

import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.border.Border;
import org.aswing.ButtonModel;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.Insets;
import org.aswing.JComboBox;
import org.aswing.plaf.UIResource;
import org.aswing.UIDefaults;
import org.aswing.UIManager;

 
class com.f1sr.aswing.plaf.office2003.border.ComboBoxBorder implements Border, UIResource
{
	
    private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
	
	private static var instance:Border;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new ComboBoxBorder();
		}
		return instance;
	}
	
	private function ComboBoxBorder()
	{
		
		super();
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		this.shadow = table.getColor("Button.shadow");
		this.darkShadow = table.getColor("Button.darkShadow");
		this.highlight = table.getColor("Button.light");
		this.lightHighlight = table.getColor("Button.highlight");
	}
	
	/**
	 * paint the ButtonBorder content.
	 */
    public function paintBorder(c:Component, g:Graphics, bounds:Rectangle):Void{
    	var isPressed:Boolean = false;
		if(c instanceof AbstractButton){
			var model:ButtonModel = (AbstractButton(c)).getModel();
			isPressed = model.isPressed() || model.isSelected();
		}

	    var x:Number = bounds.x;
		var y:Number = bounds.y;
		var w:Number = bounds.width;
		var h:Number = bounds.height;
		
		var brush:SolidBrush;	
		
		
		var comboCom:JComboBox = JComboBox(c);
		
		if(comboCom.isEnabled())
		{
			brush = new SolidBrush(UIManager.getColor("controlBorder").brighter(0.8));	
		    g.fillRoundRectRingWithThickness(brush, x, y, w, h, 0, 1,0);
		    //2-nd border inset
			brush = new SolidBrush(UIManager.getColor("controlLtHighlight"));
			g.fillRoundRectRingWithThickness(brush, x+1, y+1, w-2, h-2, 0, 1,0);			    
		}
		else
		{
			brush = new SolidBrush(UIManager.getColor("control"));
			g.fillRoundRectRingWithThickness(brush, x, y, w, h, 0, 1,0);
			//2-nd border inset
			//brush = new SolidBrush(UIManager.getColor("controlLtHighlight"));
			//g.fillRoundRectRingWithThickness(brush, x+1, y+1, w-2, h-2, 0, 1,0);			
		}

    }
	
	public function getBorderInsets(c:Component, bounds:Rectangle):Insets{
    	return new Insets(2, 2, 2, 2);
    }
    
    public function uninstallBorder(c:Component):Void{
    } 


}