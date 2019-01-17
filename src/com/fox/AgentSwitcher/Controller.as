import com.GameInterface.AgentSystem;
import com.GameInterface.DistributedValue;
import com.GameInterface.Game.CharacterBase;
import com.Utils.Archive;
import com.Utils.GlobalSignal;
import com.fox.AgentSwitcher.gui.AgentDisplay;
import com.fox.AgentSwitcher.gui.Icon;
import com.fox.AgentSwitcher.gui.SettingsWindow;
import com.fox.AgentSwitcher.gui.QuickSelect;
import GUI.fox.aswing.TswLookAndFeel;
import GUI.fox.aswing.ASWingUtils;
import GUI.fox.aswing.UIManager;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.Character;
import com.fox.AgentSwitcher.Defaulting;
import com.fox.AgentSwitcher.Proximity;
import com.fox.AgentSwitcher.Targeting;
import com.fox.Utils.AgentHelper;
import com.fox.AgentSwitcher.Settings;
/*
*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Controller extends Settings{
	static var m_Controller:Controller;
	public var m_settings:SettingsWindow;
	public var m_AgentDisplay:AgentDisplay;
	public var m_QuickSelect:QuickSelect;
	public var m_Icon:Icon;
	private var m_settingsRoot:MovieClip;
	public var m_Default:Defaulting;
	public var m_Proximity:Proximity;
	public var m_Targeting:Targeting;
	public var m_Player:Character;

	public function Controller(swfRoot:MovieClip){
		super(swfRoot);
		m_Controller = this;
		m_Icon = new Icon(m_swfRoot, this);
		m_Player = Character.GetClientCharacter();
		m_AgentDisplay = new AgentDisplay(m_swfRoot, this);
		m_QuickSelect = new QuickSelect(m_swfRoot, this);
		m_Proximity = new Proximity(this);
		m_Default = new Defaulting(this, m_Player);
		m_Targeting = new Targeting(this, m_Player);	
	}
	
	public function Load():Void {
		//ASWING
		m_settingsRoot = m_swfRoot.createEmptyMovieClip("m_settingsRoot", m_swfRoot.getNextHighestDepth());
		ASWingUtils.setRootMovieClip(m_settingsRoot);
		var laf:TswLookAndFeel = new TswLookAndFeel();
		UIManager.setLookAndFeel(laf);
		
		// Settings window
		settingDval.SignalChanged.Connect(OpenSettings, this);
		CharacterBase.SignalCharacterEnteredReticuleMode.Connect(CloseSettings, this);
		
		// Agents
		agentDisplayDval.SignalChanged.Connect(m_AgentDisplay.DisplayAgents, m_AgentDisplay);
		AgentSystem.SignalPassiveChanged.Connect(SlotPassiveChanged, this);
		
		GlobalSignal.SignalSetGUIEditMode.Connect(ToggleGuiEdits, this);
	}
	
	public function Unload():Void {
		//ASWING
		m_settingsRoot.removeMovieClip();
		
		// Settings window
		settingDval.SignalChanged.Disconnect(OpenSettings, this);
		CharacterBase.SignalCharacterEnteredReticuleMode.Disconnect(CloseSettings, this);
		
		// Agents
		agentDisplayDval.SignalChanged.Disconnect(m_AgentDisplay.DisplayAgents, m_AgentDisplay);
		AgentSystem.SignalPassiveChanged.Disconnect(SlotPassiveChanged, this);
		
		GlobalSignal.SignalSetGUIEditMode.Disconnect(ToggleGuiEdits, this);
	}
	
	public function Activate(config:Archive){
		LoadConfigs(config);
		SettingChanged();
		m_Icon.CreateTopIcon(iconPos, settingEnabled);
		m_AgentDisplay.SlotChanged();
	}
	
	public function Deactivate():Archive{
		var conf:Archive = SaveConfigs();
		return conf
	}
	
	private function OpenSettings(dv:DistributedValue) {
		if (dv.GetValue()) {
			m_AgentDisplay.Hide();
			m_settings.dispose();
			m_QuickSelect.QuickSelectStateChanged(true);
			m_settings = new SettingsWindow(iconPos, this);
		} else {
			if (agentDisplayDval.GetValue()) m_AgentDisplay.Show();
			m_settings.dispose();
		}
	}

	private function CloseSettings() {
		if (m_settings){
			m_settings.tryToClose();
		}
	}
	
	private function ToggleGuiEdits(state:Boolean){
		if (state){
			settingDval.SetValue(false);
			m_QuickSelect.QuickSelectStateChanged(true);
			m_Icon.GuiEdit(true);
			m_AgentDisplay.GuiEdit(true);
		}else{
			m_AgentDisplay.GuiEdit(false);
			m_Icon.GuiEdit(false);
		}
	}
	
	private function SlotPassiveChanged(slotID:Number) {
		if (slotID == settingRealSlot) {
			var SlotAgent:AgentSystemAgent = AgentHelper.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (settingDefaultAgent != SlotAgent.m_AgentId && !AgentHelper.IsDruid(SlotAgent.m_AgentId)) {
					settingDefaultAgent = SlotAgent.m_AgentId;
					m_Proximity.GetProximitylistCopy();
					var found;
					for (var i in RecentAgents) {
						if (RecentAgents[i] == SlotAgent.m_AgentId) found = true;
					}
					if (!found) {
						if (RecentAgents.length == 3) RecentAgents.shift();
						RecentAgents.push(settingDefaultAgent);
					}
				}
			}
		}
	}
	
	public function ReloadProximityList(){
		if (settingProximityEnabled){
			m_Proximity.ReloadProximityList();
		}
	}

	public function SettingChanged(){
		m_Targeting.SetState(settingEnabled, settingDebugChat, settingDebugFifo);
		m_Default.SetState(settingDefault);
		m_Proximity.SetState(settingProximityEnabled);
	}
}