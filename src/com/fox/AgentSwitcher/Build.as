import com.fox.AgentSwitcher.Utils.Player;
import com.GameInterface.DistributedValueBase;
import com.GameInterface.GearManager;
import com.Utils.Signal;
import mx.utils.Delegate;

/*
* ...
* @author fox
*/

class com.fox.AgentSwitcher.Build {
	private static var CANT_UNEQUIP_ENG:String = "You cannot unequip abilities that are recharging";
	private static var CANT_UNEQUIP_FR:String = "Vous ne pouvez pas vous déséquiper de pouvoirs en train de se recharger";
	private static var CANT_UNEQUIP_DE:String = "Sie können Kräfte nicht ablegen, während sie aufgeladen werden";
	private static var EquipTimeout:Number;
	private static var BuildQueue:Array = new Array();

	public static function AddToQueue(build:String, age:Number) {
		// in case of multiple zone change signals
		for (var i in BuildQueue) {
			if (BuildQueue[i].BuildName == build) {
				return
			}
		}
		clearTimeout(EquipTimeout);
		var Equipper:Build = new Build(build);
		Equipper.BuildEquipped.Connect(Dispose);
		BuildQueue.push(Equipper);
		EquipTimeout = setTimeout(Equip, 500);
	}
	private static function Equip(){
		var oldest:Build;
		for (var i in BuildQueue){
			var build:Build = BuildQueue[i];
			if (build.Age < oldest.Age || !oldest.Age){
				oldest = build;
			}
		}
		if (oldest){
			oldest.EquipBuild();
		}
	}
	private static function Dispose(Build) {
		for (var i in BuildQueue) {
			if (BuildQueue[i] == Build) {
				BuildQueue.splice(Number(i), 1);
			}
		}
		if (BuildQueue.length > 0){
			Equip();
		}
	}
// ----
	public var BuildName:String;
	public var Age:Number;
	public var BuildEquipped:Signal;
	private var DisconnecTimeout:Number;

	public function Build(build) {
		BuildName = build;
		BuildEquipped = new Signal();
	}
	private function EquipBuild(ran:Boolean) {
		clearTimeout(DisconnecTimeout);
		if ((_root["boobuilds\\boobuilds"] && !_root["boobuilds\\boobuilds"].appBuilds.m_builds[0] && !ran) ||
		!Player.GetPlayer().IsinPlay() ||
		Player.GetPlayer().GetCommandProgress()) {
			setTimeout(Delegate.create(this, EquipBuild), 250, true);
			return
		}
		com.GameInterface.Chat.SignalShowFIFOMessage.Connect(FIFOMessageHandler, this);
		DisconnecTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
		// Quick build
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i].m_name == BuildName) {
				DistributedValueBase.SetDValue("BooBuilds_LoadBuild", BuildName);
				return
			}
		}
		// boobuild
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_builds) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name == BuildName) {
				if (_root["boobuilds\\boobuilds"].appBuilds.m_settings.CurrentBuild != _root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_id){
					DistributedValueBase.SetDValue("BooBuilds_LoadBuild", BuildName);
					return
				}
				// Already using build
				else{
					Disconnect();
					return
				}
			}
		}
		// Boo outfit
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_outfits) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_name == BuildName) {
				if (_root["boobuilds\\boobuilds"].appBuilds.m_settings.CurrentOutfit != _root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_id){
					DistributedValueBase.SetDValue("BooBuilds_LoadOutfit", BuildName);
					return
				}
				// Already using build
				else{
					Disconnect();
					return
				}
			}
		}
		// Gear manager
		if (GearManager.GetBuild(BuildName).m_ItemArray) {
			GearManager.UseBuild(BuildName);
			return
		}
	}
	private function Disconnect() {
		com.GameInterface.Chat.SignalShowFIFOMessage.Disconnect(FIFOMessageHandler, this);
		BuildEquipped.Emit(this);
	}
	// From booBuilds
	private function FIFOMessageHandler(text:String, mode:Number) {
		if (text != null && (text.indexOf(CANT_UNEQUIP_ENG, 0) == 0 || text.indexOf(CANT_UNEQUIP_FR, 0) == 0 || text.indexOf(CANT_UNEQUIP_DE) == 0)) {
			EquipBuild(true);
		}
	}
}