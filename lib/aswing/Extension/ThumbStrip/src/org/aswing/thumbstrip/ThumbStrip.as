/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.border.EmptyBorder;
import org.aswing.border.LineBorder;
import org.aswing.BorderLayout;
import org.aswing.Container;
import org.aswing.FocusManager;
import org.aswing.geom.Dimension;
import org.aswing.geom.Point;
import org.aswing.Insets;
import org.aswing.JPanel;
import org.aswing.JScrollBar;
import org.aswing.JScrollPane;
import org.aswing.JViewport;
import org.aswing.MouseManager;
import org.aswing.thumbstrip.Thumb;
import org.aswing.thumbstrip.ThumbStripContentLayout;
import org.aswing.thumbstrip.ThumbStripViewportLayout;
import org.aswing.util.Vector;
import org.aswing.thumbstrip.AbstractThumb;

/**
 * @author Igor Sadovskiy
 * @version 1.0
 */
class org.aswing.thumbstrip.ThumbStrip extends Container {
 
    /**
     * When selected thumb is changed.
     *<br>
     * onSelectionChanged(source:ThumbStrip)
     */ 
    public static var ON_SELECTION_CHANGED:String = "onSelectionChanged";

    /**
     * When user clicks the thumb
     *<br>
     * onThumbClicked(source:ThumbStrip, thumb:Thumb)
     */ 
    public static var ON_THUMB_CLICKED:String = "onThumbClicked";
 
 
    /** Thumb highlighted color. */
    public static var HIGHLIGHTED_COLOR:ASColor = ASColor.getASColor(0x90, 0x90, 0xB0, 100);
    /** Thumb selected color. */
    public static var SELECTED_COLOR:ASColor = ASColor.getASColor(0x80, 0x80, 0xC0, 100);
 
 
    /** Top position for the scroller. */
    public static var SCROLLBAR_TOP:String = BorderLayout.NORTH;
    /** Bottom position for the scroller. */
    public static var SCROLLBAR_BOTTOM:String = BorderLayout.SOUTH;
    /** Left position for the scroller. */
    public static var SCROLLBAR_LEFT:String = BorderLayout.WEST ;
    /** Right position for the scroller. */
    public static var SCROLLBAR_RIGHT:String = BorderLayout.EAST;
 
    /** Always show scroll bar mode. */
    public static var SCROLLBAR_ALWAYS:Number = JScrollPane.SCROLLBAR_ALWAYS;
    /** Show scroll bar only if needed mode. */
    public static var SCROLLBAR_AS_NEEDED:Number = JScrollPane.SCROLLBAR_AS_NEEDED;
    /** Never show scroll bar mode. */
    public static var SCROLLBAR_NEVER:Number = JScrollPane.SCROLLBAR_NEVER;

    /** Horizontal thumb strip display orientation. */
    public static var HORIZONTAL:Number = 0;
    /** Vertical thumb strip display orientation. */
    public static var VERTICAL:Number = 1;
    /** Miltiline thumb strip display orientation. */
    public static var BOTH:Number = 2;
 
 
    /** Default thumb preferred width. */
    public static var DEFAULT_THUMB_PREFERRED_WIDTH:Number = 80;
 
    /** Default thumb preferred height. */
    public static var DEFAULT_THUMB_PREFERRED_HEIGHT:Number = 80;
 
    /** Default scroll position. */
    public static var DEFAULT_SCROLLBAR_POSITION:String = SCROLLBAR_BOTTOM; 
 
    /** Default scroll bar show policy. */
    public static var DEFAULT_SCROLLBAR_POLICY:Number = SCROLLBAR_AS_NEEDED; 
 
    /** Default thumb strip display orientation. */
    public static var DEFAULT_ORIENTATION:Number = HORIZONTAL;
 
    
    private var scrollBar:JScrollBar;
    private var scrollPane:JViewport;
    private var scrollContent:JPanel;
 
    private var orientation:Number;
    private var scrollPosition:String;
    private var scrollShowPolicy:Number;
    
    private var enableHighlight:Boolean;
    private var scrollToSelection:Boolean;
    
    private var thumbs:Vector;
    private var selectedThumb:Thumb;
    private var highlightedThumb:Thumb;
    
    private var thumbPrefSize:Dimension;
    
    private var originalSelectedColor:ASColor;
    private var selectedColor:ASColor;
    private var originalHighlightedColor:ASColor;
    private var highlightedColor:ASColor;
    
    /**
     * Constructs <code>ThumbStrip</code> instance.
     * @param orientation thumb list orientation (vertical or horizontal)
     * @param scrollPosition the position of the scroll bar
     */
    public function ThumbStrip(orientation:Number, scrollPosition:String) {
        super();
        
        // init  
        scrollShowPolicy = DEFAULT_SCROLLBAR_POLICY;
        thumbs = new Vector();

        // create content pane 
        scrollContent = new JPanel();
        scrollContent.setBorder(new EmptyBorder(null, Insets.createIdentic(5)));

        // create scroll bar
        scrollBar = new JScrollBar();
        scrollBar.setUnitIncrement(50);
        scrollBar.addAdjustmentListener(__onStripScroll, this);

        // create scroll pane
        scrollPane = new JViewport(scrollContent);
        scrollPane.setVerticalAlignment(JViewport.TOP);
        scrollPane.setHorizontalAlignment(JViewport.LEFT);
        scrollPane.setLayout(new ThumbStripViewportLayout());

        // do layout
        setLayout(new BorderLayout());
        setBorder(new LineBorder(null, ASColor.BLACK));  
        append(scrollPane, BorderLayout.CENTER);
        
        setOrientation(orientation);  
        setScrollBarPosition(scrollPosition);
        
        // init thumb pref size
        thumbPrefSize = new Dimension();
        
        // init scroll to selection
        scrollToSelection = true;
        
        // init colors
        enableHighlight = true;
        selectedColor = SELECTED_COLOR;
        highlightedColor = HIGHLIGHTED_COLOR;
        
        // init event listeners
        MouseManager.addEventListener(MouseManager.ON_MOUSE_WHEEL, __onMouseScroll, this);
    }
    
    /**
     * Appneds new thumb to the end of the strip.
     * @param thumb the thumb to append
     */
    public function appendThumb(thumb:Thumb):Void {
    	insertThumb(-1, thumb);	
    }
    
    /**
     * Inserts the thumb to the specified position.
     * @param index the position to insert new thumb into. If the value is less than 
     * <code>0</code> appends the thumb to the end of the list
     * @param thumb the thumb to insert 
     */
    public function insertThumb(index:Number, thumb:Thumb):Void {
    	applyPreferredSizeToThumb(thumb, thumbPrefSize);
    	
		thumb.addEventListener(AbstractThumb.ON_THUMB_CLICKED, __onThumbClicked, this);
		thumb.addEventListener(AbstractThumb.ON_THUMB_ROLLOVER, __onThumbRollOver, this);
		thumb.addEventListener(AbstractThumb.ON_THUMB_ROLLOUT, __onThumbRollOut, this);
		
    	if (index == -1) {
    		thumbs.append(thumb);
    	} else {
    		thumbs.append(thumb, index);
    	}
    	scrollContent.insert(index, thumb.getPane());
    	
    	scrollContent.doLayout();
    }
    
    /**
     * Get the specified thumb from the strip by its index.
     * @param index the index of the thumb in the strip
     */
    public function getThumb(index:Number):Thumb {
    	return thumbs.get(index);	
    }
    
    /**
     * Sets highlight ebabled flag.
     * 
     * @param enableHighlight the new enabled highlight flag.
     */
    public function setHighlightEnabled(enableHighlight:Boolean):Void {
        this.enableHighlight = enableHighlight; 
        highlightedThumb.setBackground(originalHighlightedColor);
        highlightedThumb = null;
    }

    /**
     * Checks if highlight is enabled.
     * 
     * @return the enabled highlight flag.
     */
    public function isHighlightEnabled():Boolean {
        return enableHighlight; 
    }
    
    /**
     * Sets auto scroll to view selected thumb inside visible area flag.
     * 
     * @param scrollToSelection the auto scroll to selection flag.
     */
    public function setScrollToSelection(scrollToSelection:Boolean):Void {
        this.scrollToSelection = scrollToSelection;
        if (scrollToSelection) doScrollToSelection();
    }

    /**
     * Returns current auto scroll to selection flag.
     * 
     * @return the auto scroll flag value. 
     */
    public function isScrollToSelection(Void):Boolean {
        return scrollToSelection;
    }
    
    /**
     * setThumbPreferredSize(size:Dimension)<br>
     * setThumbPreferredSize(width:Number, height:Number)<br>
     * 
     * <p>Sets thumb preferred size.
     * 
     * @param size the new preferred <codew>Dimension</code> of the thumb.
     * @param width the new preferred width of the thumb
     * @param height the new preferred height of the thumb
     */
    public function setThumbPreferredSize():Void {
        if(arguments[0] == null){
             thumbPrefSize = new Dimension();
        }
        else if(arguments[1] != null){
            thumbPrefSize = new Dimension(arguments[0], arguments[1]);
        }
        else{
            thumbPrefSize = Dimension(arguments[0]).clone();
        }       
        
        // apply new size to thumbs
        applyPreferredSizeToAllThumbs(thumbPrefSize);
    }
    
    /**
     * Gets preferred size of the thumb.
     * 
     * @return the preferred <code>Dimension</code> of the thumb
     */
    public function getThumbPreferredSize(Void):Dimension {
        return thumbPrefSize;   
    }
    
    /**
     * Sets thumb preferred width.
     * 
     * @param width the new thumb preferred width.
     */
    public function setThumbPreferredWidth(width:Number):Void {
        setThumbPreferredSize(width, getThumbPreferredHeight());
    }

    /**
     * Sets thumb preferred height.
     * 
     * @param width the new thumb preferred height.
     */
    public function setThumbPreferredHeight(height:Number):Void {
        setThumbPreferredSize(getThumbPreferredWidth(), height);
    }

    /**
     * Returns current thumb preferred width.
     * 
     * @return current thumb preferred width.
     */
    public function getThumbPreferredWidth(Void):Number {
        return thumbPrefSize.width;
    }

    /**
     * Returns current thumb preferred height.
     * 
     * @return current thumb preferred height.
     */
    public function getThumbPreferredHeight(Void):Number {
        return thumbPrefSize.height;
    }
    
    /**
     * Calculates and applys preferred size to the specified <code>ImageThumb</code> component.
     */
    private function applyPreferredSizeToThumb(thumb:Thumb, prefSize:Dimension):Void {
        thumb.getPane().setPreferredSize(prefSize);
    }
    
    /** 
     * Calculates and applies preferred size to all thumbs. 
     */
    private function applyPreferredSizeToAllThumbs(prefSize:Dimension):Void {
        for (var i = 0; i < thumbs.getSize(); i++) {
            var thumb:Thumb = Thumb(thumbs.get(i));
            applyPreferredSizeToThumb(thumb, prefSize);
        }
        revalidate();
    }
    
    /**
     * Scrolls content to view selected thumb.
     */
    private function doScrollToSelection(Void):Void {
        var value:Number;
        if (orientation == HORIZONTAL) {
            // check for right edge
            if (selectedThumb.getPane().getLocation().x + selectedThumb.getPane().getWidth() > scrollPane.getViewPosition().x + scrollPane.getExtentSize().width) {
                if (selectedThumb.getPane().getWidth() < scrollPane.getExtentSize().width) {
                    value = selectedThumb.getPane().getLocation().x + selectedThumb.getPane().getWidth() - scrollPane.getExtentSize().width;
                } else {
                    value = selectedThumb.getPane().getLocation().x;
                }
            }
            // check for left edge
            else if (selectedThumb.getPane().getLocation().x < scrollPane.getViewPosition().x) {
                value = selectedThumb.getPane().getLocation().x;
            }
        } else if (orientation == VERTICAL) {
            // check for bottom edge
            if (selectedThumb.getPane().getLocation().y + selectedThumb.getPane().getHeight() > scrollPane.getViewPosition().y + scrollPane.getExtentSize().height) {
                if (selectedThumb.getPane().getHeight() < scrollPane.getExtentSize().height) {
                    value = selectedThumb.getPane().getLocation().y + selectedThumb.getPane().getHeight() - scrollPane.getExtentSize().height;
                } else {
                    value = selectedThumb.getPane().getLocation().y;
                }
            }
            // check for top edge
            else if (selectedThumb.getPane().getLocation().y < scrollPane.getViewPosition().y) {
                value = selectedThumb.getPane().getLocation().y;
            }
            
        } else {
            // TODO 
        }
        if (value != null) {
            scrollBar.setValue(value);
        }
    }
    
    /**
     * Sets position if the scroll bar relative to scrolled content.
     * 
     * @param newScrollPos the new position of the scroll bar
     * 
     * @see #SCROLLBAR_TOP
     * @see #SCROLLBAR_BOTTOM
     * @see #SCROLLBAR_LEFT 
     * @see #SCROLLBAR_RIGHT
     */
    public function setScrollBarPosition(newScrollPosition:String):Void {
    	if (newScrollPosition == null) newScrollPosition = DEFAULT_SCROLLBAR_POSITION;
        if (scrollPosition == newScrollPosition) return;
        scrollPosition = newScrollPosition;
  
        remove(scrollBar);
        
        // update orientation
        if (scrollPosition == SCROLLBAR_TOP || scrollPosition == SCROLLBAR_BOTTOM) {
            scrollBar.setOrientation(JScrollBar.HORIZONTAL);
        } else {
            scrollBar.setOrientation(JScrollBar.VERTICAL);
        }
  
        // update policy
        setScrollBarShowPolicy(scrollShowPolicy);
        
        // append back to the new location
        append(scrollBar, scrollPosition);
        
        // revalidate scrollbar
        revalidate();
    }
 
    /**
     * Returns current scroll bar position.
     * 
     * @return the scroll bar position
     * 
     * @see #SCROLLBAR_TOP 
     * @see #SCROLLBAR_BOTTOM
     * @see #SCROLLBAR_LEFT
     * @see #SCROLLBAR_RIGHT
     */
    public function getScrollBarPosition(Void):String {
        return scrollPosition; 
    }

    /**
     * Sets new scroll bar show policy.
     * 
     * @param newScrollShowPolicy the new show policy
     * 
     * @see #SCROLLBAR_ALWAYS
     * @see #SCROLLBAR_AS_NEEDED
     * @see #SCROLLBAR_NEVER
     */
    public function setScrollBarShowPolicy(newScrollShowPolicy:Number):Void {
        scrollShowPolicy = newScrollShowPolicy;
          
        if (scrollShowPolicy == SCROLLBAR_NEVER) {
            scrollBar.setVisible(false);
        } else if (scrollShowPolicy == SCROLLBAR_ALWAYS) {
            scrollBar.setVisible(true);
        } else {
            //TODO
        }
        
        revalidate();
    }
  
    /**
     * Returns current scroll bar show policy.
     * 
     * @return the current scroll bar policy.
     * 
     * @see #SCROLLBAR_ALWAYS
     * @see #SCROLLBAR_AS_NEEDED 
     * @see #SCROLLBAR_NEVER
     */
    public function getScrollBarShowPolicy(Void):Number {
        return scrollShowPolicy; 
    }
    
    /**
     * Sets new strip orientation.
     * 
     * @param newOrientation the strip orientation
     * 
     * @see #HORIZONTAL
     * @see #VERTICAL
     * @see #MULTILINE
     */
    public function setOrientation(newOrientation:Number):Void {
    	if (newOrientation == null) newOrientation = DEFAULT_ORIENTATION;
        if (orientation == newOrientation) return;
        
        orientation = newOrientation;
        
        var o:Object = scrollContent;
        o.isTracksViewportWidth = null;
        o.isTracksViewportHeight = null;
        
        if (orientation == HORIZONTAL) {
            o.isTracksViewportHeight = function(){return true;};
            scrollContent.setLayout(new ThumbStripContentLayout(ThumbStripContentLayout.X_AXIS));
        } else if (orientation == VERTICAL) {
            o.isTracksViewportWidth = function(){return true;};
            scrollContent.setLayout(new ThumbStripContentLayout(ThumbStripContentLayout.Y_AXIS));   
        } else {
            //TODO
            //scrollContent.setLayout(new FlowLayout());
        }
        
        revalidate();
    }
    
    /**
     * Returns current strip orientation.
     * 
     * @return the strip orientation.
     * 
     * @see #HORIZONTAL
     * @see #VERTICAL
     * @see #MULTILINE
     */
    public function getOrientation(Void):Number {
        return orientation; 
    }
    
    /** Configures scroll bar to scroll view content. */
    private function updateScrollBar(Void):Void {
        
        if (orientation == HORIZONTAL) {
        	var min:Number = 0;
        	var max:Number = scrollPane.getViewSize().width;
        	var value:Number = scrollBar.getValue();
        	var extent:Number = scrollPane.getExtentSize().width;
        	if (value < 0) value = 0;
        	if (value+extent > max) value = max-extent;
        	
        	scrollBar.getModel().setRangeProperties(value, extent, min, max);
            scrollBar.setEnabled(scrollPane.getViewSize().width > scrollPane.getExtentSize().width);
            scrollBar.setBlockIncrement(scrollPane.getExtentSize().width);
//          if (scrollShowPolicy == SCROLLBAR_AS_NEEDED) {
//              scrollBar.setVisible(scrollPane.getViewSize().width > scrollPane.getExtentSize().width);
//          } 
        } else if (orientation == VERTICAL) {
        	var min:Number = 0;
        	var max:Number = scrollPane.getViewSize().height;
        	var value:Number = scrollBar.getValue();
        	var extent:Number = scrollPane.getExtentSize().height;
        	if (value < 0) value = 0;
        	if (value+extent > max) value = max-extent;
        	
        	scrollBar.getModel().setRangeProperties(value, extent, min, max);
            scrollBar.setEnabled(scrollPane.getViewSize().height > scrollPane.getExtentSize().height);
            scrollBar.setBlockIncrement(scrollPane.getExtentSize().height);
//          if (scrollShowPolicy == SCROLLBAR_AS_NEEDED) {
//              scrollBar.setVisible(scrollPane.getViewSize().height > scrollPane.getExtentSize().height);
//          } 
        } else {
            //TODO  
        }
    }

    /**
     * layout this container
     */
    public function doLayout():Void {
        super.doLayout();
        
        // update scroll bars
        updateScrollBar();
    }

    /**
     * Sets new selected color.
     * 
     * @param color new selected color.
     */ 
    public function setSelectedColor(color:ASColor):Void {
        if (selectedColor != color) {
            selectedColor = color;
            selectedThumb.setBackground(color);
        }
    }

    /**
     * Gets current selected color.
     * 
     * @return selected color.
     */ 
    public function getSelectedColor(Void):ASColor {
        return selectedColor;
    }

    /**
     * Sets new highlighted color.
     * 
     * @param color new highlighted color.
     */ 
    public function setHighlightedColor(color:ASColor):Void {
        if (highlightedColor != color) {
            highlightedColor = color;
            if (highlightedThumb != selectedThumb) {
                highlightedThumb.setBackground(color);
            }
        }
    }

    /**
     * Gets current highlighted color.
     * 
     * @return highlighted color.
     */ 
    public function getHighlightedColor(Void):ASColor {
        return highlightedColor;
    }
    
    /**
     * Returns amount of the thumbs in the strip.
     * 
     * @return amount of the thumbs in the strip.
     */
    public function getThumbCount(Void):Number {
        return thumbs.getSize();   
    }
    
    /**
     * Sets new selected thumb by the specified <code>index</code>.
     * 
     * @param index the index of the thumb to select.
     */
    public function setSelectionIndex(index:Number):Void {
        var thumb:Thumb = Thumb(thumbs.get(index));
        if (thumb != selectedThumb) {
        	selectThumb(thumb);
        }
    }

    /**
     * Moves current selection index by specified amount of the positions.
     * If <code>step</code> value is positive moves selection forward; if
     * <code>step</code> value is negative moves selection backward. If new 
     * index is less than <code>0</code>, sets selection to the first image.
     * If new index is greater than total amount of images minus <code>1</code>, 
     * sets selection to the last image. 
     */
    public function moveSelectionIndexBy(step:Number):Void {
        var index:Number = getSelectionIndex() + step;
        if (index < 0) index = 0;
        if (index > getThumbCount()-1) index = getThumbCount() - 1;
        setSelectionIndex(index);
    }

    /**
     * Returns current selection index or <code>-1</code> if no selected image.
     * 
     * @return the selected image index.
     */
    public function getSelectionIndex(Void):Number {
        return thumbs.indexOf(selectedThumb);
    }
    
    /**
     * Selects first image from the list.
     */
    public function selectFirst(Void):Void {
        setSelectionIndex(0);   
    }

    /**
     * Selects last image from the list.
     */
    public function selectLast(Void):Void {
        setSelectionIndex(getThumbCount()-1);   
    }
    
    /** Selects specified thumb. */
    private function selectThumb(thumb:Thumb):Void {
	    selectedThumb.setBackground(originalSelectedColor);
        originalSelectedColor = (thumb != highlightedThumb) ? thumb.getBackground() : originalHighlightedColor;
        selectedThumb = thumb;
        selectedThumb.setBackground(selectedColor);
        if (scrollToSelection) doScrollToSelection();
        fireActionEvent();
        fireSelectionChangedEvent(getSelectionIndex());
    }
    
    /**
     * addActionListener(fuc:Function, obj:Object)<br>
     * addActionListener(fuc:Function)<br>
     * 
     * Adds a action listener to this <code>ThumbStrip</code>. 
     * <code>ImageThumbStrip</code> fires an action event when user 
     * selects new image from the thumb strip.
     * 
     * @param fuc the listener function.
     * @param obj which context to run in by the func.
     * @return the listener just added.
     * 
     * @see #ON_SELECTION_CHANGED
     * @see EventDispatcher#ON_ACT
     */
    public function addActionListener(fuc:Function, obj:Object):Object{
        return addEventListener(ON_ACT, fuc, obj);
    }   
    
    /**
     * Fires selection changed event.
     */ 
    private function fireSelectionChangedEvent(index:Number):Void {
        dispatchEvent(createEventObj(ON_SELECTION_CHANGED, index));
    }

    /**
     * Fires thumb clicked event.
     */ 
    private function fireThumbClickedEvent(thumb:Thumb):Void {
        dispatchEvent(createEventObj(ON_THUMB_CLICKED, thumb));
    }
    
    /** Handles thumb click event. */
    private function __onThumbClicked(thumb:Thumb):Void {
    	if (thumb != selectedThumb) {
    		fireThumbClickedEvent(thumb);
	        selectThumb(thumb);
    	}
    }
    
    /** Handles mouse scroll wheel scroll event. */
    private function __onMouseScroll(mouseManager:Function, delta:Number, target:MovieClip):Void {
        if (hitTestMouse() && FocusManager.getCurrentManager().getFocusOwner() != scrollBar) {
            scrollBar.setValue(scrollBar.getValue() - delta*scrollBar.getUnitIncrement());  
        }
    }
    
    /** Handles thumb strip scroll event. */
    private function __onStripScroll(Void):Void {
        if (orientation == HORIZONTAL) {
            scrollPane.setViewPosition(new Point(scrollBar.getValue(), 0));
        } else {
            scrollPane.setViewPosition(new Point(0, scrollBar.getValue()));
        }
    }
    
    /** Handles thumb roll over event. */
    private function __onThumbRollOver(thumb:Thumb):Void {
        if (enableHighlight) {
            if (thumb != selectedThumb) {
                originalHighlightedColor = thumb.getBackground();
                highlightedThumb = thumb;
                highlightedThumb.setBackground(highlightedColor);
            }
        }
    }

    /** Handles thumb roll out event. */
    private function __onThumbRollOut(thumb:Thumb):Void {
        if (enableHighlight) {
            if (thumb != selectedThumb) {
                thumb.setBackground(originalHighlightedColor);
                highlightedThumb = null;
            }
        }   
    }

}

