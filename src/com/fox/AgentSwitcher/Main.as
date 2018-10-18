import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.JPopup;
import GUI.fox.aswing.SoftBoxLayout;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.DistributedValue;
import com.GameInterface.Game.Character;
import com.GameInterface.Game.CharacterBase;
import com.Utils.Archive;
import com.Utils.Colors;
import com.Utils.Draw;
import com.Utils.GlobalSignal;
import com.Utils.ID32;
import com.fox.AgentSwitcher.AgentDisplay;
import com.fox.AgentSwitcher.AgentHelper;
import com.fox.AgentSwitcher.QuickSelectButton;
import com.fox.AgentSwitcher.Settings;
import flash.geom.Point;
import com.fox.Utils.Common;
import mx.utils.Delegate;
import GUI.fox.aswing.TswLookAndFeel;
import GUI.fox.aswing.ASWingUtils;
import GUI.fox.aswing.UIManager;
/**
 * ...
 * @author fox
 */

class com.fox.AgentSwitcher.Main {
	public var DebugDval:DistributedValue;
	public var SlotDval:DistributedValue;
	public var SwitchDval:DistributedValue;
	public var DefaultDelayDval:DistributedValue;
	public var OpenSettingsDval:DistributedValue;
	public var DisplayDval:DistributedValue;
	public var ActiveDval:DistributedValue;

	private var DefaultAgent:Number;
	private var m_Player:Character;

	private var DestinationSlot:Number;
	private var DefaultTimeout;
	private var LastSelectedName:String;
	private var LastSelectedRace:String;
	
	private var m_swfRoot:MovieClip;
	private var m_settingsRoot:MovieClip;
	private var m_AgentDisplay:AgentDisplay;
	private var m_settings:Settings;
	private var m_Icon:MovieClip;
	private var iconPos:Point;
	private var DisplayPos:Point;
	private var QuickSelect:JPopup;
	private var RecentAgents:Array;
	

	public static function main(swfRoot:MovieClip):Void {
		var s_app = new Main(swfRoot);
		swfRoot.onLoad =  function() {return s_app.Load()};
		swfRoot.onUnload =  function() {return s_app.Unload()};
		swfRoot.OnModuleActivated = function(config:Archive) {s_app.LoadSettings(config)};
		swfRoot.OnModuleDeactivated = function() {return s_app.SaveSettings()};
	}

	public function Main(root) {
		m_swfRoot = root;
		DebugDval = DistributedValue.Create("AgentSwitcher_Debug");
		SlotDval = DistributedValue.Create("AgentSwitcher_Slot");
		SwitchDval = DistributedValue.Create("AgentSwitcher_DefaultOnCombatEnd");
		DefaultDelayDval = DistributedValue.Create("AgentSwitcher_DefaultDelay");
		OpenSettingsDval = DistributedValue.Create("AgentSwitcher_OpenSettings");
		DisplayDval = DistributedValue.Create("AgentSwitcher_Display");
		ActiveDval = DistributedValue.Create("AgentSwitcher_Enabled");
		OpenSettingsDval.SetValue(false);
		DisplayDval.SetValue(false);
	}


	public function Load():Void {
		m_Player = Character.GetClientCharacter();
		m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
		m_Player.SignalToggleCombat.Connect(SignalToggleCombat, this);
		SlotDval.SignalChanged.Connect(SlotDestionationChanged, this);
		OpenSettingsDval.SignalChanged.Connect(OpenSettings, this);
		ActiveDval.SignalChanged.Connect(StateChanged, this);
		DisplayDval.SignalChanged.Connect(DisplayAgents, this);
		AgentSystem.SignalPassiveChanged.Connect(SlotPassiveChanged, this);
		CharacterBase.SignalCharacterEnteredReticuleMode.Connect(CloseSettings, this);
		
		m_settingsRoot.removeMovieClip();
		m_settingsRoot = m_swfRoot.createEmptyMovieClip("m_settingsRoot", m_swfRoot.getNextHighestDepth());
		ASWingUtils.setRootMovieClip(m_settingsRoot);
		var laf:TswLookAndFeel = new TswLookAndFeel();
		UIManager.setLookAndFeel(laf)
		OpenSettings.SetValue(false);
	}

	public function Unload():Void {
		m_Player.SignalToggleCombat.Disconnect(SignalToggleCombat, this);
		m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		AgentSystem.SignalPassiveChanged.Disconnect(SlotPassiveChanged, this);
		SlotDval.SignalChanged.Disconnect(SlotDestionationChanged, this);
		OpenSettingsDval.SignalChanged.Disconnect(OpenSettings, this);
		ActiveDval.SignalChanged.Disconnect(StateChanged, this);
		DisplayDval.SignalChanged.Disconnect(DisplayAgents, this);
		m_settingsRoot.removeMovieClip();
		CharacterBase.SignalCharacterEnteredReticuleMode.Disconnect(CloseSettings, this);
	}
	
	public function LoadSettings(config: Archive):Void {
		SlotDval.SetValue(config.FindEntry("Slot", 1));
		SlotDestionationChanged(SlotDval);
		DebugDval.SetValue(config.FindEntry("Debug", false));
		SwitchDval.SetValue(config.FindEntry("Switch", false));
		DefaultDelayDval.SetValue(config.FindEntry("Delay", 2000));
		DisplayPos = config.FindEntry("DisplayPos", new Point(300,50));
		DisplayDval.SetValue(config.FindEntry("Display", false));
		DefaultAgent = config.FindEntry("Default", 0);
		iconPos = config.FindEntry("iconPos", new Point(200, 50));
		ActiveDval.SetValue(config.FindEntry("Active", true));
		RecentAgents = config.FindEntryArray("RecentAgents");
		if (DefaultAgent == 0){
			DefaultAgent = AgentHelper.GetAgentInSlot(DestinationSlot).m_AgentId;
		}
		if (!RecentAgents){
			RecentAgents = new Array();
			RecentAgents.push(DefaultAgent);
		}
		CreateTopIcon();
	}

	public function SaveSettings():Archive {
		var config:Archive = new Archive();
		config.AddEntry("Slot", SlotDval.GetValue());
		config.AddEntry("Debug", DebugDval.GetValue());
		config.AddEntry("Switch", SwitchDval.GetValue());
		config.AddEntry("Delay", DefaultDelayDval.GetValue());
		config.AddEntry("Default", DefaultAgent);
		config.AddEntry("iconPos", iconPos);
		config.AddEntry("Active", ActiveDval.GetValue());
		config.AddEntry("Display", DisplayDval.GetValue());
		config.AddEntry("DisplayPos", DisplayPos);
		for (var i = 0; i < RecentAgents.length;i++ ){
			config.AddEntry("RecentAgents", RecentAgents[i]);
		}
		return config
	}
	
//DVal
	private function SlotDestionationChanged(dv:DistributedValue) {
		DestinationSlot = dv.GetValue() - 1;
	}

//Agent switching
	private function SignalToggleCombat(combatState:Boolean) {
		if (!combatState && SwitchDval.GetValue() && ActiveDval.GetValue()){
			var SlotAgent:AgentSystemAgent = AgentHelper.GetAgentInSlot(DestinationSlot);
			if (SlotAgent.m_AgentId != DefaultAgent){
				DefaultTimeout = setTimeout(Delegate.create(this, SwitchToAgent), DefaultDelayDval.GetValue(), DefaultAgent);
			}
		}
	}

	// There's delay when changing audio, otherwise i would mute inteface sounds here.
	private function SwitchToAgent(agentID:Number) {
		AgentSystem.EquipPassive(agentID, DestinationSlot);
	}
	
	// Passive Changed, make this the new default agent and push it to recent agents
	private function SlotPassiveChanged(slotID:Number) {
		if (slotID == DestinationSlot) {
			var SlotAgent:AgentSystemAgent = AgentHelper.GetAgentInSlot(slotID);
			if (SlotAgent){
				if (DefaultAgent != SlotAgent.m_AgentId && !AgentHelper.isDruid(SlotAgent.m_AgentId)) {
					DefaultAgent = SlotAgent.m_AgentId;
					var found;
					for (var i in RecentAgents){
						if (RecentAgents[i] == SlotAgent.m_AgentId) found = true;
					}
					if (!found){
						if (RecentAgents.length == 3){
							RecentAgents.shift();
							RecentAgents.push(DefaultAgent);
						}else{
							RecentAgents.push(DefaultAgent);
						}
					}
				}
			}
		}
	}

	private function TargetChanged(id:ID32) {
		if (ActiveDval.GetValue()){
			clearTimeout(DefaultTimeout);
			if (!id.IsNull()) {
				var data:Object = AgentHelper.GetRace(id);
				var agent = AgentHelper.GetSwitchAgent(data.Agent,DestinationSlot,DefaultAgent);
				if (DebugDval.GetValue() && data.Name + data.Race != string(LastSelectedName) + string(LastSelectedRace)) {
					com.GameInterface.UtilsBase.PrintChatText(data.Name +" : " + data.Race);
				} 
				if (agent != 0 && !m_Player.IsInCombat()) {
					SwitchToAgent(agent);
				}
				LastSelectedName = data.Name;
				LastSelectedRace = data.Race;//melotath has no race for ankh 5, but is undead for 6
			} else if (SwitchDval.GetValue() && !m_Player.IsInCombat()) {
				SignalToggleCombat(false);
			}
		}
	}

//Icon
	private function guiEdit(state) {
		if (!state) {
			m_Icon.stopDrag()
			iconPos = Common.getOnScreen(m_Icon);
			m_Icon._x = iconPos.x;
			m_Icon._y = iconPos.y;
			m_Icon.onPress = Delegate.create(this, OpenQuickSelect);
			m_Icon.onPressAux = Delegate.create(this, function() {
				this.OpenSettingsDval.SetValue(!this.OpenSettingsDval.GetValue());
			});
			m_Icon.onRelease = undefined;
			m_Icon.onReleaseOutside = undefined;
		} else {
			OpenSettingsDval.SetValue(false);
			m_Icon.onPress = Delegate.create(this, function() {
				this.m_Icon.startDrag();
			});
			m_Icon.onPressAux = undefined;
			m_Icon.onRelease = Delegate.create(this, function() {
				this.m_Icon.stopDrag();
			});
			m_Icon.onReleaseOutside = Delegate.create(this, function() {
				this.m_Icon.stopDrag();
			});
		}
	}
	public function StateChanged(dv:DistributedValue) {
		if (dv.GetValue()) {
			Colors.ApplyColor(m_Icon.m_Img, 0x00C400);
		} else {
			Colors.ApplyColor(m_Icon.m_Img, 0xFFFFFF);
		}
	}
	public function CreateTopIcon() {
		if (!m_Icon) {
			m_Icon = m_swfRoot.createEmptyMovieClip("m_TopIcon", m_swfRoot.getNextHighestDepth());
			m_Icon._x = iconPos.x;
			m_Icon._y = iconPos.y;
			var m_Img = m_Icon.attachMovie("src.assets.AgentTopBar.png", "m_Img", m_Icon.getNextHighestDepth(), {_x:2, _y:2})
			if (ActiveDval.GetValue()) {
				Colors.ApplyColor(m_Icon.m_Img, 0x00C400);
			} else {
				Colors.ApplyColor(m_Icon.m_Img, 0xFFFFFF);
			}
			//hitbox, should is use border?
			Draw.DrawRectangle(m_Icon, 0, 0, 21, 21, 0x000000, 20, [3, 3, 3, 3], 2, 0xFFFFFF, 0, true);
			guiEdit(false);
			GlobalSignal.SignalSetGUIEditMode.Connect(guiEdit, this);
		}
	}

//QuickSelect
	private function OpenQuickSelect(){
		QuickSelect.dispose();
		m_AgentDisplay.Hide();
		OpenSettingsDval.SetValue(false);
		QuickSelect = new JPopup();
		QuickSelect.setX(m_Icon._x);
		QuickSelect.setY(m_Icon._y + m_Icon._height+5);
		var panel:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
		for (var i in RecentAgents){
			if (AgentSystem.HasAgent(RecentAgents[i])){
				var Agent:AgentSystemAgent = AgentSystem.GetAgentById(RecentAgents[i]);
				if (Agent.m_Level >= 25){
					var AgentButton:QuickSelectButton = new QuickSelectButton(Agent.m_Name)
					AgentButton.SetData(Agent);
					AgentButton.addActionListener(__AgentButtonClicked, this);
					panel.append(AgentButton);
				}
			}
		}
		
		for (var i in AgentHelper.Druids){
			if (AgentSystem.HasAgent(AgentHelper.Druids[i][0])){
				var Agent:AgentSystemAgent = AgentSystem.GetAgentById(AgentHelper.Druids[i][0]);
				if (Agent.m_Level == 50){
					var AgentButton:QuickSelectButton = new QuickSelectButton(AgentHelper.Druids[i][1])
					AgentButton.SetData(Agent);
					AgentButton.addActionListener(__AgentButtonClicked, this);
					panel.append(AgentButton);
				}
			}
		}
		QuickSelect.append(panel);
		QuickSelect.pack();
		QuickSelect.setVisible(true);
	}
	private function __AgentButtonClicked(button:QuickSelectButton){
		var current:AgentSystemAgent = AgentHelper.GetAgentInSlot(DestinationSlot);
		if (current.m_AgentId != button.AgentData.m_AgentId){
			SwitchToAgent(button.AgentData.m_AgentId);
		}
		button.CloseTooltip();
		CloseSettings();
	}
//Settings
	private function OpenSettings(dv:DistributedValue){
		if (dv.GetValue()){
			m_AgentDisplay.Hide();
			if (m_settings) m_settings.dispose();
			QuickSelect.dispose();
			QuickSelect = undefined;
			m_settings = new Settings(m_Icon._x, m_Icon._y + m_Icon._height+5, this);
		}else{
			m_AgentDisplay.Show();
			if (m_settings){
				m_settings.dispose();
				m_settings = undefined;
			}
		}
	}
	private function CloseSettings(){
		OpenSettingsDval.SetValue(false);
		QuickSelect.dispose();
		QuickSelect = undefined;
		m_AgentDisplay.Show();
	}

//Agent Display
	private function DisplayAgents(dv:DistributedValue){
		if (m_AgentDisplay){
			m_AgentDisplay.SignalMoved.Disconnect(SaveDisplayPosition, this);
			m_AgentDisplay.Destroy();
			m_AgentDisplay = undefined;
		}
		if (dv.GetValue()){
			m_AgentDisplay = new AgentDisplay(m_swfRoot,DisplayPos);
			m_AgentDisplay.SignalMoved.Connect(SaveDisplayPosition, this);
		}
	}
	private function SaveDisplayPosition(newPos:Point){
		DisplayPos = newPos;
	}
}