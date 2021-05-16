import com.Utils.LDBFormat;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.DruidSystem;
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
	private static var QueuedEquip:Boolean;
	private static var Agents:Array = [];
	public static var m_Controller:Controller;

	public var BuildName:String;
	public var Age:Number;
	public var Switching:Boolean;
	public var BuildEquipped:Signal;
	private var isOutfit:Boolean;
	private var StartCallback:Function;
	private var FinishCallback:Function;
	private var ReadyToEquipCallback:Function;
	private var DisconnecTimeout:Number;
	private var CheckInterval:Number;
	public var id;
	public var quickbuild;
	
	public static function HookBooBuilds(ran){
		var Loaded:Boolean = BooIsLoaded();
		if (!Loaded && !ran){
			setTimeout(HookBooBuilds, 1000, true);
			return;
		}
		if (Loaded){
			for (var y in _root["boobuilds\\boobuilds"].appBuilds.m_builds){
				if (!_root["boobuilds\\boobuilds"].appBuilds.m_builds[y].Hook){
					var f = function () {
						Build.BooStartBuildApply(this.m_name);
						arguments.callee.base.apply(this, arguments);
					}
					f.base = _root["boobuilds\\boobuilds"].appBuilds.m_builds[y].Apply;
					_root["boobuilds\\boobuilds"].appBuilds.m_builds[y].Apply = f;
					_root["boobuilds\\boobuilds"].appBuilds.m_builds[y].Hook = true;
				}
			}
			/*
			for (var y in _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds){
				var f = function () {
					Build.BooStartBuildApply(this.m_name);
					arguments.callee.base.apply(this, arguments);
				}
				f.base = _root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[y].Apply;
				_root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds[y].Apply = f;
			}
			*/
		}
	}
	
	// Saves equipped agents if necessary when manually swapping builds
	public static function BooStartBuildApply(name){
		if (!QueuedEquip &&
			!m_Controller.settingPause &&
			(m_Controller.AlwaysRestoreAgents || m_Controller.m_Proximity.inProximity())
		){
			var temp = [];
			var currentAgent = DruidSystem.GetAgentInSlot(m_Controller.settingRealSlot).m_AgentId;
			if (currentAgent && DruidSystem.IsDruid(currentAgent)){
				temp.push(string(currentAgent));
			}
			currentAgent = DruidSystem.GetAgentInSlot(m_Controller.settingRealSlot2).m_AgentId;
			if (currentAgent && DruidSystem.IsDruid(currentAgent)){
				temp.push(string(currentAgent));
			}
			if (temp.length > 0) {
				Agents = temp;
				setTimeout(WaitForLoad, 500);
			}
		}
	}
	
	private static function WaitForLoad(){
		if (_global.com.boobuilds.Build.m_buildStillLoading == true){
			setTimeout(WaitForLoad, 500);
			return;
		}
		StartAgentSwitchBack();
	}
	
	private static function StartAgentSwitchBack(){
		if (Agents.length > 0 && 
			m_Controller.m_Player.IsinPlay() &&
			!m_Controller.m_Player.IsInCombat() &&
			(!m_Controller.settingDisableOnTank || !m_Controller.m_Tanking) &&
			(!m_Controller.settingDisableOnHealer || !m_Controller.m_Healing)
		){
			var agent = DruidSystem.GetSwitchAgent(Agents[0],  m_Controller.settingRealSlot,  m_Controller.settingDefaultAgent)
			var agent2 = DruidSystem.GetSwitchAgent(Agents[1],  m_Controller.settingRealSlot2,  m_Controller.settingDefaultAgent2)
			DruidSystem.SwitchToAgents(agent, agent2, m_Controller);
		}
		else{
			Agents = [];
		}
	}
	
	// returns true if at least one of the three has content
	public static function BooIsLoaded():Boolean{
		if (!_root["boobuilds\\boobuilds"]) return false;
		var locs = [
			_root["boobuilds\\boobuilds"].appBuilds.m_quickBuilds,
			_root["boobuilds\\boobuilds"].appBuilds.m_builds,
			_root["boobuilds\\boobuilds"].appBuilds.m_outfits
		];
		for (var loc in locs) for (var y in locs[loc]) return true;
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
	public static function AddToQueue(build:String, age:Number, callback:Function, callback2:Function, isOutfit:Boolean,callback3:Function) {
		for (var i in BuildQueue) {
			if (BuildQueue[i].BuildName == build) {
				return
			}
		}
		clearTimeout(EquipTimeout);
		var Equipper:Build = new Build(build, age, callback, callback2, isOutfit,callback3);
		Equipper.BuildEquipped.Connect(Dispose);
		BuildQueue.push(Equipper);
		EquipTimeout = setTimeout(Equip, 500);
	}
	private static function Equip(){
		if (!BuildQueue.length) return
		if (
			m_Controller.m_Player.IsInCombat() ||
			!m_Controller.m_Player.IsinPlay() ||
			m_Controller.m_Player.GetCommandProgress() // casting
		)
		{
			setTimeout(Equip, 500);
			return
		}
		var oldest:Build;
		for (var i in BuildQueue){
			var build:Build = BuildQueue[i];
			if (build.Switching) return
			if (build.Age < oldest.Age || !oldest.Age) {
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

	public function Build(build:String, age:Number, callback:Function, callback2:Function, isoutfit:Boolean, callback3:Function) {
		BuildName = build;
		Age = age;
		StartCallback = callback;
		FinishCallback = callback2;
		ReadyToEquipCallback = callback3;
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
		QueuedEquip = false;
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
		if (m_Controller.m_Player.IsInCombat() ||
			Player.HasCooldown(BuildName) ||
			!m_Controller.m_Player.IsinPlay() ||
			m_Controller.m_Player.GetCommandProgress())
		{
			setTimeout(Delegate.create(this, EquipBuild), 500);
			return
		}
		DisconnecTimeout = setTimeout(Delegate.create(this, Disconnect), 10000);
		CheckInterval = setInterval(Delegate.create(this, checkIfloaded), 200);
		ReadyToEquipCallback();
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
					QueuedEquip = true;
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
		}
		else {
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
		if (text.indexOf(CANT_UNEQUIP, 0) == 0) {
			clearTimeout(DisconnecTimeout);
			clearInterval(CheckInterval);
			DisconnecTimeout = setTimeout(Delegate.create(this, EquipBuild), 1000);
		}
	}
}