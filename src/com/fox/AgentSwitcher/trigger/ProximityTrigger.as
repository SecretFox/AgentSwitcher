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
class com.fox.AgentSwitcher.trigger.ProximityTrigger{
	private var ID:ID32;
	private var Agent:String;
	private var Range:Number;
	public var Char:Character;
	public var SignalDestruct:Signal;
	public var EnteredRangeSignal:Signal;
	private var refreshInterval:Number;
	
	public function ProximityTrigger(id:ID32, agent:String, range:Number) {
		ID = id;
		Agent = agent;
		Range = range;
		Char = new Character(ID);
		SignalDestruct = new Signal();
	}
	public function kill(){
		Char.SignalCharacterDestructed.Disconnect(Destructed, this);
		clearInterval(refreshInterval);
	}
	public function StartTrigger(){
		Char.SignalCharacterDestructed.Connect(Destructed, this);
		refreshInterval = setInterval(Delegate.create(this, GetRange), Controller.m_Controller.settingUpdateRate);
		GetRange();
	}
	public function SetRefresh(){
		clearInterval(refreshInterval);
		refreshInterval = setInterval(Delegate.create(this, GetRange), Controller.m_Controller.settingUpdateRate);
	}
	private function Destructed(){
		clearInterval(refreshInterval);
		Char.SignalCharacterDestructed.Disconnect(Destructed, this);
		SignalDestruct.Emit(ID);
	}
	private function GetRange(){
		var distance = Char.GetDistanceToPlayer();
		var HP = Char.GetStat(27);
		if (!HP || !distance){
			Destructed();
		}
		if (distance < Range){
			clearInterval(refreshInterval);
			if (!CombatTask.HasTaskType(CombatTask.OutTask)){
				var f:Function = Delegate.create(this, EnteredRange);
				CombatTask.AddTask(CombatTask.OutTask, f);
			}
		}
	}
	public function InRange(){
		if (Char.GetDistanceToPlayer() < Range && Char.GetStat(27)) {
			return true
		}
	}
	public function EnteredRange() {
		if (Agent) {
			var agentID:Number = AgentHelper.StringToID(Agent, Controller.m_Controller.settingDefaultAgent);
			if(agentID){
				agentID = AgentHelper.GetSwitchAgent(agentID, Controller.m_Controller.settingRealSlot, 0);
				if (agentID) {
					AgentHelper.SwitchToAgent(agentID, Controller.m_Controller.settingRealSlot);
				}
			}
		} else {
			var data:Object = AgentHelper.GetRace(ID);
			var agent = AgentHelper.GetSwitchAgent(data.Agent, Controller.m_Controller.settingRealSlot, Controller.m_Controller.settingDefaultAgent);
			if (agent) {
				AgentHelper.SwitchToAgent(agent, Controller.m_Controller.settingRealSlot);
			}
		}
	}
}