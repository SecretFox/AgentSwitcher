/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.debug.console.AWLoggerConsole;
import org.aswing.JWindow;

/**
 * @author iiley
 */
class org.aswing.debug.console.StandaloneConsoleApp {
	
	private static var soloConsoleWindow:JWindow;
	
	public static function main():Void{
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		soloConsoleWindow = new JWindow();
		soloConsoleWindow.setSize(Stage.width, Stage.height);
		var tempWindow:JWindow = soloConsoleWindow;
		Stage.addListener({onResize:function(){
			tempWindow.setSize(Stage.width, Stage.height);
		}});
		
		var logger:AWLoggerConsole = new AWLoggerConsole();
		soloConsoleWindow.setContentPane(logger);
		soloConsoleWindow.show();
	}
}