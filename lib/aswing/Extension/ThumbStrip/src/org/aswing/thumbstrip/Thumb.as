/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.border.EmptyBorder;
import org.aswing.BorderLayout;
import org.aswing.Insets;
import org.aswing.JLabel;
import org.aswing.JLoadPane;
import org.aswing.JPanel;
import org.aswing.Component;

/**
 * @author Igor Sadovskiy
 */
interface org.aswing.thumbstrip.Thumb{
	
	/**
	 * Sets new thumb title.
	 * 
	 * @param newTitle the thumb title to set.
	 */
	public function setTitle(newTitle:String):Void;
	
	/**
	 * Returns current thumb title.
	 * 
	 * @return the thumb title.
	 */
	public function getTitle(Void):String;
	
		
	/**
	 * Gets background color.
	 * 
	 * @return background color.
	 */
	public function getBackground(Void):ASColor;
	
	/**
	 * Sets background color.
	 * 
	 * @param color the background color to set.
	 */
	public function setBackground(color:ASColor):Void;
	
	/**
	 * Adds new listener to thumb.
	 */
	public function addEventListener(eventTypeOrLis:Object, func:Function, obj:Object):Object;
	
	/**
	 * Remove listener from thumb.
	 */
	public function removeEventListener(listener:Object):Void;
	
	/**
	 * Returns itself as a {@link org.aswing.Component} instance.
	 * 
	 * @return itself as a {@link org.aswing.Component} instance 
	 */
	public function getPane(Void):Component;
	
}