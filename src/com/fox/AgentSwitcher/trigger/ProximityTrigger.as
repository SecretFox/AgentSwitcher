import com.Utils.ID32;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.Game.Character;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.ProximityTrigger extends BaseTrigger {
	private var Range:Number;
	private var refreshInterval:Number;
	public var Char:Character;
	//private var namePattern:String; // Name pattern that was used to start the trigger. may be full mob name or partial match

	public function ProximityTrigger(id:ID32, range:Number) {
		super();
		ID = id;
		Range = range;
	}
	
	public function StartTrigger() {
		if (!Started){
			Started = true;
			Char = new Character(ID);
			TargetData = DruidSystem.GetRace(ID);
			Char.SignalCharacterDestructed.Connect(kill, this);
			Char.SignalCharacterDied.Connect(kill, this);
			refreshInterval = setInterval(Delegate.create(this, GetRange), m_Controller.settingUpdateRate);
		}
	}
	public function SetRefresh() {
		clearInterval(refreshInterval);
		refreshInterval = setInterval(Delegate.create(this, GetRange), m_Controller.settingUpdateRate);
	}
	
	public function kill() {
		if (!destructed){
			destructed = true
			clearInterval(refreshInterval);
			Char.SignalCharacterDestructed.Disconnect(kill, this);
			Char.SignalCharacterDied.Disconnect(kill, this);
			SignalDestruct.Emit(this);
		}
	}
	
	private function GetRange() {
		if (Char.IsDead()) {
			kill();
			return
		}
		var distance = Char.GetDistanceToPlayer();
		if (distance < Range) {
			clearInterval(refreshInterval);
			if (hasSwitchAgent()){
				lockNeeded = true;
				m_Controller.m_Icon.ApplyLock();
			}
			
			var f2:Function = Delegate.create(this, kill);
			if (BuildNames.length > 0 || OutfitNames.length > 0) {
				var time:Date = new Date();
				Age = time.valueOf();
				var f:Function = Delegate.create(this, EquipBuild);
				Task.AddTask(Task.inPlayTask, f, f2);
			} else {
				//Task.RemoveTasksByType(Task.OutCombatTask); // Remove queued tasks
				var f:Function = Delegate.create(this, EquipAgent);
				Task.AddTask(Task.OutCombatTask, f, f2);
			}
		}
	}
	
	public function InRange() {
		if (lockNeeded && Char.GetDistanceToPlayer() < Range && !Char.IsDead()) {
			return true
		}
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
		if (!found && AgentNames.length> 0 ) EquipAgent(); // If no build start agent switch
	}
	
	private function EquipAgent() {
		super.EquipAgent();
	}
}