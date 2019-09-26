/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.tree.AbstractLayoutCache;
import GUI.fox.aswing.tree.FHTreeStateNode;
import GUI.fox.aswing.tree.TreePath;

/**
 * @author iiley
 */
class GUI.fox.aswing.tree.SearchInfo {
	public var node:FHTreeStateNode;
	public var isNodeParentNode:Boolean;
	public var childIndex:Number;
	private var layoutCatch:AbstractLayoutCache;
	
	public function SearchInfo(layoutCatch:AbstractLayoutCache){
		this.layoutCatch = layoutCatch;
	}

	public function getPath():TreePath {
	    if(node == null){
			return null;
	    }

	    if(isNodeParentNode){
			return node.getTreePath().pathByAddingChild(layoutCatch.getModel().getChild(node.getUserObject(),
						     childIndex));
	    }
	    return node.getTreePath();
	}	
}