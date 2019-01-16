import com.GameInterface.WaypointInterface;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.Utils.AgentHelper;
import com.fox.Utils.Builds;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */

 // unused for now
class com.fox.AgentSwitcher.trigger.ZoneTrigger extends BaseTrigger{
	private var Name:String;
	private var Role:String;
	
	public function ZoneTrigger(name:String, build:String, role:String) {
		Name = name;
		Agent = build;
		isBuild = true;
		Role = role;
		WaypointInterface.SignalPlayfieldChanged.Connect(PlayFieldChanged, this);
	}
	private function PlayFieldChanged(playfieldID:Number){
		if (playfieldID == Number(Name) && Builds.IsRightRole(Role)){
			// Task.RemoveTasksByType(Task.BuildTask);
			//var f:Function = Delegate.create(this, EquipBuild)
			//Task.AddTask(Task.BuildTask, f, kill);
			// Zoning appears to remove ongoing cooldowns, so we can instantly complete this
			EquipBuild();
		}
	}
	public function kill(){
		clearTimeout(switchTimeout);
		WaypointInterface.SignalPlayfieldChanged.Disconnect(PlayFieldChanged, this);
		Disconnect();
	}
	private function InRange(){
		return false
	}
	private function Disconnect(){
		clearTimeout(disconnectTimeout);
		com.GameInterface.AgentSystem.SignalPassiveChanged.Disconnect(AgentChanged,this);
	}
	private function EquipBuild(){
		currentAgent = AgentHelper.GetAgentInSlot(Controller.m_Controller.settingRealSlot).m_AgentId;
		if (currentAgent){
			com.GameInterface.AgentSystem.SignalPassiveChanged.Connect(AgentChanged,this);
			disconnectTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
		}
		Builds.EquipBuild(Agent);
	}
	private function AgentChanged(slotID:Number){
		clearTimeout(disconnectTimeout);
		disconnectTimeout = setTimeout(Delegate.create(this, Disconnect), 200);
		if (slotID == Controller.m_Controller.settingRealSlot){
			var SlotAgent:com.GameInterface.AgentSystemAgent = AgentHelper.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (SlotAgent.m_AgentId != Number(currentAgent)){
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
			var agentID = AgentHelper.GetSwitchAgent(Number(Agent), Controller.m_Controller.settingRealSlot, 0);
			if (agentID) {
				AgentHelper.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
			}
		} else {
			var data:Object = AgentHelper.GetRace(ID);
			var agentID = AgentHelper.GetSwitchAgent(data.Agent, Controller.m_Controller.settingRealSlot, Controller.m_Controller.settingDefaultAgent);
			if (agentID) {
				AgentHelper.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
			}
		}
	}
}