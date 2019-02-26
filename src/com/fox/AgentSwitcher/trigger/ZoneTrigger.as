import com.fox.AgentSwitcher.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.WaypointInterface;
import mx.utils.Delegate;
/**
* ...
* @author fox
*/

class com.fox.AgentSwitcher.trigger.ZoneTrigger extends BaseTrigger {
	public var BuildRoles:Array;
	public var AgentRoles:Array
	public var OutfitRoles:Array;
	
	public var BuildNames:Array;
	public var AgentNames:Array;
	public var OutfitNames:Array;
	
	private var hasBuild:Boolean;
	
	public function ZoneTrigger(id:String) {
		super();
		ID = id;
		// Need to store builds in array,since player might want use different build depending on role
		// Proximity/Kill triggers don't have this problems since they are created (and role checked) only when nametag gets added (unlike zone triggers which are loaded only once)
		BuildRoles = new Array();
		AgentRoles = new Array();
		OutfitRoles = new Array();
		
		BuildNames = new Array();
		AgentNames = new Array();
		OutfitNames = new Array();
	}
	
	public function StartTrigger() {
		if (!Started){
			Started = true;
			WaypointInterface.SignalPlayfieldChanged.Connect(PlayFieldChanged, this);
		}
	}
	
	public function kill() {
		WaypointInterface.SignalPlayfieldChanged.Disconnect(PlayFieldChanged, this);
		DisconnectAgentMonitoring();
	}
	private function InRange() {
		return false
	}

	private function PlayFieldChanged(playfieldID:Number) {
		if (playfieldID == Number(ID)) {
			StartEquip();
		}
	}
	private function StartEquip() {
		var f2:Function = Delegate.create(this, kill);
		if (BuildNames.length > 0 || OutfitNames.length > 0) {
			var time:Date = new Date();
			Age = time.valueOf();
			// Trying to get equipped agent while in loading screen will crash the game
			var f:Function = Delegate.create(this, EquipBuild);
			Task.AddTask(Task.inPlayTask, f, f2);
		} else {
			// Trying to get equipped agent while in loading screen will crash the game
			var f:Function = Delegate.create(this, EquipAgent);
			Task.AddTask(Task.inPlayTask, f, f2);
		}
	}
	
	private function HasRoleAgent(){
		for (var i:Number = 0; i < AgentNames.length; i++){
			if (Player.IsRightRole(AgentRoles[i])){
				return true
			}
		}
	}
	
	private function StartedEquip():Void {
		// If we had druid equipped we want to keep it equipped
		// build will still switch to other agent momentarily, setting the new default agent
		if (currentAgent && DruidSystem.IsDruid(currentAgent) && !HasRoleAgent()) {
			com.GameInterface.AgentSystem.SignalPassiveChanged.Connect(AgentChanged,this);
			disconnectTimeout = setTimeout(Delegate.create(this, DisconnectAgentMonitoring), 5000);
		}
	}
	
	private function DisconnectAgentMonitoring() {
		clearTimeout(disconnectTimeout);
		com.GameInterface.AgentSystem.SignalPassiveChanged.Disconnect(AgentChanged,this);
	}
	
	private function OnBuildEquip(){
		DisconnectAgentMonitoring();
		if (AgentName){
			EquipAgent();
		}
	}
	
	private function AgentChanged(slotID:Number) {
		clearTimeout(disconnectTimeout);
		disconnectTimeout = setTimeout(Delegate.create(this, DisconnectAgentMonitoring), 200);
		if (slotID == Controller.GetInstance().settingRealSlot) {
			var SlotAgent:com.GameInterface.AgentSystemAgent = DruidSystem.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (SlotAgent.m_AgentId != Number(currentAgent)) {
					if (!AgentName) {
						AgentName = string(currentAgent);
					}
				}
			}
		}
	}
	private function EquipBuild() {
		var f:Function = Delegate.create(this, StartedEquip);
		var f2:Function = Delegate.create(this, OnBuildEquip);
		currentAgent = DruidSystem.GetAgentInSlot(Controller.GetInstance().settingRealSlot).m_AgentId;
		hasBuild = false;
		for (var i:Number = 0; i < BuildNames.length; i++){
			if (Player.IsRightRole(BuildRoles[i])){
				Build.AddToQueue(BuildNames[i], Age, f, f2);
				hasBuild = true;
				break
			}
		}
		for (var i:Number = 0; i < OutfitNames.length; i++){
			if (Player.IsRightRole(OutfitRoles[i])){
				Build.AddToQueue(OutfitNames[i], Age, undefined, undefined, true);
				break
			}
		}
		if (!hasBuild && AgentName){
			EquipAgent();
		}
	}
	private function EquipAgent() {
		if (hasBuild){
			DisconnectAgentMonitoring();
		}
		if (!AgentName){
			for (var i:Number = 0; i < AgentNames.length; i++){
				if (Player.IsRightRole(AgentRoles[i])){
					AgentName = AgentNames[i];
					break
				}
			}
		}
		if (AgentName){
			if (AgentName.toLowerCase() == "default"){
				AgentName = string(Controller.GetInstance().settingDefaultAgent);
			}
			var agentID = DruidSystem.GetSwitchAgent(Number(AgentName), Controller.GetInstance().settingRealSlot, 0);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.GetInstance().settingRealSlot);
			}
		}
	}
}