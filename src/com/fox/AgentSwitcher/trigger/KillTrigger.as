import com.GameInterface.Game.Character;
import com.Utils.ID32;
import com.Utils.Signal;
import com.fox.AgentSwitcher.Controller;
import com.fox.Utils.AgentHelper;
import com.fox.Utils.CombatTask;
import mx.utils.Delegate;
/**
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.KillTrigger{
	private var ID:ID32;
	private var char:Character;
	private var Agent:String;
	private var data:Object;
	public var SignalDestruct:Signal;
	public var SignalLock:Signal;
	
	public function KillTrigger(id:ID32, agent:String) {
		ID = id;
		Agent = agent;
		SignalDestruct = new Signal();
		SignalLock = new Signal();
		char = new Character(id);
		char.SignalCharacterDied.Connect(TargetDied, this);
		char.SignalCharacterDestructed.Connect(TargetDestructed, this);
		if (!Agent) data = AgentHelper.GetRace(ID);
	}
	private function TargetDied(){
		if (!CombatTask.HasTaskType(CombatTask.OutTask)){
			var f:Function = Delegate.create(this, EquipAgent)
			CombatTask.AddTask(CombatTask.OutTask, f);
			//Combat helper should keep reference to this class, so it wont get garbage collected (due to destruction)before switching agent
		}
	}
	public function kill(){
		char.SignalCharacterDied.Disconnect(TargetDied, this);
		char.SignalCharacterDestructed.Disconnect(TargetDestructed, this);
	}
	private function EquipAgent(){
		if(Agent){
			var AgentID = AgentHelper.StringToID(Agent, Controller.m_Controller.settingDefaultAgent);
				if (AgentID){
					AgentID = AgentHelper.GetSwitchAgent(AgentID, Controller.m_Controller.settingRealSlot, 0);
					if (AgentID){
						AgentHelper.SwitchToAgent(AgentID, Controller.m_Controller.settingRealSlot);
					}
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
	private function TargetDestructed(){
		char.SignalCharacterDied.Disconnect(TargetDied, this);
		char.SignalCharacterDestructed.Disconnect(TargetDestructed, this);
		SignalDestruct.Emit(ID);
	}
}