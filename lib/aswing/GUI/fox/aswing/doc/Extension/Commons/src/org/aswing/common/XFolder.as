/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.ASFont;
import org.aswing.ASWingConstants;
import org.aswing.BorderLayout;
import org.aswing.ButtonGroup;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.JPanel;
import org.aswing.JToggleButton;

/**
 * A panel with a title bar, click the title bar can collapse or expand the panel content.
 * @author iiley
 * @version 1.0 2006.7.11
 */
class org.aswing.common.XFolder extends Container {
	
	public static var TOP:Number = ASWingConstants.TOP;
	public static var BOTTOM:Number = ASWingConstants.BOTTOM;
	
	private var titleButton:JToggleButton;
	private var contentPane:Container;
	private var title:String;
	private var titlePosition:Number;
	
	/**
	 * When the folder expanded or collapsed.<br>
	 * onStateChanged(source:XFolder)
	 * @see #isExpanded()
	 */
	public static var ON_STATE_CHANGED:String = Component.ON_STATE_CHANGED;
	
	/**
	 * XFolder(title:String, titlePosition:Number, gap:Number)<br>
	 * XFolder(title:String, titlePosition:Number) default gap to 4<br>
	 * XFolder(title:String) default titlePosition to TOP<br>
	 * XFolder() default title to ""
	 */
	public function XFolder(title:String, titlePosition:Number, gap:Number) {
		super();
		if(title == undefined) title = "";
		if(titlePosition == undefined) titlePosition = TOP;
		if(gap == undefined) gap = 4;
		
		this.title = title;
		this.titlePosition = titlePosition;
		setLayout(new BorderLayout(0, gap));
		titleButton = new JToggleButton();
		titleButton.setSelected(false);
		setForeground(new ASColor(0x336600));
		setFocusable(false);
		
		titleButton.addSelectionListener(__titleSelectionChanged, this);
		initTitleBar();
		changeTitleRepresentWhenStateChanged();
	}
	
	/**
	 * Override this method to init different LAF title bar
	 */
	private function initTitleBar():Void{
		setFont(new ASFont("Dialog", 12, true));
		titleButton.setHorizontalAlignment(JToggleButton.LEFT);
		if(titlePosition == BOTTOM){
			append(titleButton, BorderLayout.SOUTH);
		}else{
			append(titleButton, BorderLayout.NORTH);
		}
	}
	
	/**
	 * Override this method to control the title representation.
	 */
	private function changeTitleRepresentWhenStateChanged():Void{
		if(isExpanded()){
			titleButton.setText("- " + getTitle());
		}else{
			titleButton.setText("+ " + getTitle());
		}
	}
	
	private function __titleSelectionChanged():Void{
		getContentPane().setVisible(titleButton.isSelected());
		changeTitleRepresentWhenStateChanged();
		fireStateChanged();
		revalidate();
	}
	
	/**
	 * Adds listener to listen the expand or collapse state change event.
	 */
	public function addChangeListener(func:Function, obj:Object):Object{
		return addEventListener(ON_STATE_CHANGED, func, obj);
	}
	
	/**
	 * Sets the folder font, title font will keep same to this
	 */
	public function setFont(f:ASFont):Void{
		super.setFont(f);
		titleButton.setFont(f);
	}
		
	public function setTitleForeground(c:ASColor):Void{
		titleButton.setForeground(c);
	}
	public function getTitleForeground():ASColor{
		return titleButton.getForeground();
	}
	
	public function setTitleBackground(c:ASColor):Void{
		titleButton.setBackground(c);
	}
	public function getTitleBackground():ASColor{
		return titleButton.getBackground();
	}
	
	public function setTitleToolTipText(t:String):Void{
		titleButton.setToolTipText(t);
	}
	public function getTitleToolTipText():String{
		return titleButton.getToolTipText();
	}
	
	/**
	 * Returns whether the folder is expanded or not.
	 */
	public function isExpanded():Boolean{
		return titleButton.isSelected();
	}
	
	/**
	 * Sets whether to expand the folder or not.
	 */
	public function setExpanded(b:Boolean):Void{
		titleButton.setSelected(b);
	}
	
	/**
	 * Sets the title
	 */
	public function setTitle(t:String):Void{
		if(t != title){
			title = t;
		}
	}
	
	/**
	 * Returns the title
	 */
	public function getTitle():String{
		return title;
	}
	
	/**
	 * Returns the content pane
	 */
	public function getContentPane():Container{
		if(contentPane == null){
			contentPane = new JPanel();
			contentPane.setVisible(isExpanded());
			append(contentPane, BorderLayout.CENTER);
		}
		return contentPane;
	}
	
	/**
	 * Sets the content pane
	 * @param p the content pane
	 */
	public function setContentPane(p:Container):Void{
		if(contentPane != p){
			remove(contentPane);
			contentPane = p;
			contentPane.setVisible(isExpanded());
			append(contentPane, BorderLayout.CENTER);
		}
	}
	
	/**
	 * Adds this folder to a group, to achieve one time there just can be one or less folder are expanded.
	 * @param group the group to add in.
	 */
	public function addToGroup(group:ButtonGroup):Void{
		if(!group.contains(titleButton)){
			group.append(titleButton);
		}
	}
	
	/**
	 * Removes this folder from a group.
	 * @see #addToGroup()
	 */
	public function removeFromGroup(group:ButtonGroup):Void{
		group.remove(titleButton);
	}
}