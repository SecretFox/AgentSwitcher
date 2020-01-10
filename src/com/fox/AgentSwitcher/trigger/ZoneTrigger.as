import com.fox.AgentSwitcher.Utils.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.WaypointInterface;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/

class com.fox.AgentSwitcher.trigger.ZoneTrigger extends BaseTrigger {
	private var hasBuild:Boolean;
	private var SwitchedBuilds:Array; // true if build by that index has been switched to already
	private var ID:Number;
	
	public function ZoneTrigger(zone:String) {
		super();
		ID = Number(zone);
		SwitchedBuilds = new Array();
	}
	
	public function StartTrigger() {
		if (!Started){
			Started = true;
			WaypointInterface.SignalPlayfieldChanged.Connect(PlayFieldChanged, this);
		}
	}
	public function AddtoAgents(agent:String, role:String){
		for (var i in AgentNames){
			if (AgentNames[i] == agent && AgentRoles[i] == role) return
		}
		AgentNames.push(agent);
		AgentRoles.push(role);
	}
	public function kill() {
		WaypointInterface.SignalPlayfieldChanged.Disconnect(PlayFieldChanged, this);
	}
	private function InRange() {
		return false
	}

	private function PlayFieldChanged(playfieldID:Number) {
		if (playfieldID == ID) {
			for (var i in BuildNames){
				SwitchedBuilds.push(false);
			}
			StartEquip();
		}
	}
	private function StartEquip() {
		var f2:Function = Delegate.create(this, kill);
		if (BuildNames.length > 0 || OutfitNames.length > 0) {
			var time:Date = new Date();
			Age = time.valueOf();
			// Trying to get equipped agent while in loading screen will crash the game
			var f:Function = Delegate.create(this, PreEquipBuild);
			Task.AddTask(Task.inPlayTask, f, f2);
		} else {
			// Trying to get equipped agent while in loading screen will crash the game
			var f:Function = Delegate.create(this, EquipAgent);
			Task.AddTask(Task.inPlayTask, f, f2);
		}
	}
	
	private function OnBuildEquip(success){
		EquipBuild();
	}
	// Player in-game,save currently equipped agent if not switching agents, so that it can be re-equipped after build switch
	private function PreEquipBuild(){
		if (!hasSwitchAgent()){
			var currentAgent = DruidSystem.GetAgentInSlot(Controller.GetInstance().settingRealSlot).m_AgentId;
			if (currentAgent && DruidSystem.IsDruid(currentAgent)){
				AgentNames.push(string(currentAgent));
				AgentRoles.push("all");
			}
		}
		//also switch outfits
		for (var i:Number = 0; i < OutfitNames.length; i++){
			if (Player.IsRightRole(OutfitRoles[i])){
				Build.AddToQueue(OutfitNames[i], Age, undefined, undefined, true);
				break
			}
		}
		EquipBuild();
	}
	
	private function EquipBuild() {
		var f2:Function = Delegate.create(this, OnBuildEquip);
		hasBuild = false;
		for (var i:Number = 0; i < BuildNames.length; i++){
			if (Player.IsRightRole(BuildRoles[i]) && !SwitchedBuilds[i]){
				SwitchedBuilds[i] = true;
				Build.AddToQueue(BuildNames[i], Age, undefined, f2);
				hasBuild = true;
				break
			}
		}
		if (!hasBuild && AgentNames.length > 0){
			EquipAgent();
		}
		if (!hasBuild){
			for (var i in SwitchedBuilds) SwitchedBuilds[i] = false;
		}
	}
	private function EquipAgent() {
		for (var i:Number = 0; i < AgentNames.length; i++){
			if (Player.IsRightRole(AgentRoles[i])){
				if (AgentNames[i].toLowerCase() == "default"){
					AgentNames[i] = string(Controller.GetInstance().settingDefaultAgent);
				}
				if (AgentNames[i] == "race"){
					AgentNames[i] = DruidSystem.GetSwitchAgent(TargetData.Agent, Controller.GetInstance().settingRealSlot, Controller.GetInstance().settingDefaultAgent)
				}
				var agentID = DruidSystem.GetSwitchAgent(Number(AgentNames[i]), Controller.GetInstance().settingRealSlot, 0);
				if (agentID) {
					DruidSystem.SwitchToAgent(agentID, Controller.GetInstance().settingRealSlot);
				}
				break
			}
		}
	}
}