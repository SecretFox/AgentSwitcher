import com.GameInterface.Game.Character;
import com.Utils.ID32;
import com.Utils.Signal;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.Utils.AgentHelper;
import com.fox.Utils.Builds;
import com.fox.Utils.Task;
import mx.utils.Delegate;
/**
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.KillTrigger extends BaseTrigger{
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
		if (!Agent) data = AgentHelper.GetRace(ID);
		isBuild = isbuild;
	}
	private function TargetDied(){
		if (!isBuild){
			if(!Task.HasTaskType(Task.OutCombatTask)){
				var f:Function = Delegate.create(this, EquipAgent)
				Task.AddTask(Task.OutCombatTask, f, kill);
			}
		} 
		else {
			Task.RemoveTasksByType(Task.BuildTask);
			var f:Function = Delegate.create(this, EquipBuild)
			Task.AddTask(Task.BuildTask, f, kill);
		}
	}
	public function kill(){
		Disconnect();
		clearTimeout(switchTimeout);
		Char.SignalCharacterDied.Disconnect(TargetDied, this);
		Char.SignalCharacterDestructed.Disconnect(TargetDestructed, this);
	}
	private function EquipAgent(){
		if(Agent){
			var agentID = AgentHelper.GetSwitchAgent(Number(Agent), Controller.m_Controller.settingRealSlot, 0);
			if (agentID){
				AgentHelper.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
			}
		}
		//it's probably pointless to run onKill without override,but might as well allow it
		else{
			var agent = AgentHelper.GetSwitchAgent(data.Agent, Controller.m_Controller.settingRealSlot, 0);
			if (agent) {
				AgentHelper.SwitchToAgent(agent, Controller.m_Controller.settingRealSlot);
			}
		}
		SignalLock.Emit();
		SignalDestruct.Emit(ID);
	}

	
	private function EquipBuild(){
		// Changing build can also changes agents
		// Switch back druid agent if it gets changed
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
	private function Disconnect(){
		clearTimeout(disconnectTimeout);
		com.GameInterface.AgentSystem.SignalPassiveChanged.Disconnect(AgentChanged,this);
	}
	
	private function InRange(){
		return false
	}
	
	private function TargetDestructed(){
		Char.SignalCharacterDied.Disconnect(TargetDied, this);
		Char.SignalCharacterDestructed.Disconnect(TargetDestructed, this);
		SignalDestruct.Emit(ID);
	}
}