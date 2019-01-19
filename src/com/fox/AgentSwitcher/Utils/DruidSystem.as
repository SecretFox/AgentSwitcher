import com.fox.AgentSwitcher.Utils.Player;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.Character;
import com.Utils.ID32;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Utils.DruidSystem {
	/*
	public static var Druids:Array = [
		[2746, "Construct"],
		[2749, "Cybernetic"],
		[2743, "Demon"],
		[2748, "Aquatic"],
		[2744, "Filth"],
		[2750, "Human"],
		[2745, "Spirit"],
		[2741, "Supernatural"],
		[2747, "Undead"],
		[2742, "Animal"]
	];
	*/

	// DEBUG, i dont have lvl 50 druids
	static var Druids:Array = [
	  [2701, "Construct"],
	  [2468, "Cybernetic"],
	  [2456, "Demon"],
	  [233, "Aquatic"],
	  [236, "Filth"],
	  [215, "Human"],
	  [246, "Spirit"],
	  [225, "Supernatural"],
	  [211, "Undead"],
	  [207, "Animal"]
	];
	
	//DEBUG, i dont have lvl 50 druids
	public static function GetRace(id:ID32):Object {
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
				agent = 2701;
				break;
			case 3:
			case 15:
			case 52:
			case 60:
				race =  "Cybernetic";
				agent = 2468;
				break;
			case 4:
			case 26:
			case 37:
			case 51:
			case 57:
			case 61:
			case 67:
				race =  "Demon";
				agent = 2456;
				break;
			case 18:
			case 36:
			case 46:
				race =  "Aquatic";
				agent = 233;
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
				agent = 236;
				break;
			case 1:
			case 27:
			case 47:
			case 48:
			case 56:
			case 71:
				race =  "Human";
				agent = 215;
				break;
			case 5:
			case 19:
			case 22:
			case 23:
			case 39:
			case 62:
			case 69:
				race =  "Spirit";
				agent = 246;
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
				agent = 225;
				break;
			case 16:
			case 17:
			case 24:
			case 31:
			case 63:
				race =  "Undead";
				agent = 211;
				break;
			case 28:
			case 29:
			case 35:
			case 41:
			case 43:
				race =  "Animal";
				agent = 207;
				break;
			case 20:
			case 21:
			case 53:
			case 54:
			case 55:
				// No agent with vampire passive yet
				race =  "Vampire";
				break;
			case 101:
				race =  "None(Turret)";
				break
			case 100:
				race =  "None(Custodian)";
				break
			case 0:
				// Unassigned?
				race =  "Unassigned";
				break;
			case 999:
				// No Race Defined
				race = "None";
				break
			default:
				// Anything that shows here probably needs to be added somewhere above
				race =  "Uknown (" + stat+"), report to mod author";
				break;
		}
		return {Name:name, Race:race, Stat:stat, Agent:agent}
	}
	

	/*
	public static function GetRace(id:ID32):Object {
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
			case 101:
				race =  "None(Turret)";
				break
			case 100:
				race =  "None(Custodian)";
				break
			case 59:
				race = "None?";
				break
			case 0:
				// Unassigned?
				race =  "None";
				break;
			case 999:
				// No Race Defined
				race = "No Race Defined";
				break
			default:
				// Anything that shows here probably needs to be added somewhere above
				race =  "Uknown (" + stat+"), report to mod author";
				break;
		}
		//com.GameInterface.UtilsBase.PrintChatText(string(stat))
		return {Name:name, Race:race, Stat:stat, DruidSystem:agent}
	}
	*/
	public static function GetAgentInSlot(slotID:Number):AgentSystemAgent {
		var spellId:Number = AgentSystem.GetPassiveInSlot(slotID);// 0 if invalid slot
		if (spellId != 0) {
			var SlotAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(slotID);//Crashes if invalid slot
			return SlotAgent
		}
	}

	/*
	* Checks if player has the preferred agent at lvl 50 & not equipped
	* 	Returns 0 if already equipped
	* 	Returns value of defaultAgent otherwise
	*/
	public static function GetSwitchAgent(pref:Number, slotID:Number, defaultAgent:Number):Number {
		var currentAgent:AgentSystemAgent = GetAgentInSlot(slotID);
		if (currentAgent.m_AgentId != pref) {
			if (AgentSystem.HasAgent(pref)) {
				// Trying to get agent by invalid agentID crashes the game
				// If HasAgent returns true it should be safe to get the agent level
				if (AgentSystem.GetAgentById(pref).m_Level == 50) {
					return pref;
				}
			}
			if (currentAgent.m_AgentId != defaultAgent) {
				return defaultAgent;
			}
		}
		return 0
	}

	public static function IsDruid(id:Number):Boolean {
		for (var i = 0; i < Druids.length; i++) {
			if (Druids[i][0] == id) {
				return true
			}
		}
		return false
	}

	public static function SwitchToAgent(agentID:Number, slot:Number) {
		if (!Player.GetPlayer().IsinPlay()){
			setTimeout(SwitchToAgent, 500, agentID, slot);
			return
		}
		if (AgentSystem.HasAgent(agentID)) { //just in case
			AgentSystem.EquipPassive(agentID, slot);
		}
	}

}