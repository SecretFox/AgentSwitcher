/*
 Copyright aswing.org, see the LICENCE.txt.
*/

/**
 * @author iiley
 */
interface GUI.fox.aswing.Action {
	
	/**
	 * Invoked when an action occurs.
	 * <p>
	 * The method name "onActionPerformed" is same to <code>EventDispatcher.ON_ACT</code>
	 * @see GUI.fox.aswing.EventDispatcher#ON_ACT
	 */
	public function onActionPerformed(source:Object):Void;
	
}