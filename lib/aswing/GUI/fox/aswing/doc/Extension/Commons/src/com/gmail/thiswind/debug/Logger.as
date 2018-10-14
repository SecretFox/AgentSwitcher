import org.aswing.AbstractButton;
import org.aswing.ASColor;
import org.aswing.ASWingUtils;
import org.aswing.BorderLayout;
import org.aswing.Container;
import org.aswing.Event;
import org.aswing.geom.Rectangle;
import org.aswing.JButton;
import org.aswing.JFrame;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JTextArea;
import org.aswing.JToggleButton;
import org.aswing.SoftBoxLayout;
import org.aswing.util.Delegate;
/**
 * Copyright(c) Hukuang 2006, All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are 
 * permitted provided that the following conditions are met:
 *
 * 1) Redistributions of source code must retain the above copyright notice, this list of 
 * conditions and the following disclaimer. 
 *
 * 2) Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials 
 * provided with the distribution. 
 * 
 * 3) Neither the name AsWing.org nor the names of its contributors may be used to endorse 
 * or promote products derived from this software without specific prior written permission. 
 * 
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * @author Hukuang
*/
class com.gmail.thiswind.debug.Logger {
	
	/**
	 * log message
	 * Logger.logMessage(message);//debug output
	 * Logger.logMessage(message, level);
	 * Such as: Log.logMessage("hello", 1);//1 is the level of DEBUG
	 * 
	 * or you could use a prefix at the front of your message string to trigger the level
	 * debug:
	 * Logger.logMessage("Debug:" + message);
	 * Logger.logMessage("Debug :" + message);
	 * Logger.logMessage("debug:" + message);
	 * Logger.logMessage("debug :" + message);
	 * Logger.logMessage("/d/" + message);//aswing style
	 * 
	 * info:
	 * Logger.logMessage("Info:" + message);
	 * Logger.logMessage("Info :" + message);
	 * Logger.logMessage("info:" + message);
	 * Logger.logMessage("info :" + message);
	 * Logger.logMessage("/i/" + message);//aswing style
	 * 
	 * warnning:
	 * Logger.logMessage("Warnning:" + message);
	 * Logger.logMessage("Warnning :" + message);
	 * Logger.logMessage("warnning:" + message);
	 * Logger.logMessage("warnning :" + message);
	 * Logger.logMessage("Warn:" + message);
	 * Logger.logMessage("Warn :" + message);
	 * Logger.logMessage("warn:" + message);
	 * Logger.logMessage("warn :" + message);
	 * Logger.logMessage("/w/" + message);//aswing style
	 * 
	 * severe(error) :
	 * Logger.logMessage("Severe:" + message);
	 * Logger.logMessage("Severe :" + message);
	 * Logger.logMessage("severe:" + message);
	 * Logger.logMessage("severe :" + message);
	 * Logger.logMessage("Error:" + message);
	 * Logger.logMessage("Error :" + message);
	 * Logger.logMessage("error:" + message);
	 * Logger.logMessage("error :" + message);
	 * Logger.logMessage("/e/" + message);//aswing style
	 * 
	 * With MTASC1.12,if you used this method for defualt trace:
	 * "mtasc.exe -trace com.gmail.thiswind.debug.Logger.log ..."
	 * you can use trace() to call this method:
	 * trace (message, level);
	 * Such as: trace ("hello", 2);//2 is the level of INFO
	 * 
	 * You can also use the same prifix to trigger the level.
	 * Like this:
	 * debug:
	 * trace("Debug:" + message);
	 * trace("Debug :" + message);
	 * trace("debug:" + message);
	 * trace("debug :" + message);
	 * trace("/d/" + message);//aswing style
	 * 
	 * info:
	 * trace("Info:" + message);
	 * trace("Info :" + message);
	 * trace("info:" + message);
	 * trace("info :" + message);
	 * trace("/i/" + message);//aswing style
	 * 
	 * warnning:
	 * trace("Warnning:" + message);
	 * trace("Warnning :" + message);
	 * trace("warnning:" + message);
	 * trace("warnning :" + message);
	 * trace("Warn:" + message);
	 * trace("Warn :" + message);
	 * trace("warn:" + message);
	 * trace("warn :" + message);
	 * trace("/w/" + message);//aswing style
	 * 
	 * severe(error) :
	 * trace("Severe:" + message);
	 * trace("Severe :" + message);
	 * trace("severe:" + message);
	 * trace("severe :" + message);
	 * trace("Error:" + message);
	 * trace("Error :" + message);
	 * trace("error:" + message);
	 * trace("error :" + message);
	 * trace("/e/" + message);//aswing style
	 */
	public static function log(message:Object, level:Number) :Void {
		var logger:Logger = Logger.getInstance();
		
		logger.addMessage(message, level);
		
		logger.showFrame();
	}
	
	/**
	 * show Trace frame anyway
	 */
	public static function show() :Void {
		var logger:Logger = Logger.getInstance();
		logger.showFrame();
	}
	
	/**
	 * singleton static instance
	 */
	private static var __INSTANCE:Logger;
	
	/**
	 * get the singleton
	 * private.
	 * it's needn't to be published
	 */
	private static function getInstance() :Logger {
		if (Logger.__INSTANCE == null) {
			Logger.__INSTANCE = new Logger();
		}
		
		return Logger.__INSTANCE;
	}
	
	public static var LEVEL_OFF:Number = 0; 
	public static var LEVEL_DEBUG:Number = 1;
	public static var LEVEL_INFO:Number = 2;
	public static var LEVEL_WARNING:Number = 3;
	public static var LEVEL_SEVERE:Number = 4;
	
	private var frame:JFrame;
	private var outputPane:JPanel;
	private var pauseBtn:JToggleButton;
	private var cleanBtn:JButton;
	
	private var level:Number;
	
	private var paused:Boolean;
	
	/**
	 * private for singleton
	 */
	private function Logger() {
		this.level = Logger.LEVEL_DEBUG;
		this.paused = false;
		
		this.createFrame();	
	}
	
	/**
	 * create UI
	 */
	private function createFrame () :Void {
		this.frame = new JFrame("TRACE", null, false);
		this.frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		
		this.frame.setBackground(ASColor.WHITE);
		
		var c:Container = this.frame.getContentPane();
		c.setLayout(new BorderLayout());
		
		this.pauseBtn = new JToggleButton("Pause");
		this.pauseBtn.addEventListener(AbstractButton.ON_RELEASE, Delegate.create(this, this.__onPauseButtonReleased));
		c.append(this.pauseBtn, BorderLayout.NORTH);
		
		this.outputPane = new JPanel();
		this.outputPane.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
		this.outputPane.setOpaque(true);
		this.outputPane.setBackground(ASColor.WHITE);
		c.append(new JScrollPane(this.outputPane), BorderLayout.CENTER);
		
		this.cleanBtn = new JButton("Clean All");
		this.cleanBtn.addEventListener(AbstractButton.ON_RELEASE, Delegate.create(this, this.__onCleanBtnReleased));
		c.append(this.cleanBtn, BorderLayout.SOUTH);
	}
	
	/**
	 * add message
	 * addMessage(message);//debug output
	 * addMessage(message, level);
	 * 
	 * or you could use a prefix at the front of your message string to trigger the level
	 * debug:
	 * addMessage("Debug:" + message);
	 * addMessage("Debug :" + message);
	 * addMessage("debug:" + message);
	 * addMessage("debug :" + message);
	 * addMessage("/d/" + message);//aswing style
	 * 
	 * info:
	 * addMessage("Info:" + message);
	 * addMessage("Info :" + message);
	 * addMessage("info:" + message);
	 * addMessage("info :" + message);
	 * addMessage("/i/" + message);//aswing style
	 * 
	 * warnning:
	 * addMessage("Warnning:" + message);
	 * addMessage("Warnning :" + message);
	 * addMessage("warnning:" + message);
	 * addMessage("warnning :" + message);
	 * addMessage("Warn:" + message);
	 * addMessage("Warn :" + message);
	 * addMessage("warn:" + message);
	 * addMessage("warn :" + message);
	 * addMessage("/w/" + message);//aswing style
	 * 
	 * severe(error) :
	 * addMessage("Severe:" + message);
	 * addMessage("Severe :" + message);
	 * addMessage("severe:" + message);
	 * addMessage("severe :" + message);
	 * addMessage("Error:" + message);
	 * addMessage("Error :" + message);
	 * addMessage("error:" + message);
	 * addMessage("error :" + message);
	 * addMessage("/e/" + message);//aswing style
	 */
	private function addMessage(message:Object, level:Number) :Void {
		if (this.paused || level == Logger.LEVEL_OFF) {
			return;
		}
		
		var color:ASColor = ASColor.WHITE;//default color, it's debug

		if (level == Logger.LEVEL_DEBUG || this.isDebug(message.toString())) {
			color = ASColor.WHITE;
		}
		else
		if (level == Logger.LEVEL_INFO || this.isInfo(message.toString())) {
			color = ASColor.HALO_GREEN;
		}
		else
		if (level == Logger.LEVEL_SEVERE || this.isWarnning(message.toString())) {
			color = ASColor.ORANGE;
		}
		else
		if (level == Logger.LEVEL_WARNING || this.isSevere(message.toString())) {
			color = ASColor.RED;
		}
		
		var item:JTextArea = new JTextArea(message.toString());
		
		item.setEditable(false);
		item.setOpaque(true);
		item.setBackground(color);
		item.setForeground(ASColor.BLACK);
		item.setHtml(false);
		item.setMultiline(true);
		
		this.outputPane.insert(0, item);//insert at the top
	}
	
	/**
	 * validate frame size and location
	 * set size to 350:200 , or fix to VisibleBounds if VisibleBounds is smaller than 350:200 
	 * set location at the bottom-left
	 */
	private function validateFrameSizeAndLocation() :Void {
		this.frame.updateUI();//update ui before resize and re-location
		
		var bounds:Rectangle = ASWingUtils.getVisibleMaximizedBounds();//get visible bounds
		
		//set size to 350:200 , or fix to VisibleBounds if VisibleBounds is smaller than 350:200
		var width:Number = Math.min(350, bounds.width);
		var height:Number = Math.min(200, bounds.height);
		this.frame.setSize(width, height);
		
		//set location at the bottom-left
		this.frame.setLocation(0, bounds.height-this.frame.getHeight());
	}
	
	/**
	 * show frame
	 */
	private function showFrame() :Void {
		this.validateFrameSizeAndLocation();
		
		this.frame.setVisible(true);
		this.frame.toFront();
		this.frame.setActive(true);
	}
	
	//----------level cheking---------
	private function isDebug(message:String) :Boolean {
		if (message.indexOf("Debug:") == 0) {
			return true;
		}
		if (message.indexOf("Debug :") == 0) {
			return true;
		}
		if (message.indexOf("debug:") == 0) {
			return true;
		}
		if (message.indexOf("debug :") == 0) {
			return true;
		}
		
		//for aswing style
		if (message.indexOf("/d/") == 0) {
			return true;
		}
		
		return false;
	}
	private function isInfo(message:String) :Boolean {
		if (message.indexOf("Info:") == 0) {
			return true;
		}
		if (message.indexOf("Info :") == 0) {
			return true;
		}
		if (message.indexOf("info:") == 0) {
			return true;
		}
		if (message.indexOf("info :") == 0) {
			return true;
		}
		
		//for aswing style
		if (message.indexOf("/i/") == 0) {
			return true;
		}
		
		return false;
	}
	private function isWarnning(message:String) :Boolean {
		if (message.indexOf("Warnning:") == 0) {
			return true;
		}
		if (message.indexOf("Warnning :") == 0) {
			return true;
		}
		if (message.indexOf("warnning:") == 0) {
			return true;
		}
		if (message.indexOf("warnning :") == 0) {
			return true;
		}
		
		if (message.indexOf("Warn:") == 0) {
			return true;
		}
		if (message.indexOf("Warn :") == 0) {
			return true;
		}
		if (message.indexOf("warn:") == 0) {
			return true;
		}
		if (message.indexOf("warn :") == 0) {
			return true;
		}
		
		//for aswing style
		if (message.indexOf("/w/") == 0) {
			return true;
		}
		
		return false;
	}
	private function isSevere(message:String) :Boolean {
		if (message.indexOf("Severe:") == 0) {
			return true;
		}
		if (message.indexOf("Severe :") == 0) {
			return true;
		}
		if (message.indexOf("severe:") == 0) {
			return true;
		}
		if (message.indexOf("severe :") == 0) {
			return true;
		}
		
		if (message.indexOf("Error:") == 0) {
			return true;
		}
		if (message.indexOf("Error :") == 0) {
			return true;
		}
		if (message.indexOf("error:") == 0) {
			return true;
		}
		if (message.indexOf("error :") == 0) {
			return true;
		}
		
		//for aswing style
		if (message.indexOf("/e/") == 0) {
			return true;
		}
		
		return false;
	}
	
	//---------event handlers----------
	private function __onPauseButtonReleased(e:Event) :Void {
		this.paused = this.pauseBtn.isSelected();
	}
	private function __onCleanBtnReleased(e:Event) :Void {
		this.outputPane.removeAll();
		this.frame.getContentPane().append(new JScrollPane(this.outputPane), BorderLayout.CENTER);
		this.validateFrameSizeAndLocation();
	}
}