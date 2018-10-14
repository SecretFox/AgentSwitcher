/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import GUI.fox.aswing.Component;
import GUI.fox.aswing.dnd.SourceData;
import GUI.fox.aswing.geom.Point;

/**
 * Drag and Drop listener.
 * 
 * @author iiley
 */
interface GUI.fox.aswing.dnd.DragListener {
	
	/**
	 * When a drag action started.
	 * @param dragInitiator the drag initiator component
	 * @param dragSource the data source
	 * @param pos a Point indicating the cursor location in global space
	 * @see Component#isDragEnabled()
	 */
	public function onDragStart(dragInitiator:Component, sourceData:SourceData, pos:Point):Void;
	
	/**
	 * Called while a drag operation is ongoing, when the mouse pointer enters a drop trigger component area.
	 * @param dragInitiator the drag initiator component
	 * @param dragSource the data source
	 * @param pos a Point indicating the cursor location in global space
	 * @param targetComponent the mouse entered component
	 * @see Component#isDropTrigger()
	 */
	public function onDragEnter(dragInitiator:Component, sourceData:SourceData, pos:Point, targetComponent:Component):Void;
	
	/**
	 * Called when a drag operation is ongoing(mouse is moving), while the mouse pointer is still over the entered component area.
	 * @param dragInitiator the drag initiator component
	 * @param dragSource the data source
	 * @param pos a Point indicating the cursor location in global space
	 * @param targetComponent the mouse overred component
	 * @see Component#isDropTrigger()
	 */
	public function onDragOverring(dragInitiator:Component, sourceData:SourceData, pos:Point, targetComponent:Component):Void;
	
	/**
	 * Called while a drag operation is ongoing, when the mouse pointer has exited the entered a drop trigger component. 
	 * @param dragInitiator the drag initiator component
	 * @param dragSource the data source
	 * @param pos a Point indicating the cursor location in global space
	 * @param targetComponent the mouse exited component
	 * @see Component#isDropTrigger()
	 */
	public function onDragExit(dragInitiator:Component, sourceData:SourceData, pos:Point, targetComponent:Component):Void;
	
	/**
	 * Called when drag operation finished.
	 * <p>
	 * Generally if you want to do a custom motion of the dragging movie clip when dropped, you may 
	 * call the DragManager.setDropMotion() method to achieve.
	 * @param dragInitiator the drag initiator component
	 * @param dragSource the data source
	 * @param pos a Point indicating the cursor location in global space
	 * @param targetComponent dropped component, it may be null if droped on a non-drag-trigger space.
	 * @see Component#isDropTrigger()
	 * @see GUI.fox.aswing.dnd.DragManager#setDropMotion()
	 */
	public function onDragDrop(dragInitiator:Component, sourceData:SourceData, pos:Point, targetComponent:Component):Void;
	
}