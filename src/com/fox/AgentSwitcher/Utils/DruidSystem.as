import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.Player;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.Character;
import com.Utils.ID32;
import com.fox.AgentSwitcher.data.mobData;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Utils.DruidSystem {
	
	public static var Druids:Array = [
		[[2742], "Animal"],
		//[[2748, 2750], "Aquatic"], //DEBUG
		[[2748, 3121], "Aquatic"],
		[[2746], "Construct"],
		[[2749], "Cybernetic"],
		[[2743], "Demon"],
		//[[2744, 2750], "Filth"], //DEBUG
		[[2744, 3118], "Filth"],
		[[2750], "Human"],
		[[2745], "Spirit"],
		[[2741], "Supernatural"],
		[[2747], "Undead"],
		[[3120], "Vampire"]
		
	];
	
	public static function GetName(id:Number) {
		for (var i in Druids) {
			for (var y in Druids[i][0]){
				if (Druids[i][0][y] == id) return Druids[i][1];
			}
		}
	}
	
	public static function IsMaxedAgent(agent) {
		if (agent instanceof Array)	{
			for (var i in agent) {
				if (AgentSystem.HasAgent(Number(agent[i]))) {
					var Agent:AgentSystemAgent = AgentSystem.GetAgentById(agent[i]);
					if (Agent.m_Level == 50) return true
				}
			}
		}
		else if (agent == "default" || agent == "race") return true
		else if (!isNaN(agent)) {
			if (AgentSystem.HasAgent(Number(agent))) {
				var Agent:AgentSystemAgent = AgentSystem.GetAgentById(agent);
				if (Agent.m_Level == 50) return true
			}
		}
		return false
	}
	
	public static function GetRace(id:ID32):mobData {
		var mob:Character = new Character(id);
		var m_mobData:mobData = new mobData();
		m_mobData.Stat = mob.GetStat(89);
		m_mobData.Race = "";
		m_mobData.Name = string(mob.GetName());
		m_mobData.Agent = [];

		switch (m_mobData.Stat ) {
			case 6:
			case 12:
			case 34:
				m_mobData.Race = "Construct";
				m_mobData.Agent = [2746];
				break;
			case 3:
			case 15:
			case 52:
			case 60:
				m_mobData.Race =  "Cybernetic";
				m_mobData.Agent = [2749];
				break;
			case 4:
			case 26:
			case 37:
			case 51:
			case 57:
			case 61:
			case 67:
				m_mobData.Race =  "Demon";
				m_mobData.Agent = [2743];
				break;
			case 18:
			case 36:
			case 46:
				m_mobData.Race =  "Aquatic";
				//_mobData.Agent = [2748,2750];
				m_mobData.Agent = [2748,3121];
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
				m_mobData.Race =  "Filth";
				//_mobData.Agent = [2744, 2750];
				m_mobData.Agent = [2744, 3118];
				break;
			case 1:
			case 27:
			case 47:
			case 48:
			case 56:
			case 71:
				m_mobData.Race =  "Human";
				m_mobData.Agent = [2750];
				break;
			case 5:
			case 19:
			case 22:
			case 23:
			case 39:
			case 62:
			case 69:
				m_mobData.Race =  "Spirit";
				m_mobData.Agent = [2745];
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
				m_mobData.Race =  "Supernatural";
				m_mobData.Agent = [2741];
				break;
			case 16:
			case 17:
			case 24:
			case 31:
			case 63:
				m_mobData.Race =  "Undead";
				m_mobData.Agent = [2747];
				break;
			case 28:
			case 29:
			case 35:
			case 41:
			case 43:
				m_mobData.Race =  "Animal";
				m_mobData.Agent = [2742];
				break;
			case 20:
			case 21:
			case 53:
			case 54:
			case 55:
				m_mobData.Race =  "Vampire";
				m_mobData.Agent = [3120];
				break;
			case 101:
				// fusang?
				m_mobData.Race =  "None(Turret)";
				break
			case 100:
				// fusang?
				m_mobData.Race =  "None(Custodian)";
				break
			case 59:
				// Winter event rats
				m_mobData.Race = "None?";
				break
			case 0:
				m_mobData.Race =  "None";
				break;
			case 999:
				// 	Not entirely sure what the difference betweeen this and 0 is.
				m_mobData.Race = "No Race Defined";
				break
			default:
				// Anything that shows here probably needs to be added somewhere above
				m_mobData.Race =  "Uknown (" + m_mobData.Stat +"), report to mod author";
				break;
		}
		m_mobData.Type = mob.GetStat(112)
		return m_mobData
	}
	
	public static function GetAgentInSlot(slotID:Number):AgentSystemAgent {
		var spellId:Number = AgentSystem.GetPassiveInSlot(slotID);// 0 if invalid slot
		if (spellId != 0) {
			var SlotAgent:AgentSystemAgent = AgentSystem.GetAgentForPassiveSlot(slotID);//Crashes if invalid slot
			return SlotAgent
		}
	}

	public static function isEquipped(agentid) {
		for (var i:Number = 0; i < 3; i++){
			var agent:AgentSystemAgent = GetAgentInSlot(i);
			if (agent.m_AgentId == agentid) return true;
		}
		return false;
	}
	/*
	* Checks if player has the preferred agent at lvl 50 & not equipped
	* 	Returns 0 if already equipped
	* 	Returns value of defaultAgent otherwise
	*/
	public static function GetSwitchAgent(pref:Number, slotID:Number, defaultAgent:Number):Number {
		if (isEquipped(pref)) return 0;
		var currentAgent:AgentSystemAgent = GetAgentInSlot(slotID);
		// Trying to get agent by invalid agentID crashes the game
		if (AgentSystem.HasAgent(pref)) {
			// If HasAgent returns true it should be safe to get the agent level
			if (AgentSystem.GetAgentById(pref).m_Level == 50) {
				return pref;
			}
		}
		if (currentAgent.m_AgentId != defaultAgent) {
			return defaultAgent;
		}
		return 0
	}

	public static function IsDruid(id:Number):Boolean {
		for (var i = 0; i < Druids.length; i++) {
			for (var x = 0; x < Druids[i][0].length; x++){
				if (Druids[i][0][x] == id) {
					return true
				}
			}
		}
		return false
	}

	// Purpose of this monstrosity is to equip 2nd agent on first slot, if first slot agent is not available for some reason
	public static function SwitchToAgents(AgentID:Number, AgentID2:Number, m_Controller:Controller) {
		// slot agent1 to slot1 normally
		if (AgentID && !(AgentID2 && AgentID == m_Controller.settingDefaultAgent && AgentID2 != m_Controller.settingDefaultAgent2)) {
			SwitchToAgent(AgentID, m_Controller.settingRealSlot);
		}
		// Previous check failed, slot Agent2 in Slot1 and put default agent in Slot2
		if (AgentID == m_Controller.settingDefaultAgent && AgentID2 && AgentID2 != m_Controller.settingDefaultAgent2) {
			SwitchToAgent(AgentID2, m_Controller.settingRealSlot);
			var agent = GetSwitchAgent(m_Controller.settingDefaultAgent2, m_Controller.settingRealSlot2, m_Controller.settingDefaultAgent2)
			if(agent) SwitchToAgent(agent, m_Controller.settingRealSlot2);
		}
		// Agent1 was changed normally, change 2nd agent normally
		else if (AgentID2) {
			SwitchToAgent(AgentID2, m_Controller.settingRealSlot2);
		}
	}
	
	public static function SwitchToAgent(agentID:Number, slot:Number) {
		if (!Player.IsinPlay()) { //just in case
			setTimeout(SwitchToAgent, 500, agentID, slot);
		}
		else if (AgentSystem.HasAgent(agentID)) { //just in case
			AgentSystem.EquipPassive(agentID, slot);
		}
	}
}