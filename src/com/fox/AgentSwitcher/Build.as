import com.Utils.LDBFormat;
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
	private static var CANT_UNEQUIP:String = LDBFormat.LDBGetText(100, 32580734);
	private static var EquipTimeout:Number;
	private static var BuildQueue:Array = new Array();

	public static function AddToQueue(build:String, age:Number, callback:Function) {
		for (var i in BuildQueue) {
			if (BuildQueue[i].BuildName == build) {
				return
			}
		}
		clearTimeout(EquipTimeout);
		var Equipper:Build = new Build(build, age, callback);
		Equipper.BuildEquipped.Connect(Dispose);
		BuildQueue.push(Equipper);
		EquipTimeout = setTimeout(Equip, 500);
	}
	private static function Equip(){
		if (!BuildQueue.length) return
		if (Player.GetPlayer().IsInCombat() ||
		Player.HasCooldown() ||
		!Player.IsinPlay() ||
		Player.GetPlayer().GetCommandProgress()) {
			setTimeout(Equip, 500);
			return
		}
		
		var oldest:Build;
		for (var i in BuildQueue){
			var build:Build = BuildQueue[i];
			if(build.Switching) return
			if ((build.Age < oldest.Age || !oldest.Age)){
				oldest = build;
			}
		}
		if(oldest){
			oldest.Switching = true;
			oldest.StartEquip();
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
	public var Switching:Boolean;
	public var BuildEquipped:Signal;
	private var Callback:Function;
	private var DisconnecTimeout:Number;
	private var CheckInterval:Number;

	public function Build(build, age, callback) {
		BuildName = build;
		Age = age;
		Callback = callback;
		BuildEquipped = new Signal();
	}
	// checks if latest boobuilds info message was for succesful equipping
	private function checkIfloaded(){
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_info.m_msgList){
			if (_root["boobuilds\\boobuilds"].appBuilds.m_info.m_msgList[i].ErrorMsgText.text == "Build loaded: " + BuildName){
				Disconnect();
			}
			break
		}
	}
	public function StartEquip(){
		Callback();
		com.GameInterface.Chat.SignalShowFIFOMessage.Connect(FIFOMessageHandler, this);
		EquipBuild();
	}
	private function EquipBuild() {
		clearTimeout(DisconnecTimeout);
		clearInterval(CheckInterval);
		if (Player.GetPlayer().IsInCombat() ||
		Player.HasCooldown() ||
		!Player.IsinPlay() ||
		Player.GetPlayer().GetCommandProgress()) {
			setTimeout(Delegate.create(this,EquipBuild), 500, true);
			return
		}
		DisconnecTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
		CheckInterval = setInterval(Delegate.create(this, checkIfloaded), 100);
		// Quick build
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i].m_name == BuildName) {
				DistributedValueBase.SetDValue("BooBuilds_LoadQuickBuild", BuildName);
				return
			}
			// Quick builds should be loaded regardless of used build
		}
		// boobuild
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_builds) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name == BuildName) {
				DistributedValueBase.SetDValue("BooBuilds_LoadBuild", BuildName);
				return
			}
		}
		// Boo outfit
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_outfits) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_name == BuildName) {
				DistributedValueBase.SetDValue("BooBuilds_LoadOutfit", BuildName);
				return
			}
		}
		// Gear manager
		if (GearManager.GetBuild(BuildName).m_ItemArray) {
			GearManager.UseBuild(BuildName);
			return
		}
	}
	private function Disconnect() {
		clearInterval(CheckInterval);
		clearTimeout(DisconnecTimeout);
		com.GameInterface.Chat.SignalShowFIFOMessage.Disconnect(FIFOMessageHandler, this);
		BuildEquipped.Emit(this);
	}
	// From booBuilds
	private function FIFOMessageHandler(text:String, mode:Number) {
		if (text.indexOf(CANT_UNEQUIP,0) == 0) {
			clearTimeout(DisconnecTimeout);
			clearInterval(CheckInterval);
			DisconnecTimeout = setTimeout(Delegate.create(this, EquipBuild), 1000);
		}
	}
}