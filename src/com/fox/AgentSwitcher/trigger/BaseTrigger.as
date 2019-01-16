import com.Utils.ID32;
import com.GameInterface.Game.Character;
import com.Utils.Signal;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.BaseTrigger{
	
	private var ID:ID32;
	private var Agent:String;
	private var Char:Character;
	private var isBuild:Boolean;
	private var currentAgent:Number;
	private var disconnectTimeout:Number;
	private var switchTimeout:Number;
	public var SignalDestruct:Signal;
	
	public function BaseTrigger() {
		SignalDestruct = new Signal();
	}
}