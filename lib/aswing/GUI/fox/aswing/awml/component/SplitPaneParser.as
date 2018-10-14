/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.component.ContainerParser;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.JSplitPane;

/**
 * Parses {@link GUI.fox.aswing.JSplitPane} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.SplitPaneParser extends ContainerParser {
    
    private static var ATTR_CONTINUOUS_LAYOUT:String = "continuous-layout";
    private static var ATTR_DIVIDER_LOCATION:String = "divider-location";
    private static var ATTR_DIVIDER_SIZE:String = "divider-size";
    private static var ATTR_ONE_TOUCH_EXPANDABLE:String = "one-touch-expandable";
    private static var ATTR_RESIZE_WEIGHT:String = "resize-weight";
    private static var ATTR_ORIENTATION:String = "orientation";
    
	private static var ORIENTATION_HORIZONTAL:String = "horizontal";
	private static var ORIENTATION_VERTICAL:String = "vertical"; 
    
    /**
     * Constructor.
     */
    public function SplitPaneParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, split:JSplitPane, namespace:AwmlNamespace) {
    	
        split = super.parse(awml, split, namespace);
        
        // init divider
        split.setDividerLocation(getAttributeAsNumber(awml, ATTR_DIVIDER_LOCATION, split.getDividerLocation()));
        split.setDividerSize(getAttributeAsNumber(awml, ATTR_DIVIDER_SIZE, split.getDividerSize()));
        split.setResizeWeight(getAttributeAsNumber(awml, ATTR_RESIZE_WEIGHT, split.getResizeWeight()));
        
        // init continuous layout
        split.setContinuousLayout(getAttributeAsBoolean(awml, ATTR_CONTINUOUS_LAYOUT, split.isContinuousLayout()));
        
        // init one tought
        split.setOneTouchExpandable(getAttributeAsBoolean(awml, ATTR_ONE_TOUCH_EXPANDABLE, split.isOneTouchExpandable()));

		// init orientation
		var orientation:String = getAttributeAsString(awml, ATTR_ORIENTATION);
		switch (orientation) {
			case ORIENTATION_HORIZONTAL:
				split.setOrientation(JSplitPane.HORIZONTAL_SPLIT);
				break;
			case ORIENTATION_VERTICAL:
				split.setOrientation(JSplitPane.VERTICAL_SPLIT);
				break;
		}
        
        return split;
	}
 
 	private function parseChild(awml:XMLNode, nodeName:String, split:JSplitPane, namespace:AwmlNamespace):Void {

		super.parseChild(awml, nodeName, split, namespace);

		if (nodeName == AwmlConstants.NODE_TOP_COMPONENT) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) split.setTopComponent(component);
		} else if (nodeName == AwmlConstants.NODE_BOTTOM_COMPONENT) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) split.setBottomComponent(component);
		} if (nodeName == AwmlConstants.NODE_LEFT_COMPONENT) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) split.setLeftComponent(component);
		} if (nodeName == AwmlConstants.NODE_RIGHT_COMPONENT) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) split.setRightComponent(component);
		} 
 	}
 
    private function getClass(Void):Function {
    	return JSplitPane;	
    }
    
}
