import com.GameInterface.Game.Character;
import com.Utils.ID32;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Proximity;
import com.fox.Utils.AgentHelper;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Targeting{
	private var m_Controller:Controller;
	private var m_Player:Character;
	private var m_Proximity:Proximity;
	private var Enabled:Boolean;
	private var DebugEnabled:Boolean;
	private var LastSelectedName:String = "";
	private var LastSelectedRace:String = "";

	public function Targeting(cont:Controller, player:Character) {
		m_Controller = cont;
		m_Player = player;
		m_Proximity = m_Controller.m_Proximity
	}
	public function SetState(state:Boolean, state2:Boolean){
		Enabled = state;
		DebugEnabled = state2
		if (Enabled || DebugEnabled){
			m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
			LastSelectedName = "";
			LastSelectedRace = "";
		}else{
			m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		}
	}
	private function TargetChanged(id:ID32) {
		if (!id.IsNull()) {
			var data:Object = AgentHelper.GetRace(id);
			if (DebugEnabled && data.Name + data.Race != LastSelectedName + LastSelectedRace) {
				com.GameInterface.UtilsBase.PrintChatText(data.Name + " : " + data.Race);
			}
			LastSelectedName = data.Name;
			LastSelectedRace = data.Race;
			if (!Enabled) return;
			if (!m_Player.IsInCombat() && !m_Proximity.Lock && !m_Proximity.inProximity()) {
				var agent = AgentHelper.GetSwitchAgent(data.Agent, m_Controller.settingRealSlot, m_Controller.settingDefaultAgent);
				if (agent) {
					AgentHelper.SwitchToAgent(agent, m_Controller.settingRealSlot);
				}
			}
		}
	}
}