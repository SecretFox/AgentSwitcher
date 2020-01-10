import com.Utils.ID32;
import com.Utils.Signal;
import com.fox.AgentSwitcher.Utils.Player;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.BaseTrigger {
	public var ID:ID32;
	private var Started:Boolean;
	private var destructed:Boolean;
	public var containsBuild:Boolean;
	
	public var SignalDestruct:Signal;
	public var SignalLock:Signal;
	
	public var AgentNames:Array;
	public var AgentRoles:Array;
	
	public var BuildNames:Array;
	public var BuildRoles:Array;
	
	public var OutfitRoles:Array;
	public var OutfitNames:Array;
	
	// {Name:name, Race:race, Stat:stat, Agent:agent} from druidhelper
	private var TargetData:Object;
	
	public var Age:Number; // When trigger was started. Oldest age is prioritized when build swapping
	
	public function BaseTrigger() {
		SignalDestruct = new Signal();
		SignalLock = new Signal();
		Started = false;
		BuildNames = [];
		BuildRoles = [];
		OutfitNames = [];
		OutfitRoles = [];
		AgentNames = [];
		AgentRoles = [];
	}
	
	private function hasSwitchAgent(){
		for (var i:Number = 0; i < AgentRoles.length; i++){
			if (Player.IsRightRole(AgentRoles[i])) return true;
		}
	}
	
	public function AddToBuilds(build:String,role:String){
		for (var i in BuildNames){
			if (BuildNames[i] == build && BuildRoles[i] == role) return
		}
		BuildNames.push(build);
		BuildRoles.push(role);
	}
	
	public function AddToOutfits(outfit:String,role:String){
		for (var i in OutfitNames){
			if (OutfitNames[i] == outfit && OutfitRoles[i] == role) return
		}
		OutfitNames.push(outfit);
		OutfitRoles.push(role);
	}
	
	public function AddToAgents(agent:String, role:String){
		for (var i in AgentNames){
			if (AgentNames[i] == agent && AgentRoles[i] == role) return
		}
		AgentNames.push(agent);
		AgentRoles.push(role);
	}
}