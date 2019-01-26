import com.Utils.Signal;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.BaseTrigger {
	public var ID:String;
	private var Started:Boolean;
	
	public var BuildRole:String;
	public var AgentRole:String;
	public var OutfitRole:String;
	
	public var BuildName:String;
	public var AgentName:String;
	public var OutfitName:String;
	
	public var SignalDestruct:Signal;
	public var SignalLock:Signal;
	
	// Agent switching after build switch
	public var currentAgent:Number;
	public var disconnectTimeout:Number;
	
	// {Name:name, Race:race, Stat:stat, Agent:agent} from druidhelper
	private var TargetData:Object;
	
	public var Age:Number; // When trigger was started. Oldest age is prioritized when build swapping
	
	public function BaseTrigger() {
		SignalDestruct = new Signal();
		SignalLock = new Signal();
		Started = false;
	}
}