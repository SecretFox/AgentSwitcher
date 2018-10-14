/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASFont;
import org.aswing.ASTextFormat;
import org.aswing.geom.Dimension;
import org.aswing.JScrollPane;
import org.aswing.JTextArea;
import org.aswing.RepaintManager;
import org.aswing.richtext.RichTextEditorToolBar;
import org.aswing.util.ArrayUtils;
import org.aswing.util.Delegate;

/**
 * RichTextArea is different from JTextArea, RichTextArea can accept different text formats for 
 * any range of text, but JTextArea can't.
 * <p>
 * RichTextArea can be connected to a <code>RichTextEditorToolBar</code>, then it can be modify formats 
 * from that toolbar.
 * 
 * @see RichTextEditorToolBar
 * @see RichTextEditor
 * @author iiley
 */
class org.aswing.richtext.RichTextArea extends JTextArea {
	
	private var htmlText:String;
	private var tracksWidth:Boolean;
	private var toolBars:Array;
	
	/**
	 * RichTextArea(text:String, rows:Number, columns:Number)<br>
	 * RichTextArea(text:String, rows:Number) columns default to 0<br> 
	 * RichTextArea(text:String) rows and columns default to 0<br>
	 * RichTextArea() text default to "", rows and columns default to 0<br>
	 * <p>
	 * @see #setRows()
	 * @see #setColumns()
	 */
	public function RichTextArea(text : String, rows : Number, columns : Number) {
		super(text, rows, columns);
		setName("XUBBTextArea");
		htmlText = "";
		setWordWrap(true);
		tracksWidth = true;
		setHtml(true);
	}
		
	/**
	 * Adds this text area connected to the specified toolBar
	 */
	public function addConnectionToEditorToolBar(toolBar:RichTextEditorToolBar):Void{
		if(toolBars == null){
			toolBars = new Array();
		}
		ArrayUtils.removeFromArray(toolBars, toolBar);
		toolBars.push(toolBar);
		if(isDisplayable()){
			toolBar.registerTextField(getTextField());
		}
	}
	
	/**
	 * Removes this text area from the specified toolBar's control.
	 */
	public function removeConnectionFromEditorToolBar(toolBar:RichTextEditorToolBar):Void{
		if(toolBars == null){
			toolBars = new Array();
		}
		ArrayUtils.removeFromArray(toolBars, toolBar);
		if(isDisplayable()){
			toolBar.unregisterTextField(getTextField());
		}
	}
	
	/**
	 * Sets true to make the text area tracks width, it is mean the text area will count the 
	 * preffered size base on its current size, it will not count self width, but base on it to 
	 * count the height.<br>
	 * Sets false to make it performance as normal text area
	 * @param b tracksWidth
	 */
	public function setTracksWidth(b:Boolean):Void{
		if(b != tracksWidth){
			invalidateTextFieldAutoSizeToCountPrefferedSize();
			tracksWidth = b;
			revalidate();
		}
	}
	
	/**
	 * Returns whether tracksWidth
	 * @return whether tracksWidth
	 * @see #setTracksWidth()
	 */
	public function isTracksWidth():Boolean{
		return tracksWidth;
	}
	
	/**
	 * Set the text of this text field.(for html text see {@link #setHtmlText})
	 * @param t the text of this text field, if it is null or undefined, it will be set to "";
	 * @see #setHtmlText()
	 */
	public function setText(t:String):Void{
		if(t == null) t = "";
		retrieveTextFromTextField();
		if(t != text){
			text = t;
			invalidateTextFieldAutoSizeToCountPrefferedSize();
			if(getTextField()!= null){
				getTextField().text = text;
			}else{
				repaint();
				dispatchEvent(ON_TEXT_CHANGED, createEventObj(ON_TEXT_CHANGED));
			}
			if(isAutoSize()){
				revalidate();
			}
		}
	}	
	
	/**
	 * Set the html text of this text field.
	 * @param t the text of this text field, if it is null or undefined, it will be set to "";
	 * @see #getHtmlText()
	 */	
	public function setHtmlText(t:String):Void{
		if(t == null) t = "";
		retrieveTextFromTextField();
		if(t != htmlText){
			htmlText = t;
			if(isDisplayable()){
				applyPropertiesToText(getTextField(), false);
				applyBoundsToText(getTextField(), getPaintBounds());
	    		applyHtmlText(getTextField());
			}
			invalidateTextFieldAutoSizeToCountPrefferedSize();
			revalidate();
			repaint();
		}
	}
	
	/**
	 * Returns the html text if the html property is true, otherwise return the text.
	 * @return the html text
	 * @see #setHtmlText()
	 */
	public function getHtmlText():String{
		if(isDisplayable()){
			retrieveTextFromTextField();
		}
		if(isHtml()){
			return htmlText;
		}else{
			return text;
		}
	}
	
	public function replaceSel(newText:String):Void{
		getTextField().replaceSel(newText);
		retrieveTextFromTextField();
	}
	
	public function replaceText(beginIndex:Number, endIndex:Number, newText:String):Void{
		getTextField().replaceText(beginIndex, endIndex, newText);
		retrieveTextFromTextField();
	}
			
	/**
	 * setTextFormatFor(tf:ASTextFormat, beginIndex:Number, endIndex:Number)<br>
	 * setTextFormatFor(tf:ASTextFormat, index:Number)<br>
	 * setTextFormatFor(tf:ASTextFormat)<br>
	 * Sets text format to specifield range. 
	 * This method will only take effect when this component is displayable. 
	 * @see TextField#setTextFormat()
	 */
	public function setTextFormatFor(tf:ASTextFormat, beginIndex:Number, endIndex:Number):Void{
		var tft:TextFormat = ASTextFormat.getTextFormatWithASTextFormat(tf);
		if(endIndex != undefined){
			getTextField().setTextFormat(beginIndex, endIndex, tft);
		}else if(beginIndex != undefined){
			getTextField().setTextFormat(beginIndex, tft);
		}else{
			getTextField().setTextFormat(tft);
		}
	}
	
	/**
	 * getTextFormatFor(beginIndex:Number, endIndex:Number)<br>
	 * getTextFormatFor(index:Number)<br>
	 * getTextFormatFor()<br>
	 * Returns the textformat for the specified range. 
	 * null will be returned is the component is not displayable.
	 * @see TextField#getTextFormat()
	 */
	public function getTextFormatFor(beginIndex:Number, endIndex:Number):ASTextFormat{
		var tf:TextFormat = getTextField().getTextFormat(beginIndex, endIndex);
		if(tf != null){
			return ASTextFormat.getASTextFormatWithTextFormat(tf);
		}else{
			return null;
		}
	}
	
	/**
	 * Sets text format for new texts.
	 * This method will only take effect when this component is displayable. 
	 * @see TextField#setNewTextFormat()
	 */
	public function setNewTextFormat(ntf:ASTextFormat):Void{
		getTextField().setNewTextFormat(ASTextFormat.getTextFormatWithASTextFormat(ntf));
	}
	
	/**
	 * Returns the text format for new texts.
	 * null will be returned is the component is not displayable.
	 * @see TextField#getNewTextFormat()
	 */
	public function getNewTextFormat():ASTextFormat{
		var tf:TextFormat = getTextField().getNewTextFormat();
		if(tf != null){
			return ASTextFormat.getASTextFormatWithTextFormat(tf);
		}else{
			return null;
		}
	}
	
	/**
	 * Do nothing
	 */
	public function setFont(f:ASFont):Void{
	}
	
	/**
	 * Sets the css <code>StyleSheet</code> to the text.
	 * @param css the css <code>StyleSheet</code> to use
	 */
	public function setCSS(css:TextField.StyleSheet):Void {
		super.setCSS(css);
		if(isHtml() && isDisplayable()){
			applyHtmlText(getTextField());
		}
	}
	
	public function destroy():Void{
		retrieveTextFromTextField();
		super.destroy();
	}
	
	//------------------------------------------------------------------------------------
	
//	private function __onFocusGainedExtraFix():Void{
//		//do nothing
//	}
//	
//    private function __uiTextSetFocus(oldFocus:Object):Void{
//    	if(!isFocusOwner()){
//    		requestFocus();
//    	}
//    }
//    
//    private function __uiTextKilledFocus(newFocus:Object):Void{
//    	//do nothing
//    }	
    
	//------------------------------------------------------------------------------------

	private function retrieveTextFromTextField():Void{
		if(isDisplayable()){
	    	if(isHtml()){
	    		htmlText = getTextField().htmlText;
	    	}
	    	text = getTextField().text;
		}
	}	
	
    private function create():Void{
    	super.create();
    	applyHtmlText(textField);
    	//trace("/d/ create");
    	for(var i:Number=0; i<toolBars.length; i++){
    		var toolBar:RichTextEditorToolBar = RichTextEditorToolBar(toolBars[i]);
    		toolBar.registerTextField(textField);
    	}
    }
	
	private var lastSizedWidth:Number;
	
	private function size():Void{
		repaint();
		invalidate();
		
    	//trace("/d/ size");
		if(getTextField() != null){
			//trace("/d/XUBBTextArea  Sized!! = " + getSize());
			applyPropertiesToText(getTextField(), false);
			applyBoundsToText(getTextField(), getPaintBounds());
	    	//call this first to validate current textfield scroll properties
	    	var t:TextField = getTextField();
	    	if(isAutoAdjustHeight() && (lastSizedWidth != getWidth()) && !viewportSizeTesting){
				lastSizedWidth = getWidth();
	    		RepaintManager.getInstance().addCallAfterNextPaintTime(Delegate.create(this, __autoAdjustHeight));
	    	}else if(viewportSizeTesting){
	    		var tt:String = t.htmlText;
	    		t.htmlText = "";
	    		t.htmlText = tt;
	    	}
			t.background = false;
		}
	}
	
	private function __autoAdjustHeight():Void{
		invalidateTextFieldAutoSizeToCountPrefferedSize();
		revalidate();
	}
	
    private function applyPropertiesToText(t:TextField, autoSize:Boolean):Void{
    	applyPropertiesToTextExceptTextAndFormat(t, autoSize);
    }
    
    private function applyHtmlText(t:TextField):Void{
		t.styleSheet = getCSS();
		t.setNewTextFormat(new TextFormat());
    	t.htmlText = htmlText;
    }
    
    private function isAutoAdjustHeight():Boolean{
    	return isWordWrap() && getRows() <= 0 && tracksWidth;
    }
	
	private function countPreferredSize():Dimension{
		var size:Dimension;
		if(columns > 0 && rows > 0){
			var width:Number = getColumnWidth() * columns + getWidthMargin();
			var height:Number = getRowHeight() * rows + getHeightMargin();
			size = new Dimension(width, height);
		}else if(rows <=0 && columns <=0 ){
			size = getTextFieldAutoSizedSize();
		}else if(rows > 0){ // columns must <= 0
			size = getTextFieldAutoSizedSize();
			size.height = getRowHeight() * rows + getHeightMargin();
		}else{ //must be columns > 0 and rows <= 0
			size = getTextFieldAutoSizedSize();
		}
		return getInsets().getOutsideSize(size);
	}
		
	private function countAutoSizedSize():Void{
		var t:TextField = creater.createTF(_root, "tempText");
		applyPropertiesToText(t, true);
		applyHtmlText(t);
		autoSizedSize = new Dimension(t._width, t._height);
		t.removeTextField();
		delete _root[t._name];
	}	
}