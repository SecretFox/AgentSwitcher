/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.border.EmptyBorder;
import org.aswing.BorderLayout;
import org.aswing.Component;
import org.aswing.FloorPane;
import org.aswing.Insets;
import org.aswing.JLabel;
import org.aswing.JLoadPane;
import org.aswing.JPanel;
import org.aswing.thumbstrip.Thumb;
import org.aswing.Container;

/**
 * @author Igor Sadovskiy
 */
class org.aswing.thumbstrip.AbstractThumb extends JPanel implements Thumb {
	
	/**
	 * When the thumb is clicked.
	 *<br>
	 * onThumbClicked(source:Component)
	 */	
	public static var ON_THUMB_CLICKED:String = "onThumbClicked";

	/**
	 * When the thumb is roll over.
	 *<br>
	 * onImageRollOver(source:Component)
	 */	
	public static var ON_THUMB_ROLLOVER:String = "onThumbRollOver";

	/**
	 * When the thumb is roll out.
	 *<br>
	 * onThumbRollOut(source:Component)
	 */	
	public static var ON_THUMB_ROLLOUT:String = "onThumbRollOut";
	
	
	private var title:String;
	
	private var mainPane:JPanel;
	private var thumbPane:Component;
	private var thumbLabel:JLabel;
	
	/**
	 * Constructs new <code>AbstractThumb</code> instance.
	 * 
	 * @param tp the thumb pane component 
	 * @param title the thumb's title.
	 */
	private function AbstractThumb(tp:Component, title:String) {
		super();
		
		thumbPane = tp;
		thumbPane.setTriggerEnabled(false);
		thumbPane.setBorder(new EmptyBorder(null, Insets.createIdentic(5)));
		
		mainPane = new JPanel(new BorderLayout());
		mainPane.setOpaque(true);
		mainPane.setTriggerEnabled(false);
		mainPane.append(thumbPane, BorderLayout.CENTER);
		
		thumbLabel = new JLabel();
		thumbLabel.setTriggerEnabled(false);
		thumbLabel.getHorizontalAlignment(JLabel.CENTER);
		
		setUseHandCursor(true);		
		addEventListener(ON_CLICKED, __onThumbClick, this);
		addEventListener(ON_ROLLOVER, __onThumbRollOver, this);
		addEventListener(ON_ROLLOUT, __onThumbRollOut, this);
		
		setLayout(new BorderLayout());
		append(mainPane, BorderLayout.CENTER);
		append(thumbLabel, BorderLayout.SOUTH);
		
		setTitle(title);
	}
		
	/**
	 * Returns itself as a {@link org.aswing.Component} instance.
	 * 
	 * @return itself as a {@link org.aswing.Component} instance 
	 */
	public function getPane(Void):Component {
		return this;
	}
		
	/**
	 * Sets new image title.
	 * 
	 * @param newTitle the image title to set.
	 */
	public function setTitle(newTitle:String):Void {
		title = (newTitle != null) ? newTitle : null;
		updateTitle();
	}
	
	/**
	 * Returns current image title.
	 * 
	 * @return the image title.
	 */
	public function getTitle(Void):String {
		return title;
	}

	/** Updates image title. */
	private function updateTitle(Void):Void {
		thumbLabel.setText(title);
		thumbPane.setToolTipText(title);
	}

	/**
	 * Gets background color.
	 * 
	 * @return background color.
	 */
	public function getBackground(Void):ASColor {
		return mainPane.getBackground();
	}

	/**
	 * Sets background color.
	 * 
	 * @param color the background color to set.
	 */
	public function setBackground(color:ASColor):Void {
		mainPane.setBackground(color);
		thumbLabel.setOpaque(true);
		thumbLabel.setBackground(color);
	}

	/** Fires #ON_THUMB_CLICKED event. */
	private function fireThumbClicked(Void):Void {
		dispatchEvent(createEventObj(ON_THUMB_CLICKED));
	}

	/** Fires #ON_THUMB_ROLL_OVER event. */
	private function fireThumbRollOver(Void):Void {
		dispatchEvent(createEventObj(ON_THUMB_ROLLOVER));
	}

	/** Fires #ON_THUMB_ROLL_OUT event. */
	private function fireThumbRollOut(Void):Void {
		dispatchEvent(createEventObj(ON_THUMB_ROLLOUT));
	}
	
	/** Handles org.aswing.Component#ON_CLICKED event. */
	private function __onThumbClick(Void):Void {
		fireThumbClicked();
	}

	/** Handles org.aswing.Component#ON_ROLLOVER event. */
	private function __onThumbRollOver(Void):Void {
		fireThumbRollOver();
	}

	/** Handles org.aswing.Component#ON_ROLLOUT event. */
	private function __onThumbRollOut(Void):Void {
		fireThumbRollOut();
	}
	
}