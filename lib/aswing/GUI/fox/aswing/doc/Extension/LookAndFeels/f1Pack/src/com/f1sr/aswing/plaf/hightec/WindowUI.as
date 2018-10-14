/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 

import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics;
import org.aswing.graphics.SolidBrush;
import org.aswing.JWindow;
import org.aswing.plaf.basic.BasicWindowUI;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.WindowUI;
import org.aswing.UIManager;


class com.f1sr.aswing.plaf.hightec.WindowUI extends BasicWindowUI
{
    /*shared instance*/
    
    // Shared UI object
    
   private static var windowUI:WindowUI;
    
    //private var contentPaneBorder:Border;
    public static function createInstance(c:Component):ComponentUI {
        if(windowUI == null) {
            windowUI = new WindowUI();
        }
        return windowUI;
    }
    
    public function WindowUI()
    {
        super();
    }
    
    
    public function create(c:Component):Void
    {
        var window:JWindow = JWindow(c);
        var modalMC:MovieClip = window.getModalMC();
        var g:Graphics = new Graphics(modalMC);
        g.fillRectangle(new SolidBrush(0xff00ff,100), 0, 0, 1, 1);
        
        //trace("2.create:"+window);
        window.resetModalMC();
    }
    

    private function paintBackGround(com:Component, g:Graphics, b:Rectangle):Void
    {
        //trace(com.getBackground()+":"+UIManager.getColor("Window.modalColor"));
        
        var clr1:Number = UIManager.getColor("controlLtHighlight").getRGB();
        var clr2:Number = UIManager.getColor("controlHighlight").getRGB();
        
        var x1:Number = b.x;
        var y1:Number = b.y;
        var x2:Number = x1 + b.width;
        var y2:Number = y1 + b.height;
            
        var colors:Array = [clr1, clr2];
        var alphas:Array = [100, 100];
        var ratios:Array = [0, 255];
        
        var matrix:Object = {matrixType:"box", x:x1, y:y1, w:b.width, h:b.height, r:(80/180)*Math.PI};        
        var brush:GradientBrush=new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRoundRect(brush,x1,y1,x2,y2,5);
        
    }
    
}
