import com.Utils.StringUtils;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Proximity;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.data.mobData;
import com.fox.Utils.Debugger;
import com.Utils.ID32;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Targeting {
	private var m_Controller:Controller;
	private var Enabled:Boolean;
	private var m_Proximity:Proximity;
	private var LastName:String = "";
	private var Overrides:Array;

	public function Targeting(cont:Controller) {
		m_Controller = cont;
		m_Proximity = m_Controller.m_Proximity;
	}
	
	public function SetBlacklist(blacklistStr:String) {
		Overrides = [];
		if (!StringUtils.LStrip(blacklistStr)){
			return
		}
		var temp:Array = blacklistStr.toLowerCase().split(",");
		for (var i = 0; i < temp.length; i++) {
			var entry:Array = temp[i].split("|");
			if (!entry[1]) entry.push("none");
			entry[0] = StringUtils.LStrip(entry[0]);
			if (entry[0]){
				Overrides.push(entry);
			}
		}
	}
	
	public function SetState(state:Boolean, state2:Boolean, state3:Boolean) {
		if (!Enabled && (state || state2 || state3)) {
			Enabled = true;
			m_Controller.m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
			LastName = "";
		} else if (Enabled && !state && !state2 && !state3) {
			Enabled = false;
			m_Controller.m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		}
	}
	
	// Returns redirect agent if target is "blacklisted"
	private function IsOverridden(name:String) {
		for (var i = 0; i < Overrides.length; i++) {
			if (name.indexOf(Overrides[i][0]) >= 0) {
				return Overrides[i][1];
			}
		}
	}
	
	private function TargetChanged(id:ID32) {
		if (!id.IsNull()) {
			var data:mobData = DruidSystem.GetRace(id);
			// Debug prints
			if (m_Controller.settingDebugChat || m_Controller.settingDebugFifo){
				var name = data.Name + data.Race;
				if (m_Controller.settingDebugChat && name != LastName) {
					Debugger.PrintText(data.Name + " : " + data.Race);
				}
				if (m_Controller.settingDebugFifo && name != LastName) {
					Debugger.ShowFifo(data.Name + " : " + data.Race, 0);
				}
				LastName = name;
			}
			// Switching
			if (m_Controller.settingTargeting
				&& !m_Controller.m_Player.IsInCombat()
				&& !m_Proximity.inProximity()
			){
				var agent;
				var agent2;
				var override = IsOverridden(data.Name.toLowerCase()); // agent override
				if (!override) {
					agent = DruidSystem.GetSwitchAgent(data.Agent[0], m_Controller.settingRealSlot, m_Controller.settingDefaultAgent);
					agent2 = DruidSystem.GetSwitchAgent(data.Agent[1], m_Controller.settingRealSlot2, m_Controller.settingDefaultAgent2);
				} 
				else if (override.toLowerCase() == "default") {
					agent = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent, m_Controller.settingRealSlot, 0);
					agent2 = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent2, m_Controller.settingRealSlot2, 0);
				} 
				else if (!isNaN(override)) {
					agent = Number(override);
				}
				else {
					for (var i:Number = 0; i < DruidSystem.Druids.length;i++) {
						if (DruidSystem.Druids[i][1].toLowerCase() == override.toLowerCase()) {
							agent = DruidSystem.GetSwitchAgent(DruidSystem.Druids[i][0][0], m_Controller.settingRealSlot, 0);
							agent2 = DruidSystem.GetSwitchAgent(DruidSystem.Druids[i][0][1], m_Controller.settingRealSlot2, 0);
							break
						}
					}
				}
				DruidSystem.SwitchToAgents(agent, agent2, m_Controller);
			}
		}
	}
}