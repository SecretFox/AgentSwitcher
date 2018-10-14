/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.border.EmptyBorder;
import org.aswing.BorderLayout;
import org.aswing.Component;
import org.aswing.Insets;
import org.aswing.JLabel;
import org.aswing.JLoadPane;
import org.aswing.JPanel;
import org.aswing.thumbstrip.AbstractThumb;
import org.aswing.thumbstrip.Thumb;
import org.aswing.thumbstrip.FloorPaneThumb;

/**
 * @author Igor Sadovskiy
 */
class org.aswing.thumbstrip.LoadThumb extends FloorPaneThumb implements Thumb {
	
	/**
	 * When the thumb image is loaded.
	 *<br>
	 * onThumbLoaded(source:Component)
	 */	
	public static var ON_THUMB_LOADED:String = "onThumbLoaded";


	/** Empty image container status */
	public static var STATUS_EMPTY:Number = 0;
	
	/** Image loading to the container is in progress status. */
	public static var STATUS_LOADING:Number = 1;

	/** Image is loaded to the container status. */
	public static var STATUS_LOADED:Number = 2;
	
	
	private var url:String;
	private var status:Number;  
	private var loadImmediately:Boolean;
	
	/**
	 * Constructs new <code>ImageThumb</code> instance.
	 * 
	 * @param url the url to load image from.
	 * @param title the image title.
	 * @param loadImmediately the load immediately flag
	 */
	public function LoadThumb(url:String, title:String, loadImmediately:Boolean) {
		super(new JLoadPane(), title);
		
		thumbPane.addEventListener(JLoadPane.ON_LOAD_INIT, __onThumbLoadComplete, this);
		thumbPane.addEventListener(JLoadPane.ON_LOAD_ERROR, __onThumbLoadError, this);
		
		// init component
		status = STATUS_EMPTY; 
		this.loadImmediately = (loadImmediately != false);
		
		setUrl(url);
	}
	
	/**
	 * Sets new image URL.
	 * 
	 * @param newUrl the image URL to set.
	 */
	public function setUrl(newUrl:String):Void {
		if (url != newUrl) {
			url = newUrl;
			if (loadImmediately) load();
		}
	}
	
	/**
	 * Returns current image URL.
	 * 
	 * @return the image URL.
	 */
	public function getUrl(Void):String {
		return url;
	}

	/**
	 * Sets new image title.
	 * 
	 * @param newTitle the image title to set.
	 */
	public function setTitle(newTitle:String):Void {
		title = (newTitle != null) ? newTitle : null;
		if (isLoaded()) {
			updateTitle();	
		}
	}
	
	/**
	 * Sets immediately loading flag. If <code>flag</code> is <core>true</code>
	 * and image isn't loaded yet, starts image loading immediately.
	 * 
	 * @param flag the immediately loading flag.
	 */
	public function setLoadImmediately(flag:Boolean):Void {
		if (loadImmediately != flag) {
			loadImmediately = flag;
			if (loadImmediately && isEmpty()) {
				load();
			}
		}	
	}
	
	/**
	 * Checks if image will be immediately loaded or not.
	 * 
	 * @return <code>true</true> if will be immediately loaded 
	 * and <code>false</code> if not.
	 */
	public function isLoadImmediately(Void):Boolean {
		return loadImmediately;
	}
	
	/**
	 * Checks if image is empty now or not.
	 * 
	 * @return <code>true</true> if empty and <code>false</code> if not.
	 */
	public function isEmpty(Void):Boolean {
		return (status == STATUS_EMPTY);	
	}
	
	/**
	 * Checks if image is loading right now or not.
	 * 
	 * @return <code>true</true> if loading and <code>false</code> if not.
	 */
	public function isLoading(Void):Boolean {
		return (status == STATUS_LOADING);	
	}	
	
	/**
	 * Checks if image is loaded or not.
	 * 
	 * @return <code>true</true> if loaded and <code>false</code> if not.
	 */
	public function isLoaded(Void):Boolean {
		return (status == STATUS_LOADED);	
	}
	
	/**
	 * Gets current image container status.
	 * 
	 * @return current image container status.
	 * 
	 * @see #STATUS_EMPTY
	 * @see #STATUS_LOADING
	 * @see #STATUS_LOADED
	 */
	public function getStatus(Void):Number {
		return status;	
	}
	
	/**
	 * Reloads image inside container.
	 */
	public function load(Void):Void {
		unload();
		getThumbPane().setPath(url);
		status = STATUS_LOADING;
	}
	
	/**
	 * Unload image.
	 */
	public function unload(Void):Void {
		getThumbPane().setPath(null);
		status = STATUS_EMPTY;
	}
	
	/** Fires #ON_THUMB_LOADED event. */
	private function fireThumbLoaded(Void):Void {
		dispatchEvent(createEventObj(ON_THUMB_LOADED));
	}

	/** Handles org.aswing.JLoadPane#ON_LOAD_INIT event. */
	private function __onThumbLoadComplete(Void) {
		updateTitle();
		scaleImage();
		status = STATUS_LOADED;
		fireThumbLoaded();
	}
	
	/** Handles org.aswing.JLoadPane#ON_LOAD_ERROR event. */
	private function __onThumbLoadError(Void) {
		status = STATUS_EMPTY;
	}
	
	/** Handles org.aswing.Component#ON_RESIZED event for imahe pane. */
	private function __onResized(Void):Void {
		
		if (getThumbPane().getFloorOriginalSize() != null) {
			scaleImage();	
		}
	}
	
}