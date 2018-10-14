/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.JWindow;
import org.aswing.plaf.basic.BasicWindowUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.spring.SaladWindowUI extends BasicWindowUI
{
	/*shared instance*/
	private static var saladWindowUI:SaladWindowUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(saladWindowUI == null){
    		saladWindowUI = new SaladWindowUI();
    	}
        return saladWindowUI;
    }
    
    public function SaladWindowUI(){
    	super();
    }

	
    public function create(c:Component):Void
    {
    	var window:JWindow = JWindow(c);
    	var modalMC:MovieClip = window.getModalMC();
		var g:Graphics = new Graphics(modalMC);
		g.fillRectangle(new SolidBrush(UIManager.getColor("Window.modalColor").getRGB(), 0), 0, 0, 1, 1);
		
		window.resetModalMC();
		
		
    }    

	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void
 	{
 		//trace(com.getBackground()+":"+UIManager.getColor("Window.modalColor"));
 		
    	var x1:Number = b.x;
		var y1:Number = b.y;
		var x2:Number = b.width;
		var y2:Number = b.height;
	    var brush:SolidBrush=new SolidBrush(UIManager.getColor("window"));
	    g.fillRectangle(brush,x1,y1,x2,y2);
	    
    }    
 	
	
}
