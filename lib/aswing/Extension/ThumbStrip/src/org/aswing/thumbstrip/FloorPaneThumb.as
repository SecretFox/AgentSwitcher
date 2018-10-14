/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.CenterLayout;
import org.aswing.FloorPane;
import org.aswing.JLabel;
import org.aswing.JLoadPane;
import org.aswing.thumbstrip.AbstractThumb;

/**
 * @author Igor Sadovskiy
 */
class org.aswing.thumbstrip.FloorPaneThumb extends AbstractThumb {
	
	private var label:JLabel;
	
	public function FloorPaneThumb(thumbPane:FloorPane, title:String) {
		super(thumbPane, title);
		
		label = new JLabel("", null, JLabel.CENTER);
		label.setTriggerEnabled(false);
		
		thumbPane.setVerticalAlignment(JLoadPane.CENTER);
		thumbPane.setHorizontalAlignment(JLoadPane.CENTER);
		thumbPane.addEventListener(JLoadPane.ON_RESIZED, __onResized, this);
		thumbPane.setLayout(new CenterLayout());
		thumbPane.append(label);
	}
	
	private function getThumbPane(Void):FloorPane{
		return FloorPane(thumbPane);	
	}
	
	/**
	 * Sets message displayed over the thumb.
	 * @param text the text to display
	 */
	public function setLabel(text:String):Void {
		label.setText(text);	
	}
	
	/**
	 * Returns message displayed over the thumb.
	 * @return the text displayed over the thumb
	 */
	public function getLabel(Void):String {
		return label.getText();	
	}	
	
	/** Scales image inside pane if required. */
	private function scaleImage(Void):Void {
		// checks wherever image is required to be scaled
		if (getThumbPane().getWidth() < getThumbPane().getFloorOriginalSize().width || getThumbPane().getHeight() < getThumbPane().getFloorOriginalSize().height) {
			getThumbPane().setScaleMode(JLoadPane.SCALE_FIT_PANE);
		} else {
			getThumbPane().setScaleMode(JLoadPane.SCALE_NONE);
		} 		
	}
	
	/** Handles org.aswing.Component#ON_RESIZED event for imahe pane. */
	private function __onResized(Void):Void {
		if (getThumbPane().getFloorOriginalSize() != null) {
			scaleImage();	
		}
	}
	
}