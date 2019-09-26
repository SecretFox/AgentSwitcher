/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.AwmlUtils;
import GUI.fox.aswing.awml.component.ComponentParser;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.Container;
import GUI.fox.aswing.LayoutManager;

/**
 * Parses {@link GUI.fox.aswing.Container} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.ContainerParser extends ComponentParser {
	
    private static var ATTR_ON_COMPONENT_ADDED:String = "on-component-added";
    private static var ATTR_ON_COMPONENT_REMOVED:String = "on-component-removed";
	
	
	/**
	 * Private Constructor.
	 */
	private function ContainerParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, container:Container, namespace:AwmlNamespace) {
		
		container = super.parse(awml, container, namespace);
		
        // init events
        attachEventListeners(container, Container.ON_COM_ADDED, getAttributeAsEventListenerInfos(awml, ATTR_ON_COMPONENT_ADDED));
        attachEventListeners(container, Container.ON_COM_REMOVED, getAttributeAsEventListenerInfos(awml, ATTR_ON_COMPONENT_REMOVED));
		
		return container;
	}
	
	private function parseChild(awml:XMLNode, nodeName:String, container:Container, namespace:AwmlNamespace):Void {

		super.parseChild(awml, nodeName, container, namespace);

		if (AwmlUtils.isComponentNode(nodeName)) {
			var component:Component = AwmlParser.parse(awml, null, namespace);
			if (component != null) append(container, component, component.getAwmlIndex());
		} else if (AwmlUtils.isLayoutNode(nodeName)) {
			var layout:LayoutManager = AwmlParser.parse(awml);
			if (layout != null) setLayout(container, layout);
		}
	}
	
	/**
	 * Appends <code>component</code> to the <code>container</code>.
	 * 
	 * @param container the container to add the component to
	 * @param component the component to add to the container
	 * @param index (optional) the index to insert component into container 
	 */
	private function append(container:Container, component:Component, index:Number):Void {
		if (index != null) {
			container.insert(index, component);
		} else {
			container.append(component);
		}
	}
	
	/**
	 * Set <code>layout</code> to the <code>container</code>.
	 * 
	 * @param container the container to set layout
	 * @param layout the layout to set 
	 */
	private function setLayout(container:Container, layout:LayoutManager):Void {
		container.setLayout(layout);
	}
	
}
