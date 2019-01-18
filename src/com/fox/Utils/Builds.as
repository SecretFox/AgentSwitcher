import GUI.HUD.AbilitySlot;
import com.GameInterface.DistributedValueBase;
import com.GameInterface.Game.Character;
import com.GameInterface.GearManager;;
import com.GameInterface.ProjectUtils;
import com.Utils.Signal;
import com.fox.Utils.Debugger;
import com.fox.Utils.Task;
import mx.utils.Delegate;

/*
* ...
* @author fox
*/

class com.fox.Utils.Builds {
	private static var ROLE_TANK = ProjectUtils.GetUint32TweakValue("GroupFinder_Tank_Buff");
	private static var ROLE_HEALER = ProjectUtils.GetUint32TweakValue("GroupFinder_Healer_Buff");
	private static var ROLE_DPS = ProjectUtils.GetUint32TweakValue("GroupFinder_DamageDealer_Buff");
	private static var CANT_UNEQUIP_ENG:String = "You cannot unequip abilities that are recharging";
	private static var CANT_UNEQUIP_FR:String = "Vous ne pouvez pas vous déséquiper de pouvoirs en train de se recharger";
	private static var CANT_UNEQUIP_DE:String = "Sie können Kräfte nicht ablegen, während sie aufgeladen werden";
	static var onGoingEquips:Array = new Array();
	public var buildName:String;
	public var BuildEquipped:Signal;
	private var DisconnecTimeout:Number;
	
	public function Builds(build){
		buildName = build;
		BuildEquipped = new Signal();
	}
	
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
	
	public static function Equip(build:String, ran:Boolean) {
		for (var i in onGoingEquips){
			if (onGoingEquips[i].buildName == build){
				return
			}
		}
		var Equipper:Builds = new Builds(build);
		Equipper.BuildEquipped.Connect(Dispose);
		onGoingEquips.push(Equipper);
		Equipper.EquipBuild();
	}
	private static function Dispose(Build){
		for (var i in onGoingEquips){
			if (onGoingEquips[i] == Build){
				onGoingEquips.splice(Number(i), 1);
			}
		}
	}
	private function EquipBuild(ran:Boolean){
		if ((_root["boobuilds\\boobuilds"] && !_root["boobuilds\\boobuilds"].appBuilds.m_builds[0] && !ran) || !Task.IsinPlay()){
			setTimeout(Delegate.create(this, EquipBuild), 1000, true);
			return
		}
		com.GameInterface.Chat.SignalShowFIFOMessage.Disconnect(FIFOMessageHandler, this);
		com.GameInterface.Chat.SignalShowFIFOMessage.Connect(FIFOMessageHandler, this);
		clearTimeout(DisconnecTimeout);
		DisconnecTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
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
	private function Disconnect(){
		com.GameInterface.Chat.SignalShowFIFOMessage.Disconnect(FIFOMessageHandler, this);
		BuildEquipped.Emit(this);
	}
	// From booBuilds
	private function FIFOMessageHandler(text:String, mode:Number){
		if (text != null && (text.indexOf(CANT_UNEQUIP_ENG, 0) == 0 || text.indexOf(CANT_UNEQUIP_FR, 0) == 0 || text.indexOf(CANT_UNEQUIP_DE) == 0)) {
			setTimeout(Delegate.create(this,EquipBuild),500, true);
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