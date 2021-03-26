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
	public var m_QuickWindow:JFrame;
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
	public function QuickSelectStateChanged(forceClose:Boolean, agentDisplay:Boolean) {
		if (m_QuickWindow || forceClose) {
			m_QuickWindow.dispose();
			m_QuickWindow = undefined;
		} else {
			ignoreSettings = m_Controller.m_Icon.m_IconClip.m_lock._visible;
			CharacterBase.SignalCharacterEnteredReticuleMode.Connect(Close, this);
			m_Controller.settingDval.SetValue(false);
			m_QuickWindow = new JFrame("");
			m_QuickWindow.setIcon(new Icon());
			m_QuickWindow.setBorder(new LineBorder(null,new ASColor(0xFFFFFF,100), 1, 2));
			m_QuickWindow.setResizable(false);
			WindowLayout(m_QuickWindow.getLayout()).getTitleBar().removeFromContainer();
			var TargetClip:MovieClip = agentDisplay ? m_Controller.m_AgentDisplay.m_Display : m_Controller.m_Icon.m_IconClip;
			
			m_QuickWindow.setX(TargetClip._x);
			m_QuickWindow.setY(TargetClip._y + 30);	
			
			var contentPane = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,2));
			var recentPane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			var quickPane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			var found;
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
			for (var i = 0; i < DruidSystem.Druids.length;i ++) {
				for (var y:Number = 0; y < DruidSystem.Druids[i][0].length; y++){
					if (AgentSystem.HasAgent(DruidSystem.Druids[i][0][y])){
						var Agent:AgentSystemAgent = AgentSystem.GetAgentById(DruidSystem.Druids[i][0][y]);
						if (Agent.m_Level == 50) {
							found = true;
							var AgentButton:QuickSelectButton;
							if (!m_Controller.settingQuickselectName){
								if (y == 0){
									AgentButton = new QuickSelectButton(DruidSystem.Druids[i][1]);
								}
								else{
									AgentButton = new QuickSelectButton(DruidSystem.Druids[i][1]+(y+1));
								}
							}
							else AgentButton = new QuickSelectButton(Agent.m_Name);
							AgentButton.SetData(Agent);
							AgentButton.addActionListener(__AgentButtonClicked, this);
							quickPane.append(AgentButton);
							break
						}
					}
				}
			}
			
			contentPane.append(quickPane);
			m_QuickWindow.setContentPane(contentPane);
			m_QuickWindow.pack();
			m_QuickWindow.show();
			m_QuickWindow.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
			m_QuickWindow.tryToClose = Delegate.create(this, Close);
			if (TargetClip._y > Stage.height / 2) {
				m_QuickWindow.setY(TargetClip._y - 5 - m_QuickWindow.getHeight());
			}
			if (TargetClip._x > Stage.width / 2) {
				m_QuickWindow.setX(TargetClip._x - 5 - m_QuickWindow.getWidth());
			}
			if (!found) QuickSelectStateChanged(true);
		}
	}
	
	private function __AgentButtonClicked(button:QuickSelectButton) {
		var agentID:Number = button.AgentData.m_AgentId;
		var agentArray:Array;
		for (var i in DruidSystem.Druids){
			for (var y in DruidSystem.Druids[i][0]){
				if (DruidSystem.Druids[i][0][y] == agentID) {
					agentArray = DruidSystem.Druids[i][0];
					break
				}
			}
		}
		if (!agentArray) agentArray = [agentID];
		var agent = DruidSystem.GetSwitchAgent(agentArray[0], m_Controller.settingRealSlot, m_Controller.settingDefaultAgent);
		var agent2 = DruidSystem.GetSwitchAgent(agentArray[1], m_Controller.settingRealSlot2, m_Controller.settingDefaultAgent2);
		DruidSystem.SwitchToAgents(agent, agent2, m_Controller);
		if (m_Controller.settingDisableOnSwitch && !ignoreSettings) {
			m_Controller.settingTargeting = false;
			m_Controller.ApplySettings();
		}
		button.CloseTooltip();
		QuickSelectStateChanged(true);
	}
}