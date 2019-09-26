/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.Container;
import GUI.fox.aswing.EmptyLayout;
import GUI.fox.aswing.geom.Dimension;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.Insets;

/**
 * Simple <code>LayoutManager</code> aligned the single contained
 * component by the container's center.
 * 
 * @author iiley
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.CenterLayout extends EmptyLayout {
	
	public function CenterLayout(){
		super();
	}
	
	/**
	 * Calculates preferred layout size for the given container.
	 */
    public function preferredLayoutSize(target:Container):Dimension {
    	return ( (target.getComponentCount() > 0) ?
    		target.getInsets().getOutsideSize(target.getComponent(0).getPreferredSize()) :
    		target.getInsets().getOutsideSize() );
    }

    /**
     * Layouts component by center inside the given container. 
     *
     * @param target the container to lay out
     */
    public function layoutContainer(target:Container):Void{
        if (target.getComponentCount() > 0) {
	        var size:Dimension = target.getSize();
	        var insets:Insets = target.getInsets();
	        var rd:Rectangle = insets.getInsideBounds(size.getBounds());
	        
	        var c:Component = target.getComponent(0);
	        var preferSize:Dimension = c.getPreferredSize();
	        
	        var cd:Rectangle = new Rectangle();
	        cd.setLocation(rd.getLocation());
	        cd.setSize(rd.getSize().intersect(preferSize));
	        
	        if (rd.width > preferSize.width) {
	        	cd.x += (rd.width - preferSize.width) / 2;
	        }
	        if (rd.height > preferSize.height) {
	        	cd.y += (rd.height - preferSize.height) / 2;
	        }
	        
	     	c.setBounds(cd);   
        }
    }
}
