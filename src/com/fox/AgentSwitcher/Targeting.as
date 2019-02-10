import com.Utils.StringUtils;
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
	private var Blacklist:Array;

	public function Targeting(cont:Controller) {
		m_Controller = cont;
		m_Player = Player.GetPlayer();
		m_Proximity = m_Controller.m_Proximity;
	}
	
	public function SetBlacklist(blacklistStr:String) {
		Blacklist = new Array();
		if (!StringUtils.LStrip(blacklistStr)){
			return
		}
		var temp:Array = blacklistStr.toLowerCase().split(",");
		for (var i = 0; i < temp.length; i++) {
			var entry:Array = temp[i].split("|");
			if (!entry[1]) entry.push("none");
			entry[0] = StringUtils.LStrip(entry[0]);
			Blacklist.push(entry);
		}
	}
	
	public function SetState(state:Boolean, state2:Boolean, state3:Boolean) {
		if (!Enabled && (state || state2 || state3)) {
			Enabled = true;
			m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
			LastName = "";
		} else if (Enabled && !state && !state2 && !state3) {
			Enabled = false;
			m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		}
	}
	
	private function IsBlacklisted(name:String) {
		for (var i = 0; i < Blacklist.length; i++) {
			if (name.indexOf(Blacklist[i][0]) >= 0) {
				return Blacklist[i][1];
			}
		}
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
			if (m_Controller.settingTargeting && !m_Player.IsInCombat() && !m_Proximity.inProximity()) {
				var agent;
				var blacklist = IsBlacklisted(data.Name.toLowerCase());
				if (!blacklist) {
					agent = DruidSystem.GetSwitchAgent(data.Agent, m_Controller.settingRealSlot, m_Controller.settingDefaultAgent);
				} else if (blacklist.toLowerCase() == "default") {
					agent = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent, m_Controller.settingRealSlot, 0);
				} else {
					for (var i in DruidSystem.Druids) {
						if (DruidSystem.Druids[i][1].toLowerCase() == blacklist.toLowerCase()) {
							agent = DruidSystem.GetSwitchAgent(DruidSystem.Druids[i][0], m_Controller.settingRealSlot, 0);
							break
						}
					}
				}
				if (agent) {
					DruidSystem.SwitchToAgent(agent, m_Controller.settingRealSlot);
				}
			}
		}
	}
}