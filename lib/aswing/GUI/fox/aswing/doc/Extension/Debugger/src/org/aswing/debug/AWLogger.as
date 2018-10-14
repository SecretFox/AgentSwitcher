/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.debug.Delegate;
import org.aswing.debug.Logger;
import org.aswing.debug.SoloLogger;

/**
 * @author iiley
 */
class org.aswing.debug.AWLogger extends SoloLogger implements Logger {
	
	private var lc:LocalConnection;
	
	public function AWLogger() {
		super();
		lc = new LocalConnection();
		lc.onStatus = Delegate.create(this, __onStatus);
	}
	
	private function __onStatus(infoObject:Object):Void{
		//_global.org.aswing.JOptionPane.showMessageDialog("", infoObject.level+"");
		lc.onStatus = null;
	}

	public function info(msg : String) : Void {
		lc.send("aswing_logger", "info", msg);
	}

	public function debug(msg : String) : Void {
		lc.send("aswing_logger", "debug", msg);
	}

	public function warnning(msg : String) : Void {
		lc.send("aswing_logger", "warnning", msg);
	}

	public function error(msg : String) : Void {
		lc.send("aswing_logger", "error", msg);
	}
	
	public function getLogger():Logger{
		return this;
	}

}