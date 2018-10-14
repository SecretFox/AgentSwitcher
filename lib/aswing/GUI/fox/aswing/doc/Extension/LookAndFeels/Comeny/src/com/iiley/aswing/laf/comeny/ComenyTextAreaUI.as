/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.Component;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicTextComponentUI;
import org.aswing.plaf.ComponentUI;

import com.iiley.aswing.laf.comeny.ComenyTextFieldUI;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.ComenyTextAreaUI extends BasicTextComponentUI {
	
	private static var textUI:ComenyTextAreaUI;
		
	public static function createInstance(c:Component):ComponentUI {
		if(textUI == null){
			textUI = new ComenyTextAreaUI();
		}
		return textUI;
	}
	
	public function ComenyTextAreaUI(){
		super();	
	}
	
	//override this to the sub component's prefix
    private function getPropertyPrefix():String {
        return "TextArea.";
    }

	public function paint(c:Component , g:Graphics , r:Rectangle):Void{
		super.paint(c, g, r);
	}
    
    private function paintBackGround(c:Component, g:Graphics, r:Rectangle):Void{
    	if(c.isOpaque()){
			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
			g.fillRectangle(new SolidBrush(c.getBackground()), x,y,w,h);
    	}
    	
    }
    
    /**
     * Return null, make it to count in JTextFiled's countPreferredSize method.
     */
    public function getPreferredSize(c:Component):Dimension{
    	return null;
    }
	
}