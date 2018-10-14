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
import org.aswing.Icon;
import org.aswing.JTabbedPane;
import org.aswing.plaf.basic.BasicTabbedPaneUI;
import org.aswing.plaf.basic.icon.ArrowIcon;
import org.aswing.plaf.ComponentUI;
import org.aswing.UIManager;



class com.f1sr.aswing.plaf.office2003.TabbedPaneUI extends BasicTabbedPaneUI {
	

	private static var sTabbedPaneUI:TabbedPaneUI;
	
    public static function createInstance(c:Component):ComponentUI {
    	if(sTabbedPaneUI == null){
    		sTabbedPaneUI = new TabbedPaneUI();
    	}
        return sTabbedPaneUI;
    }
	
	public function TabbedPaneUI() {
		super();
	}

    
	
     private function createArrowIcon(direction:Number, enable:Boolean):Icon{
    	var icon:Icon;
    	var activeColor = UIManager.getColor("controlBorder").getRGB();
    	var inactiveColor = UIManager.getColor("control").getRGB();
    	if(enable){
    		icon = new ArrowIcon(direction, 10,
				    new ASColor(0x000000,100),
				   new ASColor(activeColor,100),
				   new ASColor(inactiveColor,100),
				    new ASColor(0xFF0000,100));
    	}else{
    		icon = new ArrowIcon(direction, 10,
				    new ASColor(0x000000,100),
				   new ASColor(inactiveColor,100),
				   new ASColor(activeColor,100),
				    new ASColor(0xFF0000,100));
    	}
		return icon;
    }
        

    
    
    /**
     * override this method to draw different tab base line for your LAF
     */
    private function drawBaseLine(tabBarBounds:Rectangle, g:Graphics, fullB:Rectangle):Void{
    	var b:Rectangle = new Rectangle(tabBarBounds);
    	var placement:Number = tabbedPane.getTabPlacement();
    	if(isTabHorizontalPlacing()){
    		if(placement != JTabbedPane.BOTTOM){
    			b.y = b.y + b.height - baseLineThickness;
    		}
    		b.height = baseLineThickness;
    		b.width = fullB.width;
    		b.x = fullB.x;
    		g.fillRectangle(new SolidBrush(tabbedPane.getBackground()), b.x, b.y, b.width, b.height);
    		//g.fillRectangle(new SolidBrush(new ASColor(0xff0000)), b.x, b.y, b.width, b.height);
    		var pen:Pen = new Pen(lightHighlight, 1);
    		g.drawLine(pen, b.x, b.y + 0.5, b.x+b.width, b.y+0.5);
    		pen.setASColor(shadow);
    		g.drawLine(pen, b.x, b.y + b.height - 0.5, b.x+b.width, b.y + b.height - 0.5);
    	}else{
    		if(placement != JTabbedPane.RIGHT){
    			b.x = b.x + b.width - baseLineThickness;
    		}
    		b.width = baseLineThickness;
    		b.height = fullB.height;
    		b.y = fullB.y;
    		g.fillRectangle(new SolidBrush(tabbedPane.getBackground()), b.x, b.y, b.width, b.height);
    		var pen:Pen = new Pen(lightHighlight, 1);
    		g.drawLine(pen, b.x+0.5, b.y, b.x+0.5, b.y+b.height);
    		pen.setASColor(shadow);
    		g.drawLine(pen, b.x+b.width-0.5, b.y, b.x+b.width-0.5, b.y+b.height);
    	}
    }
    
    
    /**
     * override this method to draw different tab border for your LAF.<br>
     * Note, you must call setDrawnTabBounds() to set the right bounds for each tab in this method
     */
    private function drawTabBorderAt(index:Number, b:Rectangle, paneBounds:Rectangle, g:Graphics):Void{
    	var placement:Number = tabbedPane.getTabPlacement();
    	if(index == tabbedPane.getSelectedIndex()){
    		b = new Rectangle(b);//make a clone to be safty modification
    		if(isTabHorizontalPlacing()){
    			b.x -= tabBorderInsets.left;
    			b.width += (tabBorderInsets.left + tabBorderInsets.right);
	    		b.height += Math.round(topBlankSpace/2+2);
    			if(placement == JTabbedPane.BOTTOM){
	    			b.y -= 2;
    			}else{
	    			b.y -= Math.round(topBlankSpace/2);
    			}
    		}else{
    			b.y -= tabBorderInsets.left;
    			b.height += (tabBorderInsets.left + tabBorderInsets.right);
	    		b.width += Math.round(topBlankSpace/2+2);
    			if(placement == JTabbedPane.RIGHT){
	    			b.x -= 2;
    			}else{
	    			b.x -= Math.round(topBlankSpace/2);
    			}
    		}
    	}
    	//This is important, should call this in sub-implemented drawTabBorderAt method
    	setDrawnTabBounds(index, b, paneBounds);
    	var x1:Number = b.x;
    	var y1:Number = b.y;
    	var x2:Number = b.x + b.width;
    	var y2:Number = b.y + b.height;

		/*
		    shadow:ASColor;
		    arkShadow:ASColor;
		    highlight:ASColor;
		    lightHighlight:ASColor;   	
    	*/
    	
    	if(placement == JTabbedPane.LEFT)
    	{
    		g.fillRectangle(new SolidBrush(tabbedPane.getBackground()), b.x, b.y, b.width, b.height-2);
    		//left 1
    		var pen:Pen = new Pen(lightHighlight, 1);
    		g.drawLine(pen, x1+0.5, y1, x1+0.5, y2-2);
    		//top 1
    		g.drawLine(pen, x1, y1+0.5, x2, y1+0.5);
    		//bottom 2
    		pen.setASColor(shadow);
    		g.drawLine(pen, x1+1, y2-1.5, x2, y2-1.5);
    		pen.setASColor(darkShadow);
    		g.drawLine(pen, x1+2, y2-0.5, x2, y2-0.5);
    	}
    	else if(placement == JTabbedPane.RIGHT)
    	{
    		g.fillRectangle(new SolidBrush(tabbedPane.getBackground()), b.x, b.y, b.width-1, b.height-2);
    		//top 1
    		var pen:Pen = new Pen(lightHighlight, 1);
    		g.drawLine(pen, x1, y1+0.5, x2-1, y1 + 0.5);
    		//bottom 2
    		pen.setASColor(shadow);
    		g.drawLine(pen, x1, y2-1.5, x2-1, y2-1.5);
    		pen.setASColor(darkShadow);
    		g.drawLine(pen, x1, y2-0.5, x2-1, y2-0.5);
    		//right 2
    		pen.setASColor(shadow);
    		g.drawLine(pen, x2-1.5, y1+1, x2-1.5, y2-1.5);
    		pen.setASColor(darkShadow);
    		g.drawLine(pen, x2-0.5, y1+2, x2-0.5, y2-0.5);
    	}
    	else if(placement == JTabbedPane.BOTTOM)
    	{

			var active:Number = UIManager.getColor("activeCaption").getRGB();//"00BBFF
				
		   	var colors:Array = [highlight.getRGB(),shadow.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [0, 255];
			
			var matrix:Object = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,b.x, b.y, b.width-1, b.height,0,0,5,5);
		    
		    // middle border
	        colors = [highlight.getRGB(),highlight.getRGB()];//0x00A4E0];
			alphas = [100,100];
			ratios = [0, 255];
		    matrix = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush,b.x+1, b.y+1, b.width-3, b.height-2,0,0,4,4); 		

			// bg
	        colors = [tabbedPane.getBackground().getRGB(),lightHighlight.getRGB()];//0x00A4E0];
			alphas = [100,100];
			ratios = [0, 225];
		    matrix = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush,b.x+2, b.y, b.width-5, b.height-2,0,0,4,4);  
	            		
    		/*
    		g.fillRectangle(new SolidBrush(tabbedPane.getBackground()), b.x, b.y, b.width-1, b.height-2);
    		//left 1
    		var pen:Pen = new Pen(lightHighlight, 1);
    		g.drawLine(pen, x1+0.5, y1+1, x1+0.5, y2-2);
    		//bottom 2
    		pen.setASColor(shadow);
    		g.drawLine(pen, x1+1, y2-1.5, x2-1, y2-1.5);
    		pen.setASColor(darkShadow);
    		g.drawLine(pen, x1+2, y2-0.5, x2-1, y2-0.5);
    		//right 2
    		pen.setASColor(shadow);
    		g.drawLine(pen, x2-1.5, y1, x2-1.5, y2-1);
    		pen.setASColor(darkShadow);
    		g.drawLine(pen, x2-0.5, y1, x2-0.5, y2-1);
    		*/
    	}
    	else
    	{
    		
			
			var active:Number = UIManager.getColor("activeCaption").getRGB();//"00BBFF
			
			// top border	
		   	var colors:Array = [shadow.getRGB(),highlight.getRGB()];
			var alphas:Array = [100, 100];
			var ratios:Array = [0, 255];
			
			var matrix:Object = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};        
		    var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		    g.fillRoundRect(brush,b.x, b.y, b.width-1, b.height,5,5,0,0);
		    
		    // middle border
	        colors = [highlight.getRGB(), highlight.getRGB()];//0x00A4E0];
			alphas = [100,100];
			ratios = [0, 255];
		    matrix = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush,b.x+1, b.y+1, b.width-3, b.height-2,4,4,0,0);

			// bg
	        colors = [lightHighlight.getRGB(), tabbedPane.getBackground().getRGB()];//0x00A4E0];
			alphas = [100,100];
			ratios = [75, 255];
		    matrix = {matrixType:"box", x:b.x, y:b.y, w:b.width, h:b.height, r:(90/180)*Math.PI};
		           
	        brush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	        g.fillRoundRect(brush,b.x+2, b.y+2, b.width-5, b.height,4,4,0,0);

	            		
    		/*
    		
    		g.fillRectangle(new SolidBrush(tabbedPane.getBackground()), b.x, b.y, b.width-1, b.height);
    		//left 1
    		var pen:Pen = new Pen(lightHighlight, 1);
    		g.drawLine(pen, x1+0.5, y1+1, x1+0.5, y2);
    		//top 1
    		g.drawLine(pen, x1+1, y1+0.5, x2-2, y1 + 0.5);
    		//right 2
    		pen.setASColor(shadow);
    		g.drawLine(pen, x2-1.5, y1, x2-1.5, y2);
    		pen.setASColor(darkShadow);
    		g.drawLine(pen, x2-0.5, y1+1, x2-0.5, y2);  
    		 */		
    	}
    }
 
 
    

        
        

}