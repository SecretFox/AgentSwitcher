import com.Utils.ID32;
import com.Utils.Signal;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.Build;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.data.mobData;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.BaseTrigger {
	static var m_Controller:Controller;
	public var ID:ID32;
	private var Started:Boolean;
	private var destructed:Boolean;
	
	public var SignalDestruct:Signal;
	public var SignalLock:Signal;
	
	public var AgentNames:Array;
	public var AgentRoles:Array;
	
	public var BuildNames:Array;
	public var BuildRoles:Array;
	
	public var OutfitRoles:Array;
	public var OutfitNames:Array;
	
	// {Name:name, Race:race, Stat:stat, Agent:agent} from druidhelper
	private var TargetData:mobData;
	
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
	
	private function EquipBuild(callback:Function) {
		var found = false;
		if (BuildNames.length > 0){
			for (var i:Number = 0; i < BuildNames.length; i++){
				if (Player.IsRightRole(BuildRoles[i])){
					found = true;
					var build = BuildNames.splice(i, 1)[0];
					BuildRoles.splice(i, 1);
					Build.AddToQueue(build, Age, undefined, callback, false);
					break
				}
			}
		}
		if (OutfitNames.length > 0){
			for (var i:Number = 0; i < OutfitNames.length; i++){
				if (Player.IsRightRole(OutfitRoles[i])){
					var build = OutfitNames.splice(i, 1)[0];
					OutfitRoles.splice(i, 1);
					Build.AddToQueue(build, Age, undefined, undefined, true);
				}
			}
		}
		return found
	}
	
	private function EquipAgent() {
		for (var i:Number = 0; i < AgentNames.length; i++){
			if (Player.IsRightRole(AgentRoles[i])){
				// default
				if (AgentNames[i].toLowerCase() == "default"){
					var agentID = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent, m_Controller.settingDefaultAgent, 0);
					if (agentID) DruidSystem.SwitchToAgent(agentID, m_Controller.settingRealSlot);
					
					agentID = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent2, m_Controller.settingDefaultAgent2, 0);
					if(agentID) DruidSystem.SwitchToAgent(agentID, m_Controller.settingRealSlot2);
				}
				else {
					var agent;
					var agent2;
					// predefined
					if (AgentNames[i] instanceof Array) {
						agent = DruidSystem.GetSwitchAgent(AgentNames[i][0], m_Controller.settingRealSlot, m_Controller.settingDefaultAgent)
						agent2 = DruidSystem.GetSwitchAgent(AgentNames[i][1], m_Controller.settingRealSlot2, m_Controller.settingDefaultAgent2)
					}
					// mob based
					else if (AgentNames[i] == "race") {
						agent = DruidSystem.GetSwitchAgent(TargetData.Agent[0], m_Controller.settingRealSlot, m_Controller.settingDefaultAgent)
						agent2 = DruidSystem.GetSwitchAgent(TargetData.Agent[1], m_Controller.settingRealSlot2, m_Controller.settingDefaultAgent2)
					} else if (!isNaN(AgentNames[i])) {
						agent = DruidSystem.GetSwitchAgent(AgentNames[i], m_Controller.settingRealSlot, m_Controller.settingDefaultAgent)
					}
					DruidSystem.SwitchToAgents(agent, agent2, m_Controller);
				}
				break
			}
		}
	}
}