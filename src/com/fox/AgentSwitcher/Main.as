import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.DistributedValue;
import com.GameInterface.DistributedValueBase;
import com.GameInterface.Game.Character;
import com.Utils.Archive;
import com.Utils.ID32;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */

class com.fox.AgentSwitcher.Main {
	private var DebugDval:DistributedValue;
	private var SlotDval:DistributedValue;
	private var SwitchDval:DistributedValue;
	private var DefaultDelayDval:DistributedValue;
	
	private var DefaultAgent:Number;
	private var m_Player:Character;
	static var SpecialAgents:Array = [2746, 2749, 2743, 2748, 2744, 2750, 2745, 2741, 2747, 2742];
	private var DestinationSlot:Number;
	private var DefaultTimeout;
	private var LastSelected:ID32;

	public static function main(swfRoot:MovieClip):Void {
		var s_app = new Main(swfRoot);
		swfRoot.onLoad =  function() {return s_app.Load()};
		swfRoot.onUnload =  function() {return s_app.Unload()};
		swfRoot.OnModuleActivated = function(settings:Archive) {s_app.LoadSettings(settings)};
		swfRoot.OnModuleDeactivated = function() {return s_app.SaveSettings()};
	}

	public function Main() {
		DebugDval = DistributedValue.Create("AgentSwitcher_Debug");
		SlotDval = DistributedValue.Create("AgentSwitcher_Slot");
		SwitchDval = DistributedValue.Create("AgentSwitcher_DefaultOnCombatEnd");
		DefaultDelayDval = DistributedValue.Create("AgentSwitcher_DefaultDelay");
	}

	public function LoadSettings(config: Archive):Void {
		SlotDval.SetValue(config.FindEntry("Slot", 1));
		DebugDval.SetValue(config.FindEntry("Debug", false));
		SwitchDval.SetValue(config.FindEntry("Switch", false));
		DefaultDelayDval.SetValue(config.FindEntry("Delay", 2000));
		DefaultAgent = config.FindEntry("Default", 0);
		if (DefaultAgent == 0) DefaultAgent = GetCurrentAgent().m_AgentId;
	}

	public function SaveSettings():Archive {
		var config:Archive = new Archive();
		config.AddEntry("Slot", SlotDval.GetValue());
		config.AddEntry("Debug", DebugDval.GetValue());
		config.AddEntry("Switch", SwitchDval.GetValue());
		config.AddEntry("Delay", DefaultDelayDval.GetValue());
		config.AddEntry("Default", DefaultAgent);
		return config
	}

	public function Load() {
		m_Player = Character.GetClientCharacter();
		m_Player.SignalOffensiveTargetChanged.Connect(TargetChanged, this);
		m_Player.SignalToggleCombat.Connect(SwitchToDefault, this);
		SlotDval.SignalChanged.Connect(SlotDestionationChanged, this);
		AgentSystem.SignalPassiveChanged.Connect(SlotPassiveChanged, this);
	}

	public function Unload() {
		m_Player.SignalToggleCombat.Disconnect(SwitchToDefault, this);
		m_Player.SignalOffensiveTargetChanged.Disconnect(TargetChanged, this);
		AgentSystem.SignalPassiveChanged.Disconnect(SlotPassiveChanged, this);
		SlotDval.SignalChanged.Disconnect(SlotDestionationChanged, this);
	}

	private function SlotDestionationChanged(dv:DistributedValue) {
		DestinationSlot = dv.GetValue() - 1;
	}

	private function GetSpecies(id:ID32) {
		var mob:Character = new Character(id);
		var stat = mob.GetStat(89);
		var species = "";
		var name = string(mob.GetName());
		var agent = 0;

		switch (stat) {
			case 6:
			case 12:
			case 34:
				species = "Construct";
				agent = 2746;
				break;
			case 3:
			case 15:
			case 52:
			case 60:
				species =  "Cybernetic";
				agent = 2749;
				break;
			case 4:
			case 26:
			case 37:
			case 51:
			case 57:
			case 61:
			case 67:
				species =  "Demon";
				agent = 2743;
				break;
			case 18:
			case 36:
			case 46:
				species =  "Aquatic";
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
				species =  "Filth";
				agent = 2744;
				break;
			case 1:
			case 27:
			case 47:
			case 48:
			case 56:
			case 71:
				species =  "Human";
				agent = 2750;
				break;
			case 5:
			case 19:
			case 22:
			case 23:
			case 39:
			case 62:
			case 69:
				species =  "Spirit";
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
			case 69:
			case 70:
				species =  "Supernatural";
				agent = 2741;
				break;
			case 16:
			case 17:
			case 24:
			case 31:
			case 63:
				species =  "Undead";
				agent = 2747;
				break;
			case 28:
			case 29:
			case 35:
			case 41:
			case 43:
				species =  "Animal";
				agent = 2742;
				break;
			case 20:
			case 21:
			case 53:
			case 54:
			case 55:
				// No agent with vampire passive yet
				species =  "Vampire";
				break;
			case 0:
				species =  "Unassigned";
				break;
			default:
				species =  "Uknown (" + stat+")";
				break;
		}
		return {Name:name, Species:species, Stat:stat, Agent:agent}
	}

	private function GetCurrentAgent():AgentSystemAgent {
		var currentAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(DestinationSlot);
		return currentAgent;
	}

	private function IsSpecialAgent(id) {
		for (var i = 0; i < SpecialAgents.length; i++) {
			if (SpecialAgents[i] == id) {
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
				DefaultTimeout = setTimeout(Delegate.create(this, SwitchToAgent), DefaultDelayDval.GetValue(), DefaultAgent);
			}
		}
	}

	// There's delay when changing audio, otherwise i would mute inteface sounds here.
	private function SwitchToAgent(agentID:Number) {
		AgentSystem.EquipPassive(agentID, this.DestinationSlot);
	}
	// Passive Changed, make this the new default agent
	// Works with boobuilds, default gear manager or manual switching
	private function SlotPassiveChanged(slotID:Number) {
		if (slotID == DestinationSlot) {
			var spellId:Number = AgentSystem.GetPassiveInSlot(DestinationSlot);
			if (spellId != 0) {
				var SlotAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(DestinationSlot);
				if (DefaultAgent != SlotAgent.m_AgentId && !IsSpecialAgent(SlotAgent.m_AgentId)) {
					DefaultAgent = SlotAgent.m_AgentId;
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
				} else {
					if (currentAgent.m_AgentId != DefaultAgent) {
						return DefaultAgent;
					}
				}
			} else {
				if (currentAgent.m_AgentId != DefaultAgent) {
					return DefaultAgent;
				}
			}
		}
		return 0
	}

	private function TargetChanged(id:ID32) {
		clearTimeout(DefaultTimeout);
		if (!id.IsNull()) {
			var data:Object = GetSpecies(id);
			if (DebugDval.GetValue() && data.Name != LastSelected ) {
				LastSelected = data.Name;
				com.GameInterface.UtilsBase.PrintChatText(data.Name +" is " + string(data.Species));
			}
			var agent = GetSwitchAgent(data.Agent);
			if (agent != 0) {
				SwitchToAgent(agent);
			}
		} else if (SwitchDval.GetValue() && !m_Player.IsInCombat()){
			// Delay switching to default by 500ms, to make sure it doesn't default while running to target
			SwitchToDefault(false);
		}
	}
}