/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicPanelUI;
 

class com.f1sr.aswing.plaf.winxp.PanelUI extends BasicPanelUI{

    
    public function PanelUI(){
    	super();
    }	
    

	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void
 	{
 		//trace(com.getBackground()+":"+UIManager.getColor("Window.modalColor"));
 		
	    var brush:SolidBrush=new SolidBrush(com.getBackground(),100);
	    g.fillRectangle(brush,b.x,b.y,b.width,b.height);

	    
    }
}
