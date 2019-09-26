/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.component.ListParser;
import GUI.fox.aswing.awml.component.tree.TreeRootParser;
import GUI.fox.aswing.JListTree;
import GUI.fox.aswing.tree.DefaultMutableTreeNode;
import GUI.fox.aswing.tree.DefaultTreeModel;
import GUI.fox.aswing.tree.TreePath;
import GUI.fox.aswing.VectorListModel;

/**
 * Parses {@link GUI.fox.aswing.JListTree} level elements.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.component.ListTreeParser extends ListParser {
    
    private static var ATTR_ROOT_VISIBLE:String = "root-visible";
    private static var ATTR_TOGGLE_CLICK_COUNT:String = "toggle-click-count";
    private static var ATTR_SELECTED_ROW:String = "selected-row";
    private static var ATTR_SELECTED_ROWS:String = "selected-rows";
    
    /**
     * Constructor.
     */
    public function ListTreeParser(Void) {
        super();
    }
    
    public function parse(awml:XMLNode, listTree:JListTree, namespace:AwmlNamespace) {
        
        listTree = super.parse(awml, listTree, namespace);
                
        // init toggle click count
        listTree.setToggleClickCount(getAttributeAsNumber(awml, ATTR_TOGGLE_CLICK_COUNT, listTree.getToggleClickCount()));
        
        // init root visible
        listTree.setRootVisible(getAttributeAsBoolean(awml, ATTR_ROOT_VISIBLE, listTree.isRootVisible()));
        
        // init selected rows
        var selectedRow:Number = getAttributeAsNumber(awml, ATTR_SELECTED_ROW, null);
        if (selectedRow != null) listTree.setSelectionRow(selectedRow);
        listTree.setSelectionRows(getAttributeAsArray(awml, ATTR_SELECTED_ROWS, listTree.getSelectionRows()));
        
        return listTree;
    }
    
    private function parseChild(awml:XMLNode, nodeName:String, treeList:JListTree, namespace:AwmlNamespace):Void {
        super.parseChild(awml, nodeName, treeList, namespace);
    }
    
    private function parseChildItem(awml:XMLNode, nodeName:String, treeList:JListTree):Void {
        switch (nodeName) {
            case AwmlConstants.NODE_TREE_ROOT:
                var root:DefaultMutableTreeNode = AwmlParser.parse(awml);
                if (root != null) {
                    treeList.setTreeModel(new DefaultTreeModel(root));

                    // init expanded
                    for (var i = 0; i < TreeRootParser.getExpandedNodes().length; i++) {
                        var path:Array = (DefaultMutableTreeNode(TreeRootParser.getExpandedNodes()[i])).getPath();
                        treeList.setExpandState(new TreePath(path), true);
                    }
                    
                    // init selection
                    for (var i = 0; i < TreeRootParser.getSelectedNodes().length; i++) {
                        var path:Array = (DefaultMutableTreeNode(TreeRootParser.getSelectedNodes()[i])).getPath();
                        treeList.addSelectionPath(new TreePath(path));
                    }
                }   
                break;
			case AwmlConstants.NODE_LIST_TREE_ITEMS:
				var collection:Array = AwmlParser.parse(awml);
				if (collection != null) treeList.setModel(new VectorListModel(collection)); 
				break;
        }
    }
    
    private function getClass(Void):Function {
    	return JListTree;	
    }
    
}
