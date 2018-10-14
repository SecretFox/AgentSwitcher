/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.Component;
import org.aswing.Container;
import org.aswing.geom.Dimension;
import org.aswing.geom.Rectangle;
import org.aswing.Insets;
import org.aswing.plaf.UIResource;
import org.aswing.WindowLayout;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.frame.FrameLayout extends WindowLayout implements UIResource{
	
	private var titleBar:Component;

	private var contentPane:Component;

    /**
     * The title bar layout constraint.
     */
    public static var TITLE:String  = "Title";

    /**
     * The content pane layout constraint.
     */
    public static var CONTENT:String  = "Content";
    
	private var outRound:Number;
	private var inRound:Number;
	private var sideBorder:Number;
	private var margin:Insets;
	
	public function FrameLayout(outRound:Number, inRound:Number, sideBorder:Number){
		super();
		this.outRound = outRound;
		this.inRound  = inRound;
		this.sideBorder = sideBorder;
		margin = new Insets(2, Math.ceil(outRound/2), 0, Math.ceil(outRound/4));
	}
	
	public function getTitleBarMargin():Insets{
		return new Insets(margin.top, margin.left, margin.bottom, margin.right);
	}
		
	/**
	 * @param comp the child to add to the layout
	 * @param constraints the constraints indicate what position the child will be added.
	 * @throws Error when the constraints is not <code>TITLE</code> either <code>CONTENT</code>.
	 */
    public function addLayoutComponent(comp:Component, constraints:Object):Void {
    	if(constraints == TITLE){
	    	titleBar = comp;
	    }else if(constraints == CONTENT){
	    	contentPane = comp;
	    }else{
	    	trace("ERROR When add component to JFrame, constraints must be TITLE or CONTENT : " + constraints);
	    	throw new Error("ERROR When add component to JFrame, constraints must be TITLE or CONTENT : " + constraints);
	    }
    }
    
    public function getTitleBar():Component{
    	return titleBar;
    }
    
    public function getContentPane():Component{
    	return contentPane;
    }
    
    public function removeLayoutComponent(comp:Component):Void {
     	if(comp == titleBar){
     		titleBar = null;
     	}else if(comp == contentPane){
     		contentPane = null;
     	}
     }

	public function minimumLayoutSize(target:Container):Dimension {
		var insets:Insets = target.getInsets();
		var size:Dimension = insets.getOutsideSize();
		if(titleBar != null){
			size.increaseSize(titleBar.getMinimumSize());
		}
		return margin.getOutsideSize(size);
	}
	
	public function preferredLayoutSize(target:Container):Dimension {
		var insets:Insets = target.getInsets();
		var size:Dimension = insets.getOutsideSize();
		var titleBarSize:Dimension, contentSize:Dimension;
		if(titleBar != null){
			titleBarSize = margin.getOutsideSize(titleBar.getPreferredSize());
		}else{
			titleBarSize = margin.getOutsideSize();
		}
		var contentMargin:Insets = getContentMargin();
		if(contentPane != null){
			contentSize = contentMargin.getOutsideSize(contentPane.getPreferredSize());
		}else{
			contentSize = contentMargin.getOutsideSize();
		}
		size.increaseSize(new Dimension(Math.max(titleBarSize.width, contentSize.width), titleBarSize.height + contentSize.height));
		return size;
	}
	
	private function getContentMargin():Insets{
		var contentMargin:Insets = new Insets();
		var inMargin:Number = Math.ceil(inRound - inRound*0.707106781186547);;
		contentMargin.top = inMargin;
		contentMargin.bottom = contentMargin.left = contentMargin.right = inMargin + sideBorder;
		return contentMargin;
	}
	
	public function layoutContainer(target:Container):Void{	
    	var td:Dimension = target.getSize();
		var insets:Insets = target.getInsets();
		var r:Rectangle = insets.getInsideBounds(td.getBounds());
		
		var contentMargin:Insets = getContentMargin();
		var d:Dimension;
		if(titleBar != null){
			d = titleBar.getPreferredSize();
			titleBar.setBounds(r.x + margin.left, 
								r.y + margin.top, 
								r.width - (margin.left + margin.right), 
								d.height);
			r.y += d.height + margin.top + margin.bottom;
			r.height -= d.height + margin.top + margin.bottom;
		}
		r.y += contentMargin.top;
		r.x += contentMargin.left;
		r.width -= (contentMargin.left + contentMargin.right);
		r.height -= (contentMargin.top + contentMargin.bottom);
		if(contentPane != null){
			contentPane.setBounds(r.x, r.y, r.width, r.height);
		}
	}
	
    public function toString():String {
		return "FrameLayout[]";
    }
}