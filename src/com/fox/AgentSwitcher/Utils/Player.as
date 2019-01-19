import com.GameInterface.AccountManagement;
import com.GameInterface.Game.CharacterBase;
import com.GameInterface.ProjectUtils;
import GUI.HUD.AbilitySlot;
import com.Utils.ID32;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Utils.Player extends CharacterBase {
	private static var m_Player:Player;
	private static var ROLE_TANK = ProjectUtils.GetUint32TweakValue("GroupFinder_Tank_Buff");
	private static var ROLE_HEALER = ProjectUtils.GetUint32TweakValue("GroupFinder_Healer_Buff");
	private static var ROLE_DPS = ProjectUtils.GetUint32TweakValue("GroupFinder_DamageDealer_Buff");
	
	public function Player(id:ID32){
		super(id);
		m_Player = this;
	}
	public static function GetPlayer(id:ID32):Player{
		return m_Player
	}
	public function IsRightRole(role:String) {
		if (role == "all") return true;
		else {
			var TankBuff = m_BuffList[ROLE_TANK] != undefined || m_InvisibleBuffList[ROLE_TANK] != undefined;
			var DpsBuff = m_BuffList[ROLE_DPS] != undefined ||m_InvisibleBuffList[ROLE_DPS] != undefined;
			var HealerBuff = m_BuffList[ROLE_HEALER] != undefined || m_InvisibleBuffList[ROLE_HEALER] != undefined;
			if (role == "tank" && TankBuff) {
				return true;
			}
			if (role == "dps" && DpsBuff) {
				return true;
			}
			if (role == "healer" && HealerBuff) {
				return true;
			}
			if (!TankBuff && !DpsBuff && !HealerBuff) return true;
		}
	}
	//Cutscene/dead etc..
	public function IsinPlay():Boolean {
		if (AccountManagement.GetInstance().GetLoginState() != _global.Enums.LoginState.e_LoginStateInPlay ||
		IsDead() ||
		IsInCinematic() ||
		_root.fadetoblack.m_BlackScreen._visible) {
			return false
		}
		return true
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