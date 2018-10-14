/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
 
import org.aswing.ASColor;
import org.aswing.border.LineBorder;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.JButton;
import org.aswing.JScrollPane;
import org.aswing.plaf.basic.BasicComboBoxUI;

import com.f1sr.aswing.plaf.office2003.button.ScrollBarButtonUI;
import com.f1sr.aswing.plaf.office2003.icon.ScrollBarDownIcon;


 
class com.f1sr.aswing.plaf.office2003.ComboBoxUI extends BasicComboBoxUI
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

    /**
     * Just override this method if you want other LAF drop down buttons.
     */
    private function createDropDownButton():Component{
    	var btn:JButton = new JButton(new ScrollBarDownIcon(
    				Math.PI/2, 16,
				    new ASColor(0x000000,100),
				   new ASColor(0x4D6185,100),
				   new ASColor(0x4D6185,100),
				    new ASColor(0xFF0000,100)
    	));
    	//var b:AbstractButton = AbstractButton(btn);
    	btn.setUI(new ScrollBarButtonUI());
    	
    	
    	btn.setPreferredSize(16, 16);
    	
    	//trace("--BTN--"+btn.getUIClassID());
    	return btn;
    }
       
   
    private function paintBackGround(c:Component, g:Graphics, r:Rectangle):Void
    {
    	  	
    	if(c.isOpaque() && c.isEnabled())
    	{
			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
    		
    		var bg:ASColor = c.getBackground();
    		g.fillRectangle(new SolidBrush(bg), x,y,w,h);
    		    		
    	}
    	
    }    
    
    private function getScollPane():JScrollPane{
    	if(scollPane == null){
    		scollPane = new JScrollPane(getPopupList());
    		scollPane.setBorder(new LineBorder(null,new ASColor(0x3A62A0,100)));
    		scollPane.setOpaque(true);
    	}
    	return scollPane;
    } 
    

}