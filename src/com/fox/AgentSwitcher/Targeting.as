import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Proximity;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.Utils.Debugger;
import com.GameInterface.Game.Character;
import com.Utils.ID32;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Targeting {
	private var m_Controller:Controller;
	private var m_Player:Character;
	private var Enabled:Boolean;
	private var m_Proximity:Proximity;
	private var LastName:String = "";
	private var Blacklist:Array = [];

	public function Targeting(cont:Controller) {
		m_Controller = cont;
		m_Player = Player.GetPlayer();
		m_Proximity = m_Controller.m_Proximity;
	}
	public function SetBlacklist(blacklistStr:String){
		Blacklist = blacklistStr.toLowerCase().split(",");
	}
	public function SetState(state:Boolean, state2:Boolean, state3:Boolean) {
		if (!Enabled && (state || state2 || state3)) {
			Enabled = true;
			m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
			LastName = "";
		}
		else if (Enabled && !state && !state2 && !state3){
			Enabled = false;
			m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		}
	}
	private function IsBlacklisted(name:String){
		for (var i in Blacklist){
			if (name.indexOf(Blacklist[i]) >= 0){
				return true
			}
		}
		return false
	}
	private function TargetChanged(id:ID32) {
		if (!id.IsNull()) {
			var data:Object = DruidSystem.GetRace(id);
			var name = data.Name + data.Race;
			if (m_Controller.settingDebugChat && name != LastName) {
				Debugger.PrintText(data.Name + " : " + data.Race);
			}
			if (m_Controller.settingDebugFifo && name != LastName) {
				Debugger.ShowFifo(data.Name + " : " + data.Race, 0);
			}
			LastName = name;
			if (m_Controller.settingTargeting && !IsBlacklisted(data.Name.toLowerCase()) && !m_Player.IsInCombat() && !m_Proximity.inProximity()) {
				var agent = DruidSystem.GetSwitchAgent(data.Agent, m_Controller.settingRealSlot, m_Controller.settingDefaultAgent);
				if (agent) {
					DruidSystem.SwitchToAgent(agent, m_Controller.settingRealSlot);
				}
			}
		}
	}
}