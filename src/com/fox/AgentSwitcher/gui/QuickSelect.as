import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.JSeparator;
import GUI.fox.aswing.WindowLayout;
import GUI.fox.aswing.border.LineBorder;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.gui.QuickSelectButton;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.CharacterBase;
import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.SoftBoxLayout;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.QuickSelect {
	private var m_swfRoot:MovieClip;
	private var m_QuickSelect:JFrame;
	private var m_Controller:Controller;
	private var ignoreSettings:Boolean;
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
			ignoreSettings = m_Controller.m_Icon.m_Icon.m_lock._visible;
			CharacterBase.SignalCharacterEnteredReticuleMode.Connect(Close, this);
			m_Controller.settingDval.SetValue(false);
			m_QuickSelect = new JFrame("");
			m_QuickSelect.setIcon(new Icon());
			m_QuickSelect.setBorder(new LineBorder(null,new ASColor(0xFFFFFF,100), 1, 2));
			m_QuickSelect.setResizable(false);
			WindowLayout(m_QuickSelect.getLayout()).getTitleBar().removeFromContainer();
			m_QuickSelect.setX(m_Controller.m_Icon.m_Icon._x);
			m_QuickSelect.setY(m_Controller.m_Icon.m_Icon._y + 30);

			var contentPane = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,2));
			var recentPane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			var quickPane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			for (var i in m_Controller.RecentAgents) {
				var agentID = m_Controller.RecentAgents[i];
				if (AgentSystem.HasAgent(agentID)) {
					var Agent:AgentSystemAgent = AgentSystem.GetAgentById(agentID);
					if (Agent.m_Level >= 25) {
						var AgentButton:QuickSelectButton = new QuickSelectButton(Agent.m_Name)
						AgentButton.SetData(Agent);
						AgentButton.addActionListener(__AgentButtonClicked, this);
						recentPane.append(AgentButton);
					}
				}
			}
			if (m_Controller.RecentAgents.length > 0){
				contentPane.append(recentPane);
				contentPane.append(new JSeparator());
			}
			for (var i = 0; i < DruidSystem.Druids2.length;i ++) {
				for (var y:Number = 0; y < DruidSystem.Druids2[i][0].length; y++){
					if (AgentSystem.HasAgent(DruidSystem.Druids2[i][0][y])) {
						var Agent:AgentSystemAgent = AgentSystem.GetAgentById(DruidSystem.Druids2[i][0][y]);
						if (Agent.m_Level == 50) {
							var AgentButton:QuickSelectButton;
							if (!m_Controller.settingQuickselectName){
								if (y == 0){
									AgentButton = new QuickSelectButton(DruidSystem.Druids2[i][1]);
								}else{
									AgentButton = new QuickSelectButton(DruidSystem.Druids2[i][1]+(y+1));
								}
							}
							else AgentButton = new QuickSelectButton(Agent.m_Name);
							AgentButton.SetData(Agent);
							AgentButton.addActionListener(__AgentButtonClicked, this);
							quickPane.append(AgentButton);
						}
					}
				}
			}
			contentPane.append(quickPane);
			m_QuickSelect.setContentPane(contentPane);
			m_QuickSelect.pack();
			m_QuickSelect.show();
			m_QuickSelect.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
			m_QuickSelect.tryToClose = Delegate.create(this,Close);
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
		if (m_Controller.settingDisableOnSwitch && !ignoreSettings) {
			m_Controller.settingTargeting = false;
			m_Controller.SettingChanged();
			//m_Controller.m_Icon.StateChanged(false);
		}
		button.CloseTooltip();
		QuickSelectStateChanged(true);
	}
}