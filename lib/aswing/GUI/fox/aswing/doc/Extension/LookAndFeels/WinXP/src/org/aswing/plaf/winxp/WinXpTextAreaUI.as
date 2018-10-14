/*
 Copyright aswing.org, see the LICENCE.txt.
*/
/**
 * @author firdosh
 */
 
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicTextComponentUI;
import org.aswing.UIManager;
 
class org.aswing.plaf.winxp.WinXpTextAreaUI extends BasicTextComponentUI {
	
	private var textUI:WinXpTextAreaUI;
	
	private var background:ASColor;
	
	public function createInstance():WinXpTextAreaUI{
		if(textUI == null){
			textUI = new WinXpTextAreaUI();
		}
		return textUI;
	}
	
	public function WinXpTextAreaUI(){
		super();
		background = UIManager.getColor("TextArea.background");
		
	}
	
	
	//override this to the sub component's prefix
    private function getPropertyPrefix():String {
        return "TextArea.";
    }
    //override this to the sub component's text field property
    private function isMultiline():Boolean{
    	return true;
    }	
	
    private function paintBackGround(c:Component, g:Graphics, r:Rectangle):Void{
    	if(c.isOpaque()){
			var x:Number = r.x;
			var y:Number = r.y;
			var w:Number = r.width;
			var h:Number = r.height;
			g.fillRectangle(new SolidBrush(background), x,y,w,h);
			
			
    	}
    	
    }
    
    /**
     * Return null, make it to count in JTextFiled's countPreferredSize method.
     */
    public function getPreferredSize(c:Component):Dimension{
    	return null;
    }    
}
