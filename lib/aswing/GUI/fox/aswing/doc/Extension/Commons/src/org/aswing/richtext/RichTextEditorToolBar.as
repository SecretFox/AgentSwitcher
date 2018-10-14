/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASColor;
import org.aswing.ASFont;
import org.aswing.ASWingConstants;
import org.aswing.ButtonGroup;
import org.aswing.colorchooser.VerticalLayout;
import org.aswing.common.SimpleColorChooser;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.Insets;
import org.aswing.JButton;
import org.aswing.JComboBox;
import org.aswing.JOptionPane;
import org.aswing.JSeparator;
import org.aswing.JToggleButton;
import org.aswing.richtext.HorizontalLayout;
import org.aswing.richtext.icon.CenterAlignIcon;
import org.aswing.richtext.icon.ColorIcon;
import org.aswing.richtext.icon.JustifyAlignIcon;
import org.aswing.richtext.icon.LeftAlignIcon;
import org.aswing.richtext.icon.RightAlignIcon;
import org.aswing.SoftBoxLayout;
import org.aswing.util.Delegate;
import org.aswing.util.HashMap;
import org.aswing.util.Vector;

/**
 * RichTextEditorToolBar is a tool bar contains many tools to edit the text format for 
 * a textfield.
 * 
 * @author iiley
 */
class org.aswing.richtext.RichTextEditorToolBar extends Container {

    /** 
     * Horizontal orientation.
     */
    public static var HORIZONTAL:Number = ASWingConstants.HORIZONTAL;
    /** 
     * Vertical orientation.
     */
    public static var VERTICAL:Number   = ASWingConstants.VERTICAL;
	
	private var orientation:Number;
	private var selectionListener:Object;
	private var editingTextField:TextField;
	private var selectionBeginIndex:Number;
	private var selectionEndIndex:Number;
	private var registeredTFs:Vector;
	private var newTextFormats:HashMap;
	
	private var bButton:JToggleButton;
	private var iButton:JToggleButton;
	private var uButton:JToggleButton;
	
	private var leftAlignButton:JToggleButton;
	private var centerAlignButton:JToggleButton;
	private var rightAlignButton:JToggleButton;
	private var justifyAlignButton:JToggleButton;
	
	private var fontBox:JComboBox;
	private var sizeBox:JComboBox;
	private var colorButton:JButton;
	private var urlButton:JToggleButton;
	
	private var colorIcon:ColorIcon;
	
	private var updateingToolsStates:Boolean;
	
	private var hyperLinkInputTitle:String;
	private var hyperLinkInputMsg:String;
	
	public function RichTextEditorToolBar() {
		super();
		selectionBeginIndex = 0;
		selectionEndIndex = 0;
		updateingToolsStates = false;
		registeredTFs = new Vector();
		newTextFormats = new HashMap();
		
		initComponents();
		initHandlers();
	}
	
	private function initComponents():Void{
		//creating ...
		bButton = new JToggleButton(" B ");
		bButton.setFont(new ASFont(bButton.getFont().getName(), bButton.getFont().getSize(), true));
		iButton = new JToggleButton(" I ");
		iButton.setFont(new ASFont(iButton.getFont().getName(), iButton.getFont().getSize(), false, true));
		//iButton.setPreferredWidth(bButton.getPreferredWidth());
		uButton = new JToggleButton(" U ");
		uButton.setFont(new ASFont(uButton.getFont().getName(), uButton.getFont().getSize(), false, false, true));
		//uButton.setPreferredWidth(bButton.getPreferredWidth());
		
		leftAlignButton = new JToggleButton(new LeftAlignIcon());
		centerAlignButton = new JToggleButton(new CenterAlignIcon());
		rightAlignButton = new JToggleButton(new RightAlignIcon());
		justifyAlignButton = new JToggleButton(new JustifyAlignIcon());
		
		fontBox = new JComboBox(TextField.getFontList());
		fontBox.setPreferredWidth(110);
		sizeBox = new JComboBox([8,9,10,11,12,14,16,18,20,22,24,28,32,40,64]);
		colorIcon = new ColorIcon();
		colorButton = new JButton(colorIcon);
		urlButton = new JToggleButton("e");
		urlButton.setMargin(new Insets(0, 0, 0, 0));
		urlButton.setFont(new ASFont("Arial", 18, true));
		//urlButton.setPreferredSize(bButton.getPreferredSize());
		
		//layouting ...
		append(bButton);
		append(iButton);
		append(uButton);
		append(new JSeparator(JSeparator.VERTICAL));
		
		var buttonGroup:ButtonGroup = new ButtonGroup();
		buttonGroup.append(leftAlignButton);
		buttonGroup.append(centerAlignButton);
		buttonGroup.append(rightAlignButton);
		buttonGroup.append(justifyAlignButton);
		append(leftAlignButton);
		append(centerAlignButton);
		append(rightAlignButton);
		append(justifyAlignButton);
		append(new JSeparator(JSeparator.VERTICAL));
		
		append(fontBox);
		append(sizeBox);
		append(colorButton);
		append(urlButton);
		
		setOrientation(HORIZONTAL);
	}

	private function initHandlers() : Void {
		selectionListener = {onSetFocus : Delegate.create(this, __onFocusChanged)};
		Selection.addListener(selectionListener);
		
		Key.addListener({onKeyUp:Delegate.create(this, __onSelectionMaybeChanged)});
		Mouse.addListener({onMouseUp:Delegate.create(this, __onSelectionMaybeChanged)});
		
		bButton.addActionListener(__boldAction, this);
		iButton.addActionListener(__italicAction, this);
		uButton.addActionListener(__underlineAction, this);
		
		leftAlignButton.addActionListener(__alginAction, this);
		centerAlignButton.addActionListener(__alginAction, this);
		rightAlignButton.addActionListener(__alginAction, this);
		justifyAlignButton.addActionListener(__alginAction, this);
		
		fontBox.addActionListener(__fontAction, this);
		sizeBox.addActionListener(__sizeAction, this);
		colorButton.addEventListener(JButton.ON_RELEASE, __colorAction, this);
		urlButton.addActionListener(__urlAction, this);
				
		setToolsEnabled(false);
	}
	
	public function getOrientation():Number{
		return orientation;
	}
		
	public function setOrientation(orient:Number):Void{
		if(orient != orientation){
			orientation = orient;
			if(orientation == HORIZONTAL){
				setLayout(new HorizontalLayout(HorizontalLayout.CENTER, 2));
				var height:Number = getPreferredHeight();
				for(var i:Number=0; i<getComponentCount(); i++){
					var child:Component = getComponent(i);
					if(child instanceof JSeparator){
						var sep:JSeparator = JSeparator(child);
						sep.setOrientation(JSeparator.VERTICAL);
						sep.setPreferredSize(2, height);
					}
				}
			}else{
				setLayout(new VerticalLayout(VerticalLayout.CENTER, 2));
				var width:Number = getPreferredWidth();
				for(var i:Number=0; i<getComponentCount(); i++){
					var child:Component = getComponent(i);
					if(child instanceof JSeparator){
						var sep:JSeparator = JSeparator(child);
						sep.setOrientation(JSeparator.HORIZONTAL);
						sep.setPreferredSize(width, 2);
					}
				}
			}
		}
	}
	
	public function registerTextField(tf:TextField):Void{
		registeredTFs.remove(tf);
		registeredTFs.append(tf);
		tf.removeListener(this);
		tf.addListener(this);
	}
	
	public function unregisterTextField(tf:TextField):Void{
		registeredTFs.remove(tf);
		tf.removeListener(this);
		newTextFormats.remove(tf);
	}
		
	public function getSelectionTextFormat():TextFormat{
		if(editingTextField == null){
			return null;
		}else{
			var tft:TextFormat = null;
			if(isCaretPositedNewTextFormat()){
				tft = editingTextField.getNewTextFormat();
			}else if(selectionBeginIndex < selectionEndIndex){
				tft = editingTextField.getTextFormat(selectionBeginIndex, selectionEndIndex);
			}else{
				tft = editingTextField.getTextFormat(selectionBeginIndex);
			}
			return tft;
		}
	}
	
	public function isSameBeginEndSelection():Boolean{
		return selectionBeginIndex == selectionEndIndex;
	}
	

	public function getBButton():JToggleButton {
		return bButton;
	}

	public function getJustifyAlignButton():JToggleButton {
		return justifyAlignButton;
	}

	public function getColorButton():JButton {
		return colorButton;
	}

	public function getCenterAlignButton():JToggleButton {
		return centerAlignButton;
	}

	public function getUrlButton():JToggleButton {
		return urlButton;
	}

	public function getRightAlignButton():JToggleButton {
		return rightAlignButton;
	}

	public function getFontBox():JComboBox {
		return fontBox;
	}
	
	public function getSizeBox():JComboBox{
		return sizeBox;
	}

	public function getLeftAlignButton():JToggleButton {
		return leftAlignButton;
	}

	public function getIButton():JToggleButton {
		return iButton;
	}

	public function getUButton():JToggleButton {
		return uButton;
	}	
	
	private function updateToolsStatesFromTextField():Void{
		if(editingTextField == null){
			setToolsEnabled(false);
		}else{
			var tft:TextFormat = getSelectionTextFormat();
			if(tft != null){
				setToolsStatesWithTextFormat(tft);
				setToolsEnabled(!isSameBeginEndSelection() || isCaretPositedNewTextFormat());
			}else{
				setToolsEnabled(false);
			}
		}
	}
	
	private function isCaretPositedNewTextFormat():Boolean{
		if(editingTextField != null){
			return (selectionBeginIndex == selectionEndIndex) && (selectionBeginIndex == editingTextField.length);
		}
		return false;
	}
	
	private function appleyTextFormatToSelection(tft:TextFormat):Void{
		if(editingTextField != null){
			if(isCaretPositedNewTextFormat()){
				var oldTextFormat:TextFormat = newTextFormats.get(editingTextField);
				if(oldTextFormat == null){
					oldTextFormat = new TextFormat();
					newTextFormats.put(editingTextField, oldTextFormat);
				}
				for(var i:String in tft){
					if(tft[i] == null){
						tft[i] = oldTextFormat[i];
					}else if(tft[i] != null){
						oldTextFormat[i] = tft[i];
					}
				}
				editingTextField.setNewTextFormat(tft);
			}else{
				editingTextField.setTextFormat(selectionBeginIndex, selectionEndIndex, tft);
			}
		}
	}
	
	private function setToolsStatesWithTextFormat(tft:TextFormat):Void{
		updateingToolsStates = true;
		bButton.setSelected(tft.bold);
		iButton.setSelected(tft.italic);
		uButton.setSelected(tft.underline);
		if(tft.align == "right"){
			rightAlignButton.setSelected(true);
		}else if(tft.align == "center"){
			centerAlignButton.setSelected(true);
		}else if(tft.align == "justify"){
			justifyAlignButton.setSelected(true);
		}else{
			leftAlignButton.setSelected(true);
		}
		fontBox.setSelectedItem(tft.font);
		sizeBox.setSelectedItem(tft.size);
		colorIcon.setColor(new ASColor(tft.color));
		colorButton.repaint();
		if(tft.url != null && tft.url != ""){
			urlButton.setSelected(true);
		}else{
			urlButton.setSelected(false);
		}
		updateingToolsStates = false;
	}
	
	private function setToolsEnabled(b:Boolean):Void{
		for(var i:Number=0; i<getComponentCount(); i++){
			getComponent(i).setEnabled(b);
		}
	}
	
	private function restoreFocusAndSelection():Void{
		var txt:TextField = TextField(eval(Selection.getFocus()));
		if(editingTextField != null && txt != editingTextField){
			Selection.setFocus(editingTextField);
			Selection.setSelection(selectionBeginIndex, selectionEndIndex);
		}
	}
	
	private function __onFocusChanged(oldFocus:Object, newFocus:Object) : Void {
		var newTF:TextField = TextField(newFocus);
		if(newTF != null){
			if(registeredTFs.contains(newTF)){
				editingTextField = newTF;
			}
		}
	}

	private function __onSelectionMaybeChanged() : Void {
		var txt:TextField = TextField(eval(Selection.getFocus()));
		if(txt == editingTextField && txt != null){
			selectionBeginIndex = Selection.getBeginIndex();
			selectionEndIndex   = Selection.getEndIndex();
			updateToolsStatesFromTextField();
		}
	}
	
	private function __boldAction() : Void {
		restoreFocusAndSelection();
		var tft:TextFormat = new TextFormat();
		tft.bold = bButton.isSelected();
		appleyTextFormatToSelection(tft);
	}

	private function __italicAction() : Void {
		restoreFocusAndSelection();
		var tft:TextFormat = new TextFormat();
		tft.italic = iButton.isSelected();
		appleyTextFormatToSelection(tft);
	}

	private function __underlineAction() : Void {
		restoreFocusAndSelection();
		var tft:TextFormat = new TextFormat();
		tft.underline = uButton.isSelected();
		appleyTextFormatToSelection(tft);
	}
	
	private function __alginAction() : Void {
		restoreFocusAndSelection();
		var tft:TextFormat = new TextFormat();
		if(justifyAlignButton.isSelected()){
			tft.align = "justify";
		}else if(centerAlignButton.isSelected()){
			tft.align = "center";
		}else if(rightAlignButton.isSelected()){
			tft.align = "right";
		}else if(leftAlignButton.isSelected()){
			tft.align = "left";
		}
		appleyTextFormatToSelection(tft);
	}

	private function __fontAction() : Void {
		if(!updateingToolsStates){
			restoreFocusAndSelection();
			var tft:TextFormat = new TextFormat();
			tft.font = fontBox.getSelectedItem().toString();
			appleyTextFormatToSelection(tft);
		}
	}

	private function __sizeAction() : Void {
		if(!updateingToolsStates){
			restoreFocusAndSelection();
			var tft:TextFormat = new TextFormat();
			var size:Number = parseInt(sizeBox.getSelectedItem().toString());
			if(!isNaN(size)){
				tft.size = size;
				appleyTextFormatToSelection(tft);
			}
		}
	}

	private function __colorAction() : Void {
		SimpleColorChooser.showChooser(
			colorButton.getGlobalLocation(), 
			colorIcon.getColor(), 
			Delegate.create(this, __colorSelected), 
			true, 
			false);
	}

	private function __colorSelected(c:ASColor) : Void {
		colorButton.requestFocus();
		restoreFocusAndSelection();
		if(c != null){
			var tft:TextFormat = new TextFormat();
			tft.color = c.getRGB();
			appleyTextFormatToSelection(tft);
			colorIcon.setColor(c);
			colorButton.repaint();
		}
	}

	private function __urlAction() : Void {
		JOptionPane.showInputDialog(
			getHyperLinkInputTitle(), 
			getHyperLinkInputMsg(), 
			Delegate.create(this, __urlInputed), 
			getSelectionTextFormat().url, 
			urlButton, 
			true);
	}
	
	private function getHyperLinkInputTitle():String{
		if(hyperLinkInputTitle == null){
			hyperLinkInputTitle = "Hyper Link";
		}
		return hyperLinkInputTitle;
	}
	
	private function getHyperLinkInputMsg():String{
		if(hyperLinkInputMsg == null){
			hyperLinkInputMsg = "Please input the link address(empty means remove hyperlink):";
		}
		return hyperLinkInputMsg;
	}
	
	public function setHyperLinkInputTitle(str:String):Void{
		hyperLinkInputTitle = str;
	}
	
	public function setHyperLinkInputMsg(str:String):Void{
		hyperLinkInputMsg = str;
	}

	private function __urlInputed(url:String) : Void {
		urlButton.requestFocus();
		restoreFocusAndSelection();
		if(url != null){
			var tft:TextFormat = new TextFormat();
			tft.url = url;
			if(tft.url != ""){
				tft.target = "_blank";
				tft.color = 0x0000FF;
				tft.underline = true;
			}else{
				tft.color = 0x000000;
				tft.underline = false;
			}
			appleyTextFormatToSelection(tft);
			if(tft.url == ""){
				urlButton.setSelected(false);
			}else{
				urlButton.setSelected(true);
			}
		}
	}


}