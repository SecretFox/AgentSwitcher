import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.gui.QuickSelectButton;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.CharacterBase;
import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.JPopup;
import GUI.fox.aswing.SoftBoxLayout;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.QuickSelect {
	private var m_swfRoot:MovieClip;
	private var m_QuickSelect:JPopup;
	private var m_Controller:Controller;
	public function QuickSelect(root:MovieClip, cont:Controller) {
		m_swfRoot = root;
		m_Controller = cont;
	}
	private function Close() {
		CharacterBase.SignalCharacterEnteredReticuleMode.Disconnect(Close, this);
		QuickSelectStateChanged(true);
	}
//QuickSelect
	public function QuickSelectStateChanged(forceClose:Boolean) {
		if (m_QuickSelect || forceClose) {
			m_QuickSelect.dispose();
			m_QuickSelect = undefined;
		} else {
			CharacterBase.SignalCharacterEnteredReticuleMode.Connect(Close, this);
			m_Controller.settingDval.SetValue(false);
			m_QuickSelect = new JPopup();
			m_QuickSelect.setX(m_Controller.m_Icon.m_Icon._x);
			m_QuickSelect.setY(m_Controller.m_Icon.m_Icon._y + m_Controller.m_Icon.m_Icon._height + 5);

			var panel:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			for (var i in m_Controller.RecentAgents) {
				var agentID = m_Controller.RecentAgents[i];
				if (AgentSystem.HasAgent(agentID)) {
					var Agent:AgentSystemAgent = AgentSystem.GetAgentById(agentID);
					if (Agent.m_Level >= 25) {
						var AgentButton:QuickSelectButton = new QuickSelectButton(Agent.m_Name)
						AgentButton.SetData(Agent);
						AgentButton.addActionListener(__AgentButtonClicked, this);
						panel.append(AgentButton);
					}
				}
			}
			for (var i in DruidSystem.Druids) {
				if (AgentSystem.HasAgent(DruidSystem.Druids[i][0])) {
					var Agent:AgentSystemAgent = AgentSystem.GetAgentById(DruidSystem.Druids[i][0]);
					if (Agent.m_Level == 50) {
						var AgentButton:QuickSelectButton;
						if (!m_Controller.settingQuickselectName) AgentButton = new QuickSelectButton(DruidSystem.Druids[i][1])
							else AgentButton = new QuickSelectButton(Agent.m_Name)
								AgentButton.SetData(Agent);
						AgentButton.addActionListener(__AgentButtonClicked, this);
						panel.append(AgentButton);
					}
				}
			}
			m_QuickSelect.append(panel);
			m_QuickSelect.pack();
			m_QuickSelect.setVisible(true);
			if (m_Controller.m_Icon.m_Icon._y > Stage.height / 2) {
				m_QuickSelect.setY(m_Controller.m_Icon.m_Icon._y - 5 - m_QuickSelect.getHeight());
			}
			if (m_Controller.m_Icon.m_Icon._x > Stage.width / 2) {
				m_QuickSelect.setX(m_Controller.m_Icon.m_Icon._x - 5 - m_QuickSelect.getWidth());
			}
		}
	}
	private function __AgentButtonClicked(button:QuickSelectButton) {
		var id = DruidSystem.GetSwitchAgent(button.AgentData.m_AgentId, m_Controller.settingRealSlot, 0);
		if (id) {
			DruidSystem.SwitchToAgent(button.AgentData.m_AgentId, m_Controller.settingRealSlot);
		}
		if (m_Controller.settingDisableOnSwitch) {
			m_Controller.settingEnabled = false;
			m_Controller.SettingChanged();
			m_Controller.m_Icon.StateChanged(false);
		}
		button.CloseTooltip();
		QuickSelectStateChanged(true);
	}
}