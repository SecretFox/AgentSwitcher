import com.fox.AgentSwitcher.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.Game.Character;
import com.Utils.ID32;
import mx.utils.Delegate;
/**
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.KillTrigger extends BaseTrigger {
	private var Char:Character;
	private var lockNeeded:Boolean;
	
	public function KillTrigger(id:String) {
		super();
		ID = id;
	}
	
	public function StartTrigger(id:ID32){
		if (!Started){
			Started = true;
			Char = new Character(id);
			TargetData = DruidSystem.GetRace(id);
			Char.SignalCharacterDied.Connect(TargetDied, this);
			Char.SignalCharacterDestructed.Connect(kill, this);
		}
	}
	
	public function kill() {
		Char.SignalCharacterDied.Disconnect(TargetDied, this);
		Char.SignalCharacterDestructed.Disconnect(kill, this);
		SignalDestruct.Emit(this);
	}
	
	private function TargetDied() {
		var f2:Function = Delegate.create(this, kill);
		if (AgentName) lockNeeded = true;
		if(BuildName || OutfitName) {
			var time:Date = new Date();
			Age = time.valueOf();
			// Trying to get agent before inPlay crashes the game
			// Actual equip action will also have separate check for cooldowns, inPlay, casting, Combat
			var f:Function = Delegate.create(this, EquipBuild);
			Task.AddTask(Task.inPlayTask, f, f2);
		} else {
			if (!Task.HasTaskType(Task.OutCombatTask)) {
				var f:Function = Delegate.create(this, EquipAgent);
				Task.AddTask(Task.OutCombatTask, f, f2);
			}
		}
	}
	
	private function InRange() {
		return false
	}
	
	private function StartedEquip():Void {
		// If we had druid equipped we want to keep it equipped
		// build will still switch to other agent momentarily, setting the new default agent
		if (currentAgent && DruidSystem.IsDruid(currentAgent) && !AgentName) {
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
		}else{
			SignalDestruct.Emit();
		}
	}
	
	private function AgentChanged(slotID:Number) {
		clearTimeout(disconnectTimeout);
		disconnectTimeout = setTimeout(Delegate.create(this, DisconnectAgentMonitoring), 200);
		if (slotID == Controller.GetInstance().settingRealSlot) {
			var SlotAgent:com.GameInterface.AgentSystemAgent = DruidSystem.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (SlotAgent.m_AgentId != Number(currentAgent)) {
					AgentName = string(currentAgent);
				}
			}
		}
	}
	private function EquipBuild() {
		var f:Function = Delegate.create(this, StartedEquip);
		var f2:Function = Delegate.create(this, OnBuildEquip);
		currentAgent = DruidSystem.GetAgentInSlot(Controller.GetInstance().settingRealSlot).m_AgentId;
		if(BuildName) Build.AddToQueue(BuildName, Age, f, f2, false); // Equips agent after it is done
		if (OutfitName) Build.AddToQueue(OutfitName, Age, undefined, undefined, true); // Equips outfit simultaneously with build
		if (!BuildName && AgentName) EquipAgent(); // If no build start agent switch
	}
	private function EquipAgent() {
		if (BuildName){
			DisconnectAgentMonitoring();
		}
		if (AgentName) {
			if (AgentName.toLowerCase() == "default"){
				AgentName = string(Controller.GetInstance().settingDefaultAgent);
			}
			var agentID = DruidSystem.GetSwitchAgent(Number(AgentName), Controller.GetInstance().settingRealSlot, 0);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.GetInstance().settingRealSlot);
			}
		}
		else {
			var agentID = DruidSystem.GetSwitchAgent(TargetData.Agent, Controller.GetInstance().settingRealSlot, 0);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.GetInstance().settingRealSlot);
			}
		}
		if (lockNeeded){
			SignalLock.Emit(true);
		}
		kill();
	}
}