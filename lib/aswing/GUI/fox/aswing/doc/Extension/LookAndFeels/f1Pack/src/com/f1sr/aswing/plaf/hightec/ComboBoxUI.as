/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.ASColor;
import org.aswing.border.LineBorder;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.JScrollPane;
import org.aswing.plaf.basic.BasicComboBoxUI;
import org.aswing.UIManager;
 
 
class com.f1sr.aswing.plaf.hightec.ComboBoxUI extends BasicComboBoxUI
{
	
	/*shared instance*/
	/*
	private static var comboBoxUI:ComboBoxUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(comboBoxUI == null){
    		comboBoxUI = new ComboBoxUI();
    	}
        return comboBoxUI;
    }
    
    
    public function ComboBoxUI(){
    	super();
    	
    	//trace("ComboBoxUI()");
    }	
    */
   
    private function paintBackGround(c:Component, g:Graphics, r:Rectangle):Void
    {
    	  	
    	if(c.isOpaque() && c.isEnabled())
    	{
    		
    		var bg = UIManager.getColor("controlHighlight");
    		var hl = UIManager.getColor("controlLtHighlight");

			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
			
			g.fillRoundRect(new SolidBrush(bg), x,y,w,h,4);
			
			var colors:Array = [bg.getRGB(), hl.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [0, 200];
			var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,x,y,w,h,3);
		    
    	}
    	
    }    
    private function getScollPane():JScrollPane{
    	if(scollPane == null){
    		scollPane = new JScrollPane(getPopupList());
    		scollPane.setBorder(new LineBorder(null,new ASColor(0x82888D,100)));
    		scollPane.setOpaque(true);
    	}
    	return scollPane;
    }       

}