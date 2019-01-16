import GUI.HUD.AbilitySlot;
import com.GameInterface.DistributedValueBase;
import com.GameInterface.Game.Character;
import com.GameInterface.GearManager;;
import com.GameInterface.ProjectUtils;

/*
* ...
* @author fox
*/

class com.fox.Utils.Builds {
	static var ROLE_TANK = ProjectUtils.GetUint32TweakValue("GroupFinder_Tank_Buff");
	static var ROLE_HEALER = ProjectUtils.GetUint32TweakValue("GroupFinder_Healer_Buff");
	static var ROLE_DPS = ProjectUtils.GetUint32TweakValue("GroupFinder_DamageDealer_Buff");
	/*
	public static function HasBuild(buildName:String){
		Debugger.PrintText(_root["boobuilds\\boobuilds"].appBuilds.m_builds);
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_builds){
			Debugger.PrintText(_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name);
			if (_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name == buildName){
				Debugger.PrintText("Has build " + buildName+" on boobuilds");
				return true
			}
		}
		if (GearManager.GetBuild(buildName).m_ItemArray){
			Debugger.PrintText("Has build " + buildName + " on gearmangler");
			return true
		}
		return false
	}
	*/
	public static function IsRightRole(role:String){
		if (role == "all") return true
		else{
			var player:Character = Character.GetClientCharacter();
			var TankBuff = player.m_BuffList[ROLE_TANK] != undefined || player.m_InvisibleBuffList[ROLE_TANK] != undefined;
			var DpsBuff = player.m_BuffList[ROLE_DPS] != undefined ||player.m_InvisibleBuffList[ROLE_DPS] != undefined;
			var HealerBuff = player.m_BuffList[ROLE_HEALER] != undefined || player.m_InvisibleBuffList[ROLE_HEALER] != undefined;
			if (role == "tank" && TankBuff){
				return true;
			}
			if (role == "dps" && DpsBuff){
				return true;
			}
			if (role == "healer" && HealerBuff){
				return true;
			}
			if (!TankBuff && !DpsBuff && !HealerBuff) return true;
		}
	}
	public static function EquipBuild(buildName:String, ran:Boolean){
		//if reloaduingUI boobuilds will take a bit to finish loading
		if (_root["boobuilds\\boobuilds"] && !_root["boobuilds\\boobuilds"].appBuilds.m_builds[0] && !ran){
			setTimeout(EquipBuild, 1000, buildName, true);
			return
		}
		//Debugger.PrintText("Equipping build " + buildName);
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_builds){
			if (_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name == buildName){
				DistributedValueBase.SetDValue("BooBuilds_LoadBuild", buildName);
				return
			}
		}
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_outfits){
			if (_root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_name == buildName){
				DistributedValueBase.SetDValue("BooBuilds_LoadOutfit", buildName);
				return
			}
		}
		if (GearManager.GetBuild(buildName).m_ItemArray){
			GearManager.UseBuild(buildName);
			return
		}
	}
	
	public static function IsOnCooldown(){
		for (var i in _root.abilitybar.m_AbilitySlots){
			var slot:AbilitySlot = _root.abilitybar.m_AbilitySlots[i];
			if (slot["m_IsCooldown"]){
				return true
			}
		}
		return false
	}
}