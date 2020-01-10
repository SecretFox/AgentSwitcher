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

class com.fox.AgentSwitcher.Utils.Build {
	private static var CANT_UNEQUIP:String = LDBFormat.LDBGetText(100, 32580734);
	private static var EquipTimeout:Number;
	private static var BuildQueue:Array = new Array();

	public var BuildName:String;
	public var Age:Number;
	public var Switching:Boolean;
	public var BuildEquipped:Signal;
	private var isOutfit:Boolean;
	private var StartCallback:Function;
	private var FinishCallback:Function;
	private var DisconnecTimeout:Number;
	private var CheckInterval:Number;
	public var id;
	public var quickbuild;
	
	public static function BooIsLoaded():Boolean{
		if(!_root["boobuilds\\boobuilds"]) return true
		if (_root["boobuilds\\boobuilds"].m_quickBuilds[0] || _root["boobuilds\\boobuilds"].m_builds[0] || _root["boobuilds\\boobuilds"].m_outfits[0]){
			return true
		}
		return false
	}
	
	
	public static function HasBuild(buildname:String){
		// quick build
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i].m_name.toLowerCase() == buildname.toLowerCase()) {
				return _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i];
			}
		}
		// boobuild
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_builds) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name.toLowerCase() == buildname.toLowerCase()) {
				return _root["boobuilds\\boobuilds"].appBuilds.m_builds[i]
			}
		}
		// Gear manager
		var buildList:Array = GearManager.GetBuildList();
		for (var i in buildList){
			if (buildList[i].toLowerCase() == buildname.toLowerCase()){
				return true
			}
		}
	}
	public static function HasOutfit(buildname:String){
		// Boo outfit
		for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_outfits) {
			if (_root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_name.toLowerCase() == buildname.toLowerCase()) {
				return true
			}
		}
	}
	public static function AddToQueue(build:String, age:Number, callback:Function, callback2:Function, isOutfit:Boolean) {
		for (var i in BuildQueue) {
			if (BuildQueue[i].BuildName == build) {
				return
			}
		}
		clearTimeout(EquipTimeout);
		var Equipper:Build = new Build(build, age, callback, callback2, isOutfit);
		Equipper.BuildEquipped.Connect(Dispose);
		BuildQueue.push(Equipper);
		EquipTimeout = setTimeout(Equip, 500);
	}
	private static function Equip(){
		if (!BuildQueue.length) return
		if (Player.GetPlayer().IsInCombat()
		|| !Player.IsinPlay()
		|| Player.GetPlayer().GetCommandProgress()) // casting
		{
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
		if(oldest) {
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

	public function Build(build:String, age:Number, callback:Function, callback2:Function, isoutfit:Boolean) {
		BuildName = build;
		Age = age;
		StartCallback = callback;
		FinishCallback = callback2;
		BuildEquipped = new Signal();
		isOutfit = isoutfit;
	}
	private function checkIfloaded(){
		if (!isOutfit){
			if (_global.com.boobuilds.Build.m_buildStillLoading == false){
				if (!quickbuild){
					if (_global.com.boobuilds.Build.m_currentBuildID == id) Disconnect(true);
					else Disconnect(false);
				}
				else{
					if (_global.com.boobuilds.Build.m_currentToggleID == id) Disconnect(true);
					else Disconnect(false);
				}
			}
		}
		else if (isOutfit) {
			for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_info.m_msgList){
				if (_root["boobuilds\\boobuilds"].appBuilds.m_info.m_msgList[i].ErrorMsgText.text.toLowerCase() == "outfit loaded"){
					Disconnect();
				}
			}
		}
	}
	private function FinishedLoading(success){
		FinishCallback(success);
	}
	private function Disconnect(success:Boolean) {
		clearInterval(CheckInterval);
		clearTimeout(DisconnecTimeout);
		com.GameInterface.Chat.SignalShowFIFOMessage.Disconnect(FIFOMessageHandler, this);
		FinishedLoading(success);
		BuildEquipped.Emit(this);
	}
	public function StartEquip(){
		if(StartCallback) StartCallback();
		com.GameInterface.Chat.SignalShowFIFOMessage.Connect(FIFOMessageHandler, this);
		EquipBuild();
	}
	private function EquipBuild() {
		clearTimeout(DisconnecTimeout);
		clearInterval(CheckInterval);
		if (Player.GetPlayer().IsInCombat() ||
			Player.HasCooldown(BuildName) ||
			!Player.IsinPlay() ||
			Player.GetPlayer().GetCommandProgress())
		{
			setTimeout(Delegate.create(this,EquipBuild), 500, true);
			return
		}
		DisconnecTimeout = setTimeout(Delegate.create(this, Disconnect), 5000);
		CheckInterval = setInterval(Delegate.create(this, checkIfloaded), 200);
		if (!isOutfit){
			// Quick build
			for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds) {
				if (_root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i].m_name.toLowerCase() == BuildName.toLowerCase()) {
					id = _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i].m_id;
					quickbuild = true;
					DistributedValueBase.SetDValue("BooBuilds_LoadQuickBuild", _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[i].m_name);
					return
				}
			}
			// boobuild
			for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_builds) {
				if (_root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name.toLowerCase() == BuildName.toLowerCase()) {
					id = _root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_id;
					DistributedValueBase.SetDValue("BooBuilds_LoadBuild", _root["boobuilds\\boobuilds"].appBuilds.m_builds[i].m_name);
					return
				}
			}
			// Gear manager
			var buildList:Array = GearManager.GetBuildList();
			for (var i in buildList){
				if (buildList[i].toLowerCase() == BuildName.toLowerCase()){
					GearManager.UseBuild(buildList[i]);
					return
				}
			}
		}else{
			// Boo outfit
			for (var i in _root["boobuilds\\boobuilds"].appBuilds.m_outfits) {
				if (_root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_name.toLowerCase() == BuildName.toLowerCase()) {
					DistributedValueBase.SetDValue("BooBuilds_LoadOutfit", _root["boobuilds\\boobuilds"].appBuilds.m_outfits[i].m_name);
					return
				}
			}
		}
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