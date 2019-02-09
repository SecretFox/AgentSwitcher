import com.fox.AgentSwitcher.Defaulting;
import com.fox.AgentSwitcher.Proximity;
import com.fox.AgentSwitcher.Targeting;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Settings;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.gui.AgentDisplay;
import com.fox.AgentSwitcher.gui.Icon;
import com.fox.AgentSwitcher.gui.SettingsWindow;
import com.fox.AgentSwitcher.gui.QuickSelect;
import GUI.fox.aswing.TswLookAndFeel;
import GUI.fox.aswing.ASWingUtils;
import GUI.fox.aswing.UIManager;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.DistributedValue;
import com.GameInterface.Game.CharacterBase;
import com.Utils.Archive;
import com.Utils.GlobalSignal;
/*
*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Controller extends Settings {
	private static var m_Controller:Controller;
	public var m_settings:SettingsWindow;
	public var m_AgentDisplay:AgentDisplay;
	public var m_QuickSelect:QuickSelect;
	public var m_Icon:Icon;
	private var m_settingsRoot:MovieClip;
	public var m_Default:Defaulting;
	public var m_Proximity:Proximity;
	public var m_Targeting:Targeting;
	public var m_Player:Player;

	public static function main(swfRoot:MovieClip):Void {
		var m_controller = new Controller(swfRoot);
		swfRoot.onLoad =  function() {return m_controller.Load()};
		swfRoot.onUnload =  function() {return m_controller.Unload()};
		swfRoot.OnModuleActivated = function(config:Archive) {m_controller.Activate(config)};
		swfRoot.OnModuleDeactivated = function() {return m_controller.Deactivate()};
	}

	public function Controller(swfRoot:MovieClip) {
		super(swfRoot);
		m_Controller = this;
		m_Player = new Player();
		m_Icon = new Icon(m_swfRoot, this);
		m_AgentDisplay = new AgentDisplay(m_swfRoot, this);
		m_QuickSelect = new QuickSelect(m_swfRoot, this);
		m_Proximity = new Proximity(this);
		m_Default = new Defaulting(this);
		m_Targeting = new Targeting(this);
	}

	public static function GetInstance():Controller {
		return m_Controller;
	}

	public function Load():Void {
		//ASWING
		m_settingsRoot = m_swfRoot.createEmptyMovieClip("m_settingsRoot", m_swfRoot.getNextHighestDepth());
		ASWingUtils.setRootMovieClip(m_settingsRoot);
		var laf:TswLookAndFeel = new TswLookAndFeel();
		UIManager.setLookAndFeel(laf);

		// Settings window
		settingDval.SignalChanged.Connect(OpenSettings, this);

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

		// Agents
		agentDisplayDval.SignalChanged.Disconnect(m_AgentDisplay.DisplayAgents, m_AgentDisplay);
		AgentSystem.SignalPassiveChanged.Disconnect(SlotPassiveChanged, this);

		GlobalSignal.SignalSetGUIEditMode.Disconnect(ToggleGuiEdits, this);
	}

	public function Activate(config:Archive) {
		if (!Loaded){
			LoadConfig(config);
			SettingChanged();
			m_Icon.CreateTopIcon(iconPos);
			m_AgentDisplay.SlotChanged();
			m_Targeting.SetBlacklist(settingBlacklist);
			ApplyPause();
		}
	}

	public function Deactivate():Archive {
		return SaveConfig();
	}

	private function OpenSettings(dv:DistributedValue) {
		if (dv.GetValue()) {
			m_AgentDisplay.Hide();
			m_settings.dispose();
			m_QuickSelect.QuickSelectStateChanged(true);
			m_settings = new SettingsWindow(iconPos, this);
			CharacterBase.SignalCharacterEnteredReticuleMode.Connect(CloseSettings, this);
		} else {
			if (agentDisplayDval.GetValue()) m_AgentDisplay.Show();
			m_settings.dispose();
			m_settings = undefined;
			CharacterBase.SignalCharacterEnteredReticuleMode.Disconnect(CloseSettings, this);
		}
	}

	private function CloseSettings() {
		if (m_settings) {
			m_settings.tryToClose();
		}
	}

	private function ToggleGuiEdits(state:Boolean) {
		if (state) {
			settingDval.SetValue(false);
			m_QuickSelect.QuickSelectStateChanged(true);
			m_Icon.GuiEdit(true);
			m_AgentDisplay.GuiEdit(true);
		} else {
			m_AgentDisplay.GuiEdit(false);
			m_Icon.GuiEdit(false);
		}
	}

	private function SlotPassiveChanged(slotID:Number) {
		if (!settingPause && slotID == settingRealSlot) {
			var SlotAgent:AgentSystemAgent = DruidSystem.GetAgentInSlot(slotID);
			if (SlotAgent) {
				if (settingDefaultAgent != SlotAgent.m_AgentId && !DruidSystem.IsDruid(SlotAgent.m_AgentId)) {
					settingDefaultAgent = SlotAgent.m_AgentId;
					m_Proximity.GetProximitylistCopy();
					var found:Boolean;
					for (var i in RecentAgents) {
						if (RecentAgents[i] == SlotAgent.m_AgentId) {
							found = true;
							break
						}
					}
					if (!found) {
						if (RecentAgents.length == 3) RecentAgents.shift();
						RecentAgents.push(settingDefaultAgent);
					}
				}
			}
		}
	}

	public function ReloadProximityList() {
		if (settingProximityEnabled && !settingPause) {
			m_Proximity.ReloadProximityList();
		}
	}

	public function ApplyPause() {
		if (settingPause) {
			m_Targeting.SetState(false, false, false);
			m_Default.SetState(false);
			m_Proximity.SetState(false);
		} else {
			SettingChanged();
			SlotPassiveChanged(settingRealSlot);
		}
	}

	public function SettingChanged() {
		if (!settingPause) {
			m_Targeting.SetState(settingTargeting, settingDebugChat, settingDebugFifo);
			m_Default.SetState(settingDefault);
			m_Proximity.SetState(settingProximityEnabled);
		}
	}
}