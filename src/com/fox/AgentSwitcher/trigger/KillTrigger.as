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
			var currentAgent = DruidSystem.GetAgentInSlot(m_Controller.settingRealSlot).m_AgentId;
			if (currentAgent && DruidSystem.IsDruid(currentAgent)){
				AgentNames.push(string(currentAgent));
				AgentRoles.push("all");
			}
		}
		
		var f2:Function = Delegate.create(this, kill);
		if(BuildNames.length > 0 || OutfitNames.length > 0) {
			Age = Date(new Date).valueOf();
			var f:Function = Delegate.create(this, EquipBuild);
			Task.AddTask(Task.inPlayTask, f, f2);
		} else {
			Task.RemoveTasksByType(Task.OutCombatTask);
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
		var f2:Function = Delegate.create(this, OnBuildEquip);
		var found = super.EquipBuild(f2);
		if (!found && AgentNames.length>0) EquipAgent(); // If no build start agent switch
	}
	
	private function EquipAgent() {
		super.EquipAgent();
		if (lockNeeded){
			SignalLock.Emit(true);
		}
		kill();
	}
}