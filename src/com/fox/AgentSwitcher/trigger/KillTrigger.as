import com.fox.AgentSwitcher.Utils.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.Game.Character;
import com.Utils.ID32;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.KillTrigger extends BaseTrigger {
	private var Char:Character;
	private var lockNeeded:Boolean;
	
	public function KillTrigger(id:ID32) {
		super();
		ID = id;
	}
	
	public function StartTrigger(){
		if (!Started){
			Started = true;
			Char = new Character(ID);
			TargetData = DruidSystem.GetRace(ID);
			Char.SignalCharacterDied.Connect(TargetDied, this);
			Char.SignalCharacterDestructed.Connect(kill, this);
		}
	}
	
	public function kill() {
		if (!destructed){
			destructed = true
			Char.SignalCharacterDied.Disconnect(TargetDied, this);
			Char.SignalCharacterDestructed.Disconnect(kill, this);
			SignalDestruct.Emit(this);
		}
	}
	
	private function TargetDied() {
		if (hasSwitchAgent()){
			lockNeeded = true;
		}else{
			var currentAgent = DruidSystem.GetAgentInSlot(Controller.GetInstance().settingRealSlot).m_AgentId;
			if (currentAgent && DruidSystem.IsDruid(currentAgent)){
				AgentNames.push(string(currentAgent));
				AgentRoles.push("all");
			}
		}
		
		var f2:Function = Delegate.create(this, kill);
		if(BuildNames.length > 0 || OutfitNames.length > 0) {
			var time:Date = new Date();
			Age = time.valueOf();
			var f:Function = Delegate.create(this, EquipBuild);
			Task.AddTask(Task.inPlayTask, f, f2);
		} else {
			if (Task.HasTaskType(Task.OutCombatTask)){
				Task.RemoveTasksByType(Task.OutCombatTask)
			}
			var f:Function = Delegate.create(this, EquipAgent);
			Task.AddTask(Task.OutCombatTask, f, f2);
		}
	}
	
	private function InRange() {
		return false
	}
	
	private function OnBuildEquip(success:Boolean){
		if (BuildNames.length > 0 && success){
			EquipBuild();
		}
		else if (AgentNames.length > 0){
			EquipAgent();
		}else{
			kill();
		}
	}
	
	private function EquipBuild() {
		var found = false;
		var f2:Function = Delegate.create(this, OnBuildEquip);
		if (BuildNames.length > 0){
			for (var i:Number = 0; i < BuildNames.length; i++){
				if (Player.IsRightRole(BuildRoles[i])){
					found = true;
					var build = BuildNames.splice(i, 1)[0];
					BuildRoles.splice(i, 1);
					Build.AddToQueue(build, Age, undefined, f2, false);
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
		if (!found && AgentNames.length>0) EquipAgent(); // If no build start agent switch
	}
	private function EquipAgent() {
		if (AgentNames.length > 0) {
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
		if (lockNeeded){
			SignalLock.Emit(true);
		}
		kill();
	}
}