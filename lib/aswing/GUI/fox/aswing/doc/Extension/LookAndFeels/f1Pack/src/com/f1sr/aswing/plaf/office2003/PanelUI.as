/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.plaf.basic.BasicPanelUI;
import org.aswing.UIManager;
 

class com.f1sr.aswing.plaf.office2003.PanelUI extends BasicPanelUI{
	/*shared instance*/
	
	/*
	private static var panelUI:PanelUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(panelUI == null){
    		panelUI = new PanelUI();
    	}
        return panelUI;
    }
    */
    
    public function PanelUI(){
    	super();
    }	
    

	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void
 	{
 		//trace(com.getBackground()+":"+UIManager.getColor("Window.modalColor"));
 		
 		var light:Number = UIManager.getColor("Panel.light").getRGB();
 		var control:Number = UIManager.getColor("Panel.background").getRGB();
 		
 		
    	var x1:Number = b.x;
		var y1:Number = b.y;
		var x2:Number = b.width;
		var y2:Number = b.height;
			
	   	var colors:Array = [light,control];
		var alphas:Array = [100, 0];
		var ratios:Array = [0, 255];
		
		var matrix:Object = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(50/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRect(brush,x1,y1,x2,y2,0);

	    
    }
}
