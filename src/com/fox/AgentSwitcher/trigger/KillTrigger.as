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
class com.fox.AgentSwitcher.trigger.KillTrigger extends BaseTrigger {
	private var data:Object;
	public var SignalLock:Signal;

	public function KillTrigger(id:ID32, agent:String, isbuild:Boolean) {
		super();
		ID = id;
		Agent = agent;
		SignalDestruct = new Signal();
		SignalLock = new Signal();
		Char = new Character(id);
		Char.SignalCharacterDied.Connect(TargetDied, this);
		Char.SignalCharacterDestructed.Connect(TargetDestructed, this);
		if (!Agent) data = DruidSystem.GetRace(ID);
		isBuild = isbuild;
	}
	
	private function TargetDied() {
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
	
	private function InRange() {
		return false
	}

	private function TargetDestructed() {
		Char.SignalCharacterDied.Disconnect(TargetDied, this);
		Char.SignalCharacterDestructed.Disconnect(TargetDestructed, this);
		SignalDestruct.Emit(ID);
	}
	
	public function kill() {
		Disconnect();
		clearTimeout(switchTimeout);
		Char.SignalCharacterDied.Disconnect(TargetDied, this);
		Char.SignalCharacterDestructed.Disconnect(TargetDestructed, this);
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
	
	private function EquipAgent() {
		if (Agent) {
			var agentID = DruidSystem.GetSwitchAgent(Number(Agent), Controller.m_Controller.settingRealSlot, 0);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
			}
		}
		//it's probably pointless to run onKill without override,but might as well allow it
		else {
			var agent = DruidSystem.GetSwitchAgent(data.Agent, Controller.m_Controller.settingRealSlot, 0);
			if (agent) {
				DruidSystem.SwitchToAgent(agent, Controller.m_Controller.settingRealSlot);
			}
		}
		SignalLock.Emit();
		SignalDestruct.Emit(ID);
	}
}