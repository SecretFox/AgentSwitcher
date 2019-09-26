/*
 Copyright aswing.org, see the LICENCE.txt.
*/

/**
 * Defines the requirements for an object that can be used as a
 * tree node in a JTree.
 * 
 * @author iiley
 * @see GUI.fox.aswing.tree.MutableTreeNode
 * @see GUI.fox.aswing.tree.DefaultMutableTreeNode
 * @see GUI.fox.aswing.JTree
 */
interface GUI.fox.aswing.tree.TreeNode {
	
    /**
     * Returns the child <code>TreeNode</code> at index 
     * <code>childIndex</code>.
     */
    public function getChildAt(childIndex:Number):TreeNode;

    /**
     * Returns the number of children <code>TreeNode</code>s the receiver
     * contains.
     */
    public function getChildCount():Number;

    /**
     * Returns the parent <code>TreeNode</code> of the receiver.
     */
    public function getParent():TreeNode;

    /**
     * Returns the index of <code>node</code> in the receivers children.
     * If the receiver does not contain <code>node</code>, -1 will be
     * returned.
     */
    public function getIndex(node:TreeNode):Number;

    /**
     * Returns true if the receiver allows children.
     */
    public function getAllowsChildren():Boolean;

    /**
     * Returns true if the receiver is a leaf.
     */
    public function isLeaf():Boolean;

    /**
     * Returns the children of the receiver as an <code>Enumeration</code>.
     */
    public function children():Array;
}