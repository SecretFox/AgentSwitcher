import com.GameInterface.AccountManagement;
import com.GameInterface.Game.Character;
import com.GameInterface.ProjectUtils;
import GUI.HUD.AbilitySlot;
import com.Utils.ID32;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Utils.Player {
	private static var m_Player:Character;
	private static var ROLE_TANK = ProjectUtils.GetUint32TweakValue("GroupFinder_Tank_Buff");
	private static var ROLE_HEALER = ProjectUtils.GetUint32TweakValue("GroupFinder_Healer_Buff");
	private static var ROLE_DPS = ProjectUtils.GetUint32TweakValue("GroupFinder_DamageDealer_Buff");
	
	public function Player(id:ID32){
		m_Player = Character.GetClientCharacter();;
	}
	public static function GetPlayer(id:ID32):Character{
		return m_Player
	}
	public static function IsRightRole(role:String) {
		if (role == "all") return true;
		else {
			var TankBuff = m_Player.m_BuffList[ROLE_TANK] != undefined || m_Player.m_InvisibleBuffList[ROLE_TANK] != undefined;
			var DpsBuff = m_Player.m_BuffList[ROLE_DPS] != undefined || m_Player.m_InvisibleBuffList[ROLE_DPS] != undefined;
			var HealerBuff = m_Player.m_BuffList[ROLE_HEALER] != undefined || m_Player.m_InvisibleBuffList[ROLE_HEALER] != undefined;
			if (role == "tank" && TankBuff) {
				return true;
			}
			if (role == "dps" && DpsBuff) {
				return true;
			}
			if (role == "healer" && HealerBuff) {
				return true;
			}
			//if (!TankBuff && !DpsBuff && !HealerBuff) return true;
		}
	}
	//Cutscene/dead etc..
	public static function IsinPlay():Boolean {
		if (AccountManagement.GetInstance().GetLoginState() != _global.Enums.LoginState.e_LoginStateInPlay ||
		m_Player.IsDead() ||
		m_Player.IsInCinematic() ||
		_root.fadetoblack.m_BlackScreen._visible) {
			return false
		}
		return true
	}
	// Probably not the best way to check cooldowns
	public static function GetSkill(slotID:Number):Number {
		return _root.abilitybar.m_AbilitySlots[slotID].m_Id;
	}
	// Probably not the best way to check cooldowns
	public static function SlotHasCooldown(slotID:Number):Boolean {
		var slot:AbilitySlot = _root.abilitybar.m_AbilitySlots[slotID];
		if (slot["m_IsCooldown"]) {
			return true
		}
		return false
	}
	// Probably not the best way to check cooldowns
	public static function HasCooldown():Boolean {
		for (var i in _root.abilitybar.m_AbilitySlots) {
			var slot:AbilitySlot = _root.abilitybar.m_AbilitySlots[i];
			if (slot["m_IsCooldown"]) {
				return true
			}
		}
		return false
	}
}