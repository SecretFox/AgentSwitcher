/*
 CopyRight @ 2005 XLands.com INC. All rights reserved.
*/
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.Insets;

/**
 * @author iiley
 */
class org.aswing.richtext.HorizontalLayout extends EmptyLayout {
	
    /**
     * This value indicates that each row of components
     * should be top-justified.
     */
    public static var TOP:Number 	= 0;

    /**
     * This value indicates that each row of components
     * should be centered.
     */
    public static var CENTER:Number 	= 1;

    /**
     * This value indicates that each row of components
     * should be bottom-justified.
     */
    public static var BOTTOM:Number 	= 2;	
	
	private var align:Number;
	private var gap:Number;
	
	public function HorizontalLayout(align:Number, gap:Number){
		this.align = (align == undefined ? TOP : align);
		this.gap   = (gap == undefined ? 0 : gap);
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
     * Sets new align. Must be one of:
     * <ul>
     *  <li>LEFT
     *  <li>RIGHT
     *  <li>CENTER
     *  <li>TOP
     *  <li>BOTTOM
     * </ul> Default is LEFT.
     * @param align new align
     */
    public function setAlign(align:Number):Void{
    	this.align = (align == undefined ? TOP : align);
    }
    
    /**
     * Returns the align.
     * @return the align
     */
    public function getAlign():Number{
    	return align;
    }
   	
	/**
	 * Returns preferredLayoutSize;
	 */
    public function preferredLayoutSize(target:Container):Dimension{
    	var count:Number = target.getComponentCount();
    	var insets:Insets = target.getInsets();
    	var width:Number = 0;
    	var height:Number = 0;
    	for(var i:Number=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var size:Dimension = c.getPreferredSize();
	    		height = Math.max(height, size.height);
	    		var g:Number = i > 0 ? gap : 0;
	    		width += (size.width + g);
    		}
    	}
    	
    	var dim:Dimension = new Dimension(width, height);
    	return dim;
    }
        
	/**
	 * Returns minimumLayoutSize;
	 */
    public function minimumLayoutSize(target:Container):Dimension{
    	return target.getInsets().getOutsideSize();
    }
    
    /**
     * do nothing
     */
    public function layoutContainer(target:Container):Void{
    	var count:Number = target.getComponentCount();
    	var size:Dimension = target.getSize();
    	var insets:Insets = target.getInsets();
    	var rd:Rectangle = insets.getInsideBounds(size.getBounds());
    	var ch:Number = rd.height;
    	var cw:Number = rd.width;
    	var x:Number = rd.x;
    	var y:Number = rd.y;
		var bottom:Number = y + ch;
    	for(var i:Number=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var ps:Dimension = c.getPreferredSize();
	    		if(align == BOTTOM){
    				c.setBounds(x, bottom - ps.height, ps.width, ps.height);
	    		}else if(align == CENTER){
	    			c.setBounds(x, y + ch/2 - ps.height/2, ps.width, ps.height);
	    		}else{
	    			c.setBounds(x, y, ps.width, ps.height);
	    		}
    			x += ps.width + gap;
    		}
    	}
    }
    
	/**
	 * return 0.5
	 */
    public function getLayoutAlignmentX(target:Container):Number{
    	return 0.5;
    }

	/**
	 * return 0.5
	 */
    public function getLayoutAlignmentY(target:Container):Number{
    	return 0.5;
    }   
	
}