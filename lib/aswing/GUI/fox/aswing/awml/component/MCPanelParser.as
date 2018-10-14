/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.component.ContainerParser;
import GUI.fox.aswing.MCPanel;
import GUI.fox.aswing.ASWingUtils;

/**
 * Parses {@link GUI.fox.aswing.MCPanel} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.MCPanelParser extends ContainerParser {
	
	private static var ATTR_MOVIE_CLIP:String = "movie-clip";
	
	/**
	 * Constructor.
	 */
	public function MCPanelParser(Void) {
		super();
	}
	
	public function parse(awml:XMLNode, panel:MCPanel, namespace:AwmlNamespace) {
		
		panel = super.parse(awml, panel, namespace);
		
		return panel;
	}

	private function getMovieClip(awml:XMLNode):MovieClip {
		return getAttributeAsMovieClip(awml, ATTR_MOVIE_CLIP, ASWingUtils.getRootMovieClip());
	}

    private function getClass(Void):Function {
    	return MCPanel;	
    }
    
    private function getArguments(awml:XMLNode):Array {
    	return [getMovieClip(awml)];
    }    

}
