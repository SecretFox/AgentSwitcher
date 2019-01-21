import com.fox.AgentSwitcher.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.WaypointInterface;
import com.fox.Utils.Debugger;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */

class com.fox.AgentSwitcher.trigger.ZoneTrigger extends BaseTrigger {
	private var Zone:Number;
	private var Role:String;

	public function ZoneTrigger(zone:String, build:String, role:String, isbuild:Boolean) {
		Zone = Number(zone);
		Agent = build;
		isBuild = isbuild;
		Role = role;
	}
	public function StartTrigger() {
		WaypointInterface.SignalPlayfieldChanged.Connect(PlayFieldChanged, this);
	}
	public function kill() {
		WaypointInterface.SignalPlayfieldChanged.Disconnect(PlayFieldChanged, this);
		clearTimeout(switchTimeout);
		Disconnect();
	}
	private function InRange() {
		return false
	}
	private function Disconnect() {
		clearTimeout(disconnectTimeout);
		com.GameInterface.AgentSystem.SignalPassiveChanged.Disconnect(AgentChanged,this);
	}
	private function PlayFieldChanged(playfieldID:Number) {
		if (playfieldID == Zone && Player.IsRightRole(Role)) {
			StartEquip();
		}
	}
	private function StartEquip() {
		var f2:Function = Delegate.create(this, kill);
		if (!isBuild) {
			Task.RemoveTasksByType(Task.OutCombatTask);
			var f:Function = Delegate.create(this, EquipAgent);
			Task.AddTask(Task.OutCombatTask, f, f2);
		} 
		else {
			var time:Date = new Date();
			Age = time.valueOf();
			// Trying to get agent before inPlay crashes the game
			// Actual equip action will also have separate check for cooldowns, inPlay, casting, Combat
			var f:Function = Delegate.create(this, EquipBuild);
			Task.AddTask(Task.inPlayTask, f, f2);
		}
	}
	private function StartedEquip():Void {
		if (currentAgent && DruidSystem.IsDruid(currentAgent)) {
			com.GameInterface.AgentSystem.SignalPassiveChanged.Connect(AgentChanged,this);
			disconnectTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
		}
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
		}
	}
}