import com.fox.AgentSwitcher.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.Game.Character;
import com.Utils.ID32;
import com.Utils.Signal;
import mx.utils.Delegate;
/**
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.ProximityTrigger extends BaseTrigger {
	private var Range:Number;
	public var EnteredRangeSignal:Signal;
	private var refreshInterval:Number;

	public function ProximityTrigger(id:ID32, agent:String, range:Number, isbuild:Boolean) {
		super();
		ID = id;
		Agent = agent;
		Range = range;
		Char = new Character(ID);
		SignalDestruct = new Signal();
		isBuild = isbuild;
	}
	public function kill() {
		Disconnect();
		clearTimeout(switchTimeout);
		Char.SignalCharacterDestructed.Disconnect(Destructed, this);
		clearInterval(refreshInterval);
	}
	public function StartTrigger() {
		Char.SignalCharacterDestructed.Connect(Destructed, this);
		refreshInterval = setInterval(Delegate.create(this, GetRange), Controller.m_Controller.settingUpdateRate);
		GetRange();
	}
	public function SetRefresh() {
		clearInterval(refreshInterval);
		refreshInterval = setInterval(Delegate.create(this, GetRange), Controller.m_Controller.settingUpdateRate);
	}
	private function Destructed() {
		clearInterval(refreshInterval);
		Char.SignalCharacterDestructed.Disconnect(Destructed, this);
		SignalDestruct.Emit(ID);
	}
	private function GetRange() {
		var distance = Char.GetDistanceToPlayer();
		var HP = Char.GetStat(27);
		if (!HP || !distance) {
			Destructed();
		}
		if (distance < Range) {
			clearInterval(refreshInterval);
			var f2:Function = Delegate.create(this, kill);
			if (!isBuild) {
				if (!Task.HasTaskType(Task.OutCombatTask)) {
					var f:Function = Delegate.create(this, EquipAgent);
					Task.AddTask(Task.OutCombatTask, f, f2);
				}
			} else {
				var time:Date = new Date();
				Age = time.valueOf();
				// Trying to get agent before inPlay crashes the game
				// Actual equip action will also have separate check for cooldowns, inPlay, casting, Combat
				var f:Function = Delegate.create(this, EquipBuild);
				Task.AddTask(Task.inPlayTask, f, f2);
			}
		}
	}
	public function InRange() {
		if (Char.GetDistanceToPlayer() < Range && Char.GetStat(27) && !isBuild) {
			return true
		}
	}
	private function StartedEquip():Void {
		if (currentAgent && DruidSystem.IsDruid(currentAgent)) {
			com.GameInterface.AgentSystem.SignalPassiveChanged.Connect(AgentChanged,this);
			disconnectTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
		}
	}
	private function Disconnect() {
		clearTimeout(disconnectTimeout);
		com.GameInterface.AgentSystem.SignalPassiveChanged.Disconnect(AgentChanged,this);
	}
	private function EquipBuild() {
		var f:Function = Delegate.create(this, StartedEquip);
		currentAgent = DruidSystem.GetAgentInSlot(Controller.m_Controller.settingRealSlot).m_AgentId;
		Build.AddToQueue(Agent, Age, f);
	}
	private function AgentChanged(slotID:Number) {
		clearTimeout(disconnectTimeout);
		disconnectTimeout = setTimeout(Delegate.create(this, Disconnect), 200);
		if (slotID == Controller.m_Controller.settingRealSlot) {
			var SlotAgent:com.GameInterface.AgentSystemAgent = DruidSystem.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (SlotAgent.m_AgentId != Number(currentAgent)) {
					clearTimeout(switchTimeout);
					Agent = string(currentAgent);
					switchTimeout = setTimeout(Delegate.create(this, EquipAgent), 500);
				}
			}
		} else {
			disconnectTimeout = setTimeout(Delegate.create(this, Disconnect), 200);
		}
	}
	public function EquipAgent() {
		if (Agent) {
			var agentID = DruidSystem.GetSwitchAgent(Number(Agent), Controller.m_Controller.settingRealSlot, 0);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
			}
		} else {
			var data:Object = DruidSystem.GetRace(ID);
			var agentID = DruidSystem.GetSwitchAgent(data.Agent, Controller.m_Controller.settingRealSlot, Controller.m_Controller.settingDefaultAgent);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
			}
		}
	}
}