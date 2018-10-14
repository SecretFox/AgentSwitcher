/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.Component;
import org.aswing.Container;
import org.aswing.geom.Dimension;
import org.aswing.geom.Point;
import org.aswing.geom.Rectangle;
import org.aswing.Insets;
import org.aswing.JViewport;
import org.aswing.ViewportLayout;

/**
 * @author iiley
 */
class org.aswing.thumbstrip.ThumbStripViewportLayout extends ViewportLayout {
	
	public function ThumbStripViewportLayout() {
		super();
	}
	
    /**
     * Called by the AWT when the specified container needs to be laid out.
     *
     * @param parent  the container to lay out
     */
    public function layoutContainer(parent:Container):Void{
		var vp:JViewport = JViewport(parent);
		var view:Component = vp.getView();
	
		if (view == null) {
		    return;
		}
	
		/* All of the dimensions below are in view coordinates, except
		 * vpSize which we're converting.
		 */
	
		var insets:Insets = vp.getInsets();
		var viewPrefSize:Dimension = view.getPreferredSize();
		var vpSize:Dimension = vp.getSize();
		var extentSize:Dimension = vp.toScreenCoordinatesSize(vp.getExtentSize());
		var showBounds:Rectangle = new Rectangle(insets.left, insets.top, extentSize.width, extentSize.height);

		var viewSize:Dimension = new Dimension(viewPrefSize);
	
		var viewPosition:Point = vp.toScreenCoordinatesLocation(vp.getViewPosition());
	
		/* justify
		 * the view when the width of the view is smaller than the
		 * container.
		 */
	    if((viewPosition.x + extentSize.width) > viewSize.width){
			viewPosition.x = Math.max(0, viewSize.width - extentSize.width);
	    }
	
		/* If the new viewport size would leave empty space below the
		 * view, bottom justify the view or top justify the view when
		 * the height of the view is smaller than the container.
		 */
		if ((viewPosition.y + extentSize.height) > viewSize.height) {
		    viewPosition.y = Math.max(0, viewSize.height - extentSize.height);
		}
	
		/* If we haven't been advised about how the viewports size 
		 * should change wrt to the viewport.
		 */
		var vo:Object = view;
		if(vo.isTracksViewportHeight() == true){
		    viewSize.height = extentSize.height;
		}
		if(vo.isTracksViewportWidth() == true){
		    viewSize.width = extentSize.width;
		}

		vp.setViewPosition(vp.toViewCoordinatesLocation(viewPosition));
		view.setSize(viewSize);
    }
}