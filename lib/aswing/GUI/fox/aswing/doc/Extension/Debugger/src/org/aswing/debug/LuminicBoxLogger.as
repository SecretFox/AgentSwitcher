/*
 CopyRight @ 2005 XLands.com INC. All rights reserved.
*/

import org.aswing.debug.Logger;
import org.aswing.debug.SoloLogger;

//import LuminicBox.Log.ConsolePublisher;

/**
 * LuminicBox Logger<br>
 * To make this class compiable, you need to to recommend the codes 
 * and add LuminicBox project your class path.
 * @author iiley
 */
class org.aswing.debug.LuminicBoxLogger extends SoloLogger implements Logger{
	
	//private var luminicLogger:LuminicBox.Log.Logger;
	public function LuminicBoxLogger() {
		super();
		//luminicLogger = new LuminicBox.Log.Logger("zeroi");
		//luminicLogger.addPublisher( new ConsolePublisher());
	}

	public function info(msg : String) : Void {
		//luminicLogger.info(msg);
	}

	public function debug(msg : String) : Void {
		//luminicLogger.debug(msg);
	}

	public function warnning(msg : String) : Void {
		//luminicLogger.warn(msg);
	}

	public function error(msg : String) : Void {
		//luminicLogger.error(msg);
	}

	/**
	 * Overrided from supper
	 */
	public function getLogger():Logger{
		return this;
	}
}