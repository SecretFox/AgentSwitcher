/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import org.aswing.debug.console.AWLoggerConsole;
import org.aswing.JFrame;

/**
 * @author iiley
 */
class org.aswing.debug.console.BuildInConsole {
		
	private static var instance:BuildInConsole;
	
	private static function getInstance():BuildInConsole{
		if(instance == null){
			instance = new BuildInConsole();
		}
		return instance;
	}
	
	private static var owner:Object;
	private var dialog:JFrame;
	private var console:AWLoggerConsole;
	
	private function BuildInConsole(){
		console = new AWLoggerConsole();
	}
	
	/**
	 * Adds info msg
	 */
	public static function info(msg:String):Void{
		getInstance().console.addInfoMsg(msg);
	}
	
	/**
	 * Adds debug msg
	 */
	public static function debug(msg:String):Void{
		getInstance().console.addDebugMsg(msg);
	}
	
	/**
	 * Adds warnning msg
	 */
	public static function warnning(msg:String):Void{
		getInstance().console.addWarnningMsg(msg);
	}
	
	/**
	 * Adds error msg
	 */
	public static function error(msg:String):Void{
		getInstance().console.addErrorMsg(msg);
	}
	
	public static function log(msg:String, position, file, line):Void{
		var msgAddition:String = line == undefined ? "" : "\t" + "{" + position + ", " + file + ", " + line + "}";
	
		if(msg.charAt(0) == "/"){
			var type:String = msg.substr(0, 3);
			if(type == "/d/"){
				debug(msg.substr(3) + msgAddition);
			}else if(type == "/w/"){
				warnning(msg.substr(3) + msgAddition);
			}else if(type == "/e/"){
				error(msg.substr(3) + msgAddition);
			}else if(type == "/i/"){
				info(msg.substr(3) + msgAddition);
			}else{//default
				info(msg + msgAddition);
			}
		}else{//default
			info(msg + msgAddition);
		}
	}
	
	/**
	 * Show the console dialog.
	 * @param owner the owner of the console dialog, from a right owner you can make it always on top.
	 * @return the console dialog
	 */
	public static function showConsoleDialog(owner:Object):JFrame{
		getInstance().dialog.dispose();
		var frame:JFrame = new JFrame(owner, "AW Logger Console");
		frame.setContentPane(getInstance().console);
		frame.setClosable(false);
		frame.setSize(400, 300);
		getInstance().dialog = frame;
		frame.show();
		return frame;
	}
}