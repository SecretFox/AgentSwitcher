/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.Insets;

/**
 * @author Igor Sadovskiy
 */
class org.aswing.thumbstrip.ThumbStripContentLayout extends EmptyLayout {

    /**
     * Specifies that components should be laid out left to right.
     */
    public static var X_AXIS:Number = 0;
    
    /**
     * Specifies that components should be laid out top to bottom.
     */
    public static var Y_AXIS:Number = 1;
    
        
    private var axis:Number;
    private var gap:Number;

    
    /**
     * <br>
     * BoxLayout(axis:Number)<br>
     * BoxLayout(axis:Number)<br>
     * @param axis the layout axis, default X_AXIS
     * @param gap (optional)the gap between each component, default 0
     * @see #X_AXIS
     * @see #Y_AXIS
     */
    public function ThumbStripContentLayout(axis:Number, gap:Number){
    	setAxis(axis);
    	setGap(gap);
    }
    	
    /**
     * Sets new axis. Must be one of:
     * <ul>
     *  <li>X_AXIS
     *  <li>Y_AXIS
     * </ul> Default is X_AXIS.
     * @param axis new axis
     */
    public function setAxis(axis:Number):Void {
    	this.axis = (axis == undefined ? X_AXIS : axis);
    }
    
    /**
     * Gets axis.
     * @return axis
     */
    public function getAxis():Number {
    	return axis;	
    }
    
    /**
     * Sets new gap.
     * @param get new gap
     */	
    public function setGap(gap:Number):Void {
    	this.gap = (gap == undefined ? 0 : gap);
    }
    
    /**
     * Gets gap.
     * @return gap
     */
    public function getGap():Number {
    	return gap;	
    }
    
	/**
	 * Returns minimumLayoutSize;
	 */
    public function minimumLayoutSize(target:Container):Dimension{
    	return target.getParent().getInsets().getOutsideSize(target.getParent().getPreferredSize());
    }
    

	/**
	 * Returns preferredLayoutSize;
	 */
    public function preferredLayoutSize(target:Container):Dimension{
    	
    	var count:Number = target.getComponentCount();
    	var size:Rectangle = target.getParent().getBounds();
    	var insets:Insets = target.getInsets();
    	var rd:Rectangle = insets.getInsideBounds(size);
    	var width:Number = 0;
    	var height:Number = 0;
    	var wTotal:Number = 0;
    	var hTotal:Number = 0;

    	for(var i:Number=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if (c.isVisible()) {
	    		var ps:Dimension = c.getPreferredSize();
	    		
				if (axis == X_AXIS) {
					width = (ps.width != 0) ? ps.width : rd.height;  
					height = rd.height;
				} else {
					width = rd.width;
					height = (ps.height != 0) ? ps.height : rd.width;
				}
	    		var g:Number = (i > 0) ? gap : 0;
	    		wTotal += (width + g);
	    		hTotal += (height + g);
    		}
    	}
    	if(axis == Y_AXIS){
    		height = hTotal;
    	}else{
    		width = wTotal;
    	}
    	
    	var dim:Dimension = new Dimension(width, height);
    	return insets.getOutsideSize(dim);
    }

    public function layoutContainer(target:Container):Void{
    	var count:Number = target.getComponentCount();
    	var size:Rectangle = target.getBounds();
    	var insets:Insets = target.getInsets();
    	var rd:Rectangle = insets.getInsideBounds(size);
    	var cw:Number = rd.width;
    	var ch:Number = rd.height;
    	var x:Number = insets.left; //rd.x;
    	var y:Number = insets.top; //rd.y;
		
    	for(var i:Number=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var ps:Dimension = c.getPreferredSize();
	    		
				if (axis == X_AXIS) {
					cw = (ps.width != 0) ? ps.width : rd.height;  
	    			c.setBounds(x, y, cw, ch);
	    			x += (cw + gap);
				} else {
					ch = (ps.height != 0) ? ps.height : rd.width;
	    			c.setBounds(x, y, cw, ch);
	    			y += (ch + gap);
				}
    		}
    	}
    }

}