/*
 CopyRight @ 2005 XLands.com INC. All rights reserved.
*/

import org.aswing.BorderLayout;
import org.aswing.ButtonGroup;
import org.aswing.Container;
import org.aswing.debug.console.LogTextArea;
import org.aswing.FlowLayout;
import org.aswing.JButton;
import org.aswing.JOptionPane;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JToggleButton;
import org.aswing.RepaintManager;
import org.aswing.util.Delegate;

/**
 * @author iiley
 */
class org.aswing.debug.console.AWLoggerConsole extends JPanel {
	
	private var textArea:LogTextArea;
	private var lc:LocalConnection;
	private var infoTextFormat:TextFormat;
	private var debugTextFormat:TextFormat;
	private var warnningTextFormat:TextFormat;
	private var errorTextFormat:TextFormat;
	
	private var runButton:JToggleButton;
	private var pauseButton:JToggleButton;
	private var clearButton:JButton;
	private var running:Boolean;
	private var bufferedMsgs:Array;
	
	public function AWLoggerConsole() {
		super();
		
		infoTextFormat = new TextFormat();
		infoTextFormat.color = 0x000000;
		debugTextFormat = new TextFormat();
		debugTextFormat.color = 0x4694F1;
		warnningTextFormat = new TextFormat();
		warnningTextFormat.color = 0xFEB0A4;
		errorTextFormat = new TextFormat();
		errorTextFormat.color = 0xFF0000;
		
		textArea = new LogTextArea();
		textArea.setWordWrap(false);
		textArea.setEditable(false);
		var buttonGroup:ButtonGroup = new ButtonGroup();
		runButton = new JToggleButton("Run");
		pauseButton = new JToggleButton("Pause");
		buttonGroup.append(runButton);
		buttonGroup.append(pauseButton);
		clearButton = new JButton("Clear");
		
		var pane:Container = this;
		pane.setLayout(new BorderLayout());
		pane.append(new JScrollPane(textArea, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_ALWAYS), BorderLayout.CENTER);
		
		var toolBar:Container = new JPanel(new FlowLayout(FlowLayout.RIGHT));
		toolBar.append(runButton);
		toolBar.append(pauseButton);
		toolBar.append(clearButton);
		pane.append(toolBar, BorderLayout.SOUTH);
		
		runButton.setSelected(true);
		running = true;
		runButton.addSelectionListener(__runSelectionChanged, this);
		clearButton.addActionListener(__clearTexts, this);
		textArea.addEventListener(LogTextArea.ON_CREATED, __onLogTextCreated, this);
		initLC();
	}
	
	private function __runSelectionChanged():Void{
		running = runButton.isSelected();
	}
	
	private function __clearTexts():Void{
		textArea.setHtmlText("");
	}
	
	private function __onLogTextCreated():Void{
		checkBuffer();
	}
	
	private function initLC():Void{
		lc = new LocalConnection();
		lc.info = Delegate.create(this, __info);
		lc.debug = Delegate.create(this, __debug);
		lc.warnning = Delegate.create(this, __warnning);
		lc.error = Delegate.create(this, __error);
		lc.allowDomain = function(sendingDomain:String):Boolean {
		    return true;
		};
		
		if(lc.connect("aswing_logger")){
			//successs
			textArea.setHtmlText("<p>Initialized OK!!</p>");
		}else{
			//faild
			RepaintManager.getInstance().addCallAfterNextPaintTime(Delegate.create(this, __initFialed));
		}
	}
	
	private function __initFialed():Void{
		JOptionPane.showMessageDialog(
			"Initialized Fialed!", 
			"Maybe another console is running, close it and then press OK.", 
			Delegate.create(this, initLC), 
			null, 
			true, 
			null, 
			JOptionPane.OK
			);
	}
	
	public function logWithTF(msg:String, textFormat:TextFormat):Void{
		if(!running){
			return;
		}
		var tf:TextField = textArea.getPrivateTextField();
		if(tf != null){
			appendMsg(msg, textFormat);
		}else{
			if(bufferedMsgs == null){
				bufferedMsgs = new Array();
			}
			bufferedMsgs.push(msg);
			bufferedMsgs.push(textFormat);
		}
	}
	
	private function checkBuffer():Void{
		if(bufferedMsgs != null){
			for(var i:Number=0; i<bufferedMsgs.length; i+=2){
				appendMsg(bufferedMsgs[i], bufferedMsgs[i+1]);
			}
			bufferedMsgs = null;
		}
	}
	
	private function appendMsg(msg:String, textFormat:TextFormat):Void{
		var tf:TextField = textArea.getPrivateTextField();
		msg = msg+"\n";
		var length:Number = tf.length;
		tf.replaceText(length, length, msg);
		tf.setTextFormat(length, length+msg.length, textFormat);
		textArea.scrollToBottomLeft();
		textArea.revalidate();
	}
	
	/**
	 * logs a info messege(The default log method)
	 */
	public function addInfoMsg(msg:String):Void{
		__info(msg);
	}
	
	/**
	 * logs a debug messege
	 */
	public function addDebugMsg(msg:String):Void{
		__debug(msg);
	}
	
	/**
	 * logs a warnning messege
	 */
	public function addWarnningMsg(msg:String):Void{
		__warnning(msg);
	}
	
	/**
	 * logs a error messege
	 */
	public function addErrorMsg(msg:String):Void{
		__error(msg);
	}
	
	private function __info(msg:String):Void{
		logWithTF(msg, infoTextFormat);
	}
	private function __debug(msg:String):Void{
		logWithTF(msg, debugTextFormat);
	}
	private function __warnning(msg:String):Void{
		logWithTF(msg, warnningTextFormat);
	}
	private function __error(msg:String):Void{
		logWithTF(msg, errorTextFormat);
	}

	private function __onWindowResized() : Void {
		setSize(Stage.width, Stage.height);
	}

}