import org.aswing.ASColor;
import org.aswing.awml.AwmlNamespace;
import org.aswing.awml.AwmlParser;
import org.aswing.awml.component.ComponentParser;
import org.aswing.thumbstrip.ThumbStrip;

/**
 * @author Igor Sadovskiy
 */
class org.aswing.thumbstrip.awml.ThumbStripParser extends ComponentParser {
	
	private static var CHILD_HIGHLIGHTED_COLOR:String = "highlighted-color";
	private static var CHILD_SELECTED_COLOR:String = "selected-color";
	
	private static var ATTR_HIGHLIGHT_ENABLED:String = "highlight-enabled";
	private static var ATTR_ORIENTATION:String = "orientation";
	private static var ATTR_SCROLL_BAR_POSITION:String = "scroll-bar-position";
	private static var ATTR_SCROLL_BAR_SHOW_POLICY:String = "scroll-bar-show-policy";
	private static var ATTR_SCROLL_TO_SELECTION:String = "scroll-to-selection";
	private static var ATTR_THUMB_PREFERRED_WIDTH:String = "thumb-preferred-width";
	private static var ATTR_THUMB_PREFERRED_HEIGHT:String = "thumb-preferred-height";
	
	private static var ATTR_ON_SELECTION_CHANGED:String = "on-selection-changed";
	private static var ATTR_ON_THUMB_CLICKED:String = "on-thumb-clicked";
	
	private static var ORIENTATION_VERTICAL:String = "vertical";
	private static var ORIENTATION_HORIZONTAL:String = "horizontal";
	private static var ORIENTATION_BOTH:String = "both";
	
	private static var POSITION_TOP:String = "top";
	private static var POSITION_LEFT:String = "left";
	private static var POSITION_RIGHT:String = "right";
	private static var POSITION_BOTTOM:String = "bottom";
	
	private static var SHOW_POLICY_ALWAYS:String = "always";
	private static var SHOW_POLICY_AS_NEED:String = "as-need";
	private static var SHOW_POLICY_NEVER:String = "never";
	
	public function ThumbStripParser(Void) {
		super();
	}

    public function parse(awml:XMLNode, ts:ThumbStrip, namespace:AwmlNamespace) {
    	
    	if (ts == null) {
    		ts = new ThumbStrip();	
    	} 
    	
        super.parse(awml, ts, namespace);
        
        ts.setHighlightEnabled(getAttributeAsBoolean(awml, ATTR_HIGHLIGHT_ENABLED, ts.isHighlightEnabled()));
        ts.setScrollToSelection(getAttributeAsBoolean(awml, ATTR_SCROLL_TO_SELECTION, ts.isScrollToSelection()));
        ts.setThumbPreferredWidth(getAttributeAsNumber(awml, ATTR_THUMB_PREFERRED_WIDTH, ts.getThumbPreferredWidth()));
        ts.setThumbPreferredHeight(getAttributeAsNumber(awml, ATTR_THUMB_PREFERRED_HEIGHT, ts.getThumbPreferredHeight()));
        
        var orientation:String = getAttributeAsString(awml, ATTR_ORIENTATION, null);
        switch (orientation) {
        	case ORIENTATION_HORIZONTAL:
        		ts.setOrientation(ThumbStrip.HORIZONTAL);
        		break; 	
        	case ORIENTATION_VERTICAL:
        		ts.setOrientation(ThumbStrip.VERTICAL);
        		break; 	
        	case ORIENTATION_BOTH:
        		ts.setOrientation(ThumbStrip.BOTH);
        		break; 	
        }

		var position:String = getAttributeAsString(awml, ATTR_SCROLL_BAR_POSITION, null);
		switch (position) {
        	case POSITION_BOTTOM:
        		ts.setScrollBarPosition(ThumbStrip.SCROLLBAR_BOTTOM);
        		break; 	
        	case POSITION_LEFT:
        		ts.setScrollBarPosition(ThumbStrip.SCROLLBAR_LEFT);
        		break; 	
        	case POSITION_RIGHT:
        		ts.setScrollBarPosition(ThumbStrip.SCROLLBAR_RIGHT);
        		break; 	
        	case POSITION_TOP:
        		ts.setScrollBarPosition(ThumbStrip.SCROLLBAR_TOP);
        		break; 	
		}
		        
		var show:String = getAttributeAsString(awml, ATTR_SCROLL_BAR_SHOW_POLICY, null);
		switch (show) {
        	case SHOW_POLICY_ALWAYS:
        		ts.setScrollBarShowPolicy(ThumbStrip.SCROLLBAR_ALWAYS);
        		break; 	
        	case SHOW_POLICY_AS_NEED:
        		ts.setScrollBarShowPolicy(ThumbStrip.SCROLLBAR_AS_NEEDED);
        		break; 	
        	case SHOW_POLICY_NEVER:
        		ts.setScrollBarShowPolicy(ThumbStrip.SCROLLBAR_NEVER);
        		break; 	
		}
        
        attachEventListeners(ts, ThumbStrip.ON_SELECTION_CHANGED, getAttributeAsEventListenerInfos(awml, ATTR_ON_SELECTION_CHANGED));
        attachEventListeners(ts, ThumbStrip.ON_THUMB_CLICKED, getAttributeAsEventListenerInfos(awml, ATTR_ON_THUMB_CLICKED));
        
        return ts;
	}

	private function parseChild(awml:XMLNode, nodeName:String, ts:ThumbStrip, namespace:AwmlNamespace):Void {

		super.parseChild(awml, nodeName, ts, namespace);
		
		switch (nodeName) {
			case CHILD_HIGHLIGHTED_COLOR:
				var color:ASColor = AwmlParser.parse(awml);
				if (color != null) ts.setHighlightedColor(color);
				break;
			case CHILD_SELECTED_COLOR:
				var color:ASColor = AwmlParser.parse(awml);
				if (color != null) ts.setSelectedColor(color);
				break;
		}
	}

}