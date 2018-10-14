/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 

import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicWindowUI;



class com.f1sr.aswing.plaf.office2003.WindowUI extends BasicWindowUI
{
	/*shared instance*/
	
    // Shared UI object
    /*
   private static var windowUI:WindowUI;
	
	//private var contentPaneBorder:Border;
    public static function createInstance(c:Component):ComponentUI {
		//if(windowUI == null) {
            windowUI = new WindowUI();
		//}
        return windowUI;
    }
    */
	public function WindowUI()
	{
		super();
	}
	
	

 	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void
 	{
 		//trace(com.getBackground()+":"+UIManager.getColor("Window.modalColor"));

    	var x1:Number = b.x;
		var y1:Number = b.y;
		var x2:Number = x1 + b.width;
		var y2:Number = y1 + b.height;
			
	    var brush:SolidBrush = new SolidBrush(com.getBackground());
	    g.fillRoundRect(brush,x1,y1,x2,y2,5);
	    
    }
	
}
