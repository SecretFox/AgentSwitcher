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
	public var ActiveDval:DistributedValue;

	private var DefaultAgent:Number;
	private var m_Player:Character;
	static var RacialAgents:Array = [
		[2746,"Construct"],
		[2749,"Cybernetic"],
		[2743,"Demon"],
		[2748,"Aquatic"],
		[2744,"Filth"],
		[2750,"Human"],
		[2745,"Spirit"],
		[2741,"Supernatural"],
		[2747,"Undead"],
		[2742,"Animal"]
	];
	private var DestinationSlot:Number;
	private var DefaultTimeout;
	private var LastSelectedName:String;
	private var LastSelectedRace:String;
	
	private var m_swfRoot:MovieClip;
	private var m_settingsRoot:MovieClip;
	private var m_settings:Settings;
	private var m_Icon:MovieClip;
	private var iconPos:Point;
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
		ActiveDval = DistributedValue.Create("AgentSwitcher_Enabled");
		OpenSettingsDval.SetValue(false);
	}

	public function LoadSettings(config: Archive):Void {
		SlotDval.SetValue(config.FindEntry("Slot", 1));
		SlotDestionationChanged(SlotDval);
		DebugDval.SetValue(config.FindEntry("Debug", false));
		SwitchDval.SetValue(config.FindEntry("Switch", false));
		DefaultDelayDval.SetValue(config.FindEntry("Delay", 2000));
		DefaultAgent = config.FindEntry("Default", 0);
		iconPos = config.FindEntry("iconPos", new Point(200, 50));
		ActiveDval.SetValue(config.FindEntry("Active", true));
		RecentAgents = config.FindEntryArray("RecentAgents");
		if (DefaultAgent == 0) DefaultAgent = GetCurrentAgent().m_AgentId;
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
		for (var i = 0; i < RecentAgents.length;i++ ){
			config.AddEntry("RecentAgents", RecentAgents[i]);
		}
		return config
	}

	public function Load():Void {
		m_Player = Character.GetClientCharacter();
		m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
		m_Player.SignalToggleCombat.Connect(SwitchToDefault, this);
		SlotDval.SignalChanged.Connect(SlotDestionationChanged, this);
		OpenSettingsDval.SignalChanged.Connect(OpenSettings, this);
		ActiveDval.SignalChanged.Connect(StateChanged, this);
		AgentSystem.SignalPassiveChanged.Connect(SlotPassiveChanged, this);
		m_settingsRoot = m_swfRoot.createEmptyMovieClip("m_settingsRoot", m_swfRoot.getNextHighestDepth());
		ASWingUtils.setRootMovieClip(m_settingsRoot);
		var laf:TswLookAndFeel = new TswLookAndFeel();
		UIManager.setLookAndFeel(laf)
		OpenSettings.SetValue(false);
		CharacterBase.SignalCharacterEnteredReticuleMode.Connect(CloseSettings, this);
	}

	public function Unload():Void {
		m_Player.SignalToggleCombat.Disconnect(SwitchToDefault, this);
		m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		AgentSystem.SignalPassiveChanged.Disconnect(SlotPassiveChanged, this);
		SlotDval.SignalChanged.Disconnect(SlotDestionationChanged, this);
		OpenSettingsDval.SignalChanged.Disconnect(OpenSettings, this);
		ActiveDval.SignalChanged.Disconnect(StateChanged, this);
		m_settingsRoot.removeMovieClip();
		CharacterBase.SignalCharacterEnteredReticuleMode.Disconnect(CloseSettings, this);
	}
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
	private function OpenSettings(dv:DistributedValue){
		if (dv.GetValue()){
			if (m_settings) m_settings.dispose();
			QuickSelect.dispose();
			QuickSelect = undefined;
			m_settings = new Settings(m_Icon._x, m_Icon._y + m_Icon._height+5, this);
		}else{
			if (m_settings){
				m_settings.dispose();
				m_settings = undefined;
			}
		}
	}
	private function __AgentButtonClicked(button:QuickSelectButton){
		var current:AgentSystemAgent = GetCurrentAgent();
		if (current.m_AgentId != button.AgentData.m_AgentId){
			SwitchToAgent(button.AgentData.m_AgentId);
		}
		button.CloseTooltip();
		CloseSettings();
	}
	private function OpenQuickSelect(){
		QuickSelect.dispose();
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
		
		for (var i in RacialAgents){
			if (AgentSystem.HasAgent(RacialAgents[i][0])){
				var Agent:AgentSystemAgent = AgentSystem.GetAgentById(RacialAgents[i][0]);
				if (Agent.m_Level == 50){
					var AgentButton:QuickSelectButton = new QuickSelectButton(RacialAgents[i][1])
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
	
	private function CloseSettings(){
		OpenSettingsDval.SetValue(false);
		QuickSelect.dispose();
		QuickSelect = undefined;
	}
	
	private function SlotDestionationChanged(dv:DistributedValue) {
		DestinationSlot = dv.GetValue() - 1;
	}

	private function GetRace(id:ID32) {
		var mob:Character = new Character(id);
		var stat = mob.GetStat(89);
		var race = "";
		var name = string(mob.GetName());
		var agent = 0;

		switch (stat) {
			case 6:
			case 12:
			case 34:
				race = "Construct";
				agent = 2746;
				break;
			case 3:
			case 15:
			case 52:
			case 60:
				race =  "Cybernetic";
				agent = 2749;
				break;
			case 4:
			case 26:
			case 37:
			case 51:
			case 57:
			case 61:
			case 67:
				race =  "Demon";
				agent = 2743;
				break;
			case 18:
			case 36:
			case 46:
				race =  "Aquatic";
				agent = 2748;
				break;
			case 13:
			case 14:
			case 25:
			case 32:
			case 33:
			case 38:
			case 45:
			case 64:
			case 65:
			case 66:
				race =  "Filth";
				agent = 2744;
				break;
			case 1:
			case 27:
			case 47:
			case 48:
			case 56:
			case 71:
				race =  "Human";
				agent = 2750;
				break;
			case 5:
			case 19:
			case 22:
			case 23:
			case 39:
			case 62:
			case 69:
				race =  "Spirit";
				agent = 2745;
				break;
			case 7:
			case 8:
			case 9:
			case 10:
			case 40:
			case 44:
			case 49:
			case 58:
			case 68:
			case 70:
				race =  "Supernatural";
				agent = 2741;
				break;
			case 16:
			case 17:
			case 24:
			case 31:
			case 63:
				race =  "Undead";
				agent = 2747;
				break;
			case 28:
			case 29:
			case 35:
			case 41:
			case 43:
				race =  "Animal";
				agent = 2742;
				break;
			case 20:
			case 21:
			case 53:
			case 54:
			case 55:
				// No agent with vampire passive yet
				race =  "Vampire";
				break;
			case 0:
				race =  "Unassigned";
				break;
			case 999:
				race = "None";
				break
			default:
				race =  "Uknown (" + stat+")";
				break;
		}
		return {Name:name, Race:race, Stat:stat, Agent:agent}
	}

	private function GetCurrentAgent():AgentSystemAgent {
		var currentAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(DestinationSlot);
		return currentAgent;
	}

	private function isRacialAgent(id) {
		for (var i = 0; i < RacialAgents.length; i++) {
			if (RacialAgents[i][0] == id) {
				return true
			}
		}
		return false
	}

	private function SwitchToDefault(combatState:Boolean) {
		if (SwitchDval.GetValue() && !combatState) {
			var spellId:Number = AgentSystem.GetPassiveInSlot(DestinationSlot);
			if (spellId != 0) {
				var SlotAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(DestinationSlot);
				// Delay switching to default by x ms, to make sure it doesn't default while running to target
				// timeout is cancelled when target changes
				DefaultTimeout = setTimeout(Delegate.create(this, SwitchToAgent), DefaultDelayDval.GetValue(), DefaultAgent);
			}
		}
	}

	// There's delay when changing audio, otherwise i would mute inteface sounds here.
	private function SwitchToAgent(agentID:Number) {
		AgentSystem.EquipPassive(agentID, DestinationSlot);
		/*
		 * Debug
		if (DebugDval.GetValue()) {
			if (AgentSystem.HasAgent(agentID)) {
				if (agentID == DefaultAgent) {
					com.GameInterface.UtilsBase.PrintChatText("Switching to Default(" + AgentSystem.GetAgentById(agentID).m_Name+"[" + agentID + "])");
				} else {
					com.GameInterface.UtilsBase.PrintChatText("Switching to " + AgentSystem.GetAgentById(agentID).m_Name+"["+agentID+"]");
				}
			} else {
				com.GameInterface.UtilsBase.PrintChatText("Invalid agent " + agentID);
			}
		}
		*/
	}
	// Passive Changed, make this the new default agent
	// Works with boobuilds, default gear manager or manual switching
	private function SlotPassiveChanged(slotID:Number) {
		if (slotID == DestinationSlot) {
			var spellId:Number = AgentSystem.GetPassiveInSlot(DestinationSlot);// 0 if invalid slot
			if (spellId != 0) {
				var SlotAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(DestinationSlot);//Crashes if invalid slot
				if (DefaultAgent != SlotAgent.m_AgentId && !isRacialAgent(SlotAgent.m_AgentId)) {
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
					//com.GameInterface.UtilsBase.PrintChatText("New default " + SlotAgent.m_Name + "(" + SlotAgent.m_AgentId +")");
				}
			}
		}
	}

	// Gets agent best suited for the mob.
	// If agent is not owned or mob category is unkown should return default agent.
	// returns 0 if already correct agent
	private function GetSwitchAgent(pref) {
		var currentAgent:AgentSystemAgent = GetCurrentAgent();
		if (currentAgent.m_AgentId != pref) {
			if (AgentSystem.HasAgent(pref)) {
				// Trying to get agent by invalid agentID crashes the game
				// If HasAgent returns true it should be safe to get the agent level
				if (AgentSystem.GetAgentById(pref).m_Level == 50) {
					return pref;
				}
			}
			if (currentAgent.m_AgentId != DefaultAgent) {
				return DefaultAgent;
			}
		}
		return 0
	}

	private function TargetChanged(id:ID32) {
		if (ActiveDval.GetValue()){
			clearTimeout(DefaultTimeout);
			if (!id.IsNull()) {
				var data:Object = GetRace(id);
				var agent = GetSwitchAgent(data.Agent);
				if (DebugDval.GetValue() && data.Name + data.Race != string(LastSelectedName) + string(LastSelectedRace)) {
					com.GameInterface.UtilsBase.PrintChatText(data.Name +" : " + data.Race);
				} 
				if (agent != 0 && !m_Player.IsInCombat()) {
					SwitchToAgent(agent);
				}
				LastSelectedName = data.Name;
				LastSelectedRace = data.Race;//melotath has no race for ankh 5, but is undead for 6
			} else if (SwitchDval.GetValue() && !m_Player.IsInCombat()) {
				SwitchToDefault(false);
			}
		}
	}
}