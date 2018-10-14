/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.JButton;
import org.aswing.plaf.basic.frame.TitleBarUI;
import org.aswing.UIManager;

import com.f1sr.aswing.plaf.office2003.border.TitleBarButtonBorder;
import com.f1sr.aswing.plaf.office2003.button.TitleBarButtonUI;
import com.f1sr.aswing.plaf.office2003.button.TitleBarRedButtonUI;
 
class com.f1sr.aswing.plaf.office2003.frame.Office2003TitleBarUI extends TitleBarUI
{

	//can't share instance
    public function Office2003TitleBarUI(){
    	super();
    }

	private function installComponents() : Void {
		iconifiedButton = new JButton(null, iconifiedIcon);
		resizeButton    = new JButton(null, maximizeIcon);
		closeButton     = new JButton(null, closeIcon);
		
		iconifiedButton.setUI(new TitleBarButtonUI());
		resizeButton.setUI(new TitleBarButtonUI());
		closeButton.setUI(new TitleBarRedButtonUI());
		
		iconifiedButton.setBorder(new TitleBarButtonBorder());
		resizeButton.setBorder(new TitleBarButtonBorder());
		closeButton.setBorder(new TitleBarButtonBorder());
		
		titleBar.append(iconifiedButton);
		titleBar.append(resizeButton);
		titleBar.append(closeButton);
		
		iconifiedButton.addActionListener(__iconifiedPressed, this);
		resizeButton.addActionListener(__resizePressed, this);
		closeButton.addActionListener(__closePressed, this);
	}
		
	
	private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void{
		if(!com.isOpaque())
		{
			 return;
		}
		var caption:ASColor = UIManager.getColor("activeCaption");
		var darkShadow:ASColor = UIManager.getColor("controlDkShadow");
		var inactive:ASColor = UIManager.getColor("inactiveCaption"); 
		
        var x:Number = b.x;
		var y:Number = b.y;
		var w:Number = b.width;
		var h:Number = b.height;

		var sbrush:SolidBrush = new SolidBrush(caption);
		//g.fillRoundRect(sbrush,x,y,w,h,4,4,0,0); 

	    var colors:Array = [caption.brighter(0.7).getRGB(),caption.getRGB()];
		var alphas:Array = [100, 100];
		var ratios:Array = [0, 25];
		var matrix:Object = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
	    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);    

		
        colors = [caption.darker(0.9).getRGB(), ASColor.WHITE.getRGB()];//0x00A4E0];
		alphas = [65,40];
		ratios = [85, 255];
	    matrix = {matrixType:"box", x:x, y:y, w:b.width, h:b.height, r:(90/180)*Math.PI};
	           
        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRoundRect(brush, x, y+4, w, h-h/6-2,2,2,0,0);

	      
        var penTool:Pen=new Pen(caption.darker(0.8),1.5);
        g.drawLine(penTool, x, y+h-1, x+w, y+h-1);
        
        if (frame.isActive())
        {
        }
        else
        {
		    colors = [inactive.getRGB(),inactive.getRGB()];//0xCBCED0];
			alphas = [100, 100];
			ratios = [0, 255];
			matrix = {matrixType:"box", x:x, y:y, w:w, h:h, r:(90/180)*Math.PI};        
		    brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);    
	
	
	        colors = [inactive.darker(0.9).getRGB(), ASColor.WHITE.getRGB()];//0x00A4E0];
			alphas = [75,35];
			ratios = [60, 255];
		    matrix = {matrixType:"box", x:x, y:y, w:b.width, h:b.height, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush, x, y+1, w, h-2,2);
	       
        }
	}
}
