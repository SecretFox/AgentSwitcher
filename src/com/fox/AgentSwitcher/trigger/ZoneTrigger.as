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
		clearTimeout(switchTimeout);
		WaypointInterface.SignalPlayfieldChanged.Disconnect(PlayFieldChanged, this);
		DisconnectAgent();
	}
	private function InRange() {
		return false
	}
	private function DisconnectAgent() {
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
		// If we had druid equipped we want to keep it equipped
		// build will still switch to other agent momentarily, setting the new default agent
		if (currentAgent && DruidSystem.IsDruid(currentAgent) && !Controller.GetInstance().m_Proximity.HasTrigger(2, string(Zone), false)) {
			com.GameInterface.AgentSystem.SignalPassiveChanged.Connect(AgentChanged,this);
			disconnectTimeout = setTimeout(Delegate.create(this, DisconnectAgent), 5000);
		}
	}
	private function EquipBuild() {
		var f:Function = Delegate.create(this, StartedEquip);
		currentAgent = DruidSystem.GetAgentInSlot(Controller.GetInstance().settingRealSlot).m_AgentId;
		Build.AddToQueue(Agent, Age, f);
	}
	private function AgentChanged(slotID:Number) {
		clearTimeout(disconnectTimeout);
		disconnectTimeout = setTimeout(Delegate.create(this, DisconnectAgent), 200);
		if (slotID == Controller.GetInstance().settingRealSlot) {
			var SlotAgent:com.GameInterface.AgentSystemAgent = DruidSystem.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (SlotAgent.m_AgentId != Number(currentAgent)) {
					clearTimeout(switchTimeout);
					Agent = string(currentAgent);
					switchTimeout = setTimeout(Delegate.create(this, EquipAgent), 500);
				}
			}
		}
	}
	public function EquipAgent() {
		if (isBuild){
			DisconnectAgent();
		} else{
			// wait for build to finish swapping (potentially setting new default agent)
			if (Controller.GetInstance().m_Proximity.HasTrigger(2, ID.toString(), true)){
				setTimeout(Delegate.create(this, EquipAgent), 200);
				return
			}
		}
		if (Agent) {
			if (Agent.toLowerCase() == "default"){
				Agent = string(Controller.GetInstance().settingDefaultAgent);
			}
			var agentID = DruidSystem.GetSwitchAgent(Number(Agent), Controller.GetInstance().settingRealSlot, 0);
			if (agentID) {
				DruidSystem.SwitchToAgent(agentID, Controller.GetInstance().settingRealSlot);
			}
		}
	}
}