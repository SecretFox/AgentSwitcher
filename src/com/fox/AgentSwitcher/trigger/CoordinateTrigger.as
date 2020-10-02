import com.GameInterface.MathLib.Vector3;
import com.GameInterface.UtilsBase;
//import com.GameInterface.UtilsBase;
import com.GameInterface.WaypointInterface;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.trigger.BaseTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.Game.Character;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.trigger.CoordinateTrigger extends BaseTrigger {
	private var Range:Number;
	private var lockNeeded:Boolean;
	private var refreshInterval:Number;
	private var Char:Character;
	private var TargetCoodinates:Array;
	private var TargetZone:Number;
	private var Triggered:Boolean;
	private var OrgBuilds;
	private var SwitchNeeded:Boolean;
	private var SimpleCoords:Boolean;
	private var BuildOutfitCopies:Array;
	
	//private var namePattern:String; // Name pattern that was used to start the trigger. may be full mob name or partial match

	public function CoordinateTrigger(data) {
		super();
		var vars = data.split(";");
		TargetZone = Number(vars[0]);
		TargetCoodinates = ParseCoordinates(vars[1]);
	}
	
	private function ParseCoordinates(data) {
		var coords:Array = data.split(",");
		if ( coords.length == 2 || coords.length == 3){
			SimpleCoords = true;
			return coords
		}
		else if ( coords.length == 4){
			return [
				new Vector3(Number(coords[0]), 0, Number(coords[1])),
				new Vector3(Number(coords[2]), 0, Number(coords[3]))
			]
		}
		else if (coords.length == 6) {
			return [
				new Vector3(Number(coords[0]), Number(coords[2]), Number(coords[1])),
				new Vector3(Number(coords[3]), Number(coords[5]), Number(coords[4]))
			]
		}
	}
	
	private function CheckZone(id) {
		if ( id == TargetZone) {
			refreshInterval = setInterval(Delegate.create(this, CheckArea), m_Controller.settingUpdateRate);
		} else {
			clearInterval(refreshInterval);
		}
	}
	
	public function StartTrigger() {
		if (!Started){
			BuildOutfitCopies = [BuildNames.concat(), BuildRoles.concat(), OutfitNames.concat(), OutfitRoles.concat()]; //shallow copies of builds/outfits
			Started = true;
			SwitchNeeded = true;
			WaypointInterface.SignalPlayfieldChanged.Connect(CheckZone, this);
			CheckZone(Player.GetZone());
		}
	}
	
	public function SetRefresh() {
		clearInterval(refreshInterval);
		CheckZone(Player.GetZone());
	}
	
	public function kill() {
		if (!destructed){
			destructed = true
			WaypointInterface.SignalPlayfieldChanged.Disconnect(CheckZone, this);
			clearInterval(refreshInterval);
		}
	}
	
	private function InZone() {
		return Player.GetZone() == TargetZone;
	}
	
	private function InArea() {
		var position:Vector3 = Player.GetPosition();
		if (SimpleCoords){
			if (
				Math.abs(position.x - TargetCoodinates[0]) < 10 &&
				Math.abs(position.z - TargetCoodinates[1]) < 10 &&
				(Math.abs(position.y - TargetCoodinates[2]) < 10 || !TargetCoodinates[2])
			){
				return true;
			}
		}
		else if 
		((
			((position.x > TargetCoodinates[0].x && position.x < TargetCoodinates[1].x) || (position.x < TargetCoodinates[0].x && position.x > TargetCoodinates[1].x)) &&
			((position.z > TargetCoodinates[0].z && position.z < TargetCoodinates[1].z) || (position.z < TargetCoodinates[0].z && position.z > TargetCoodinates[1].z)) &&
			(TargetCoodinates[0].y == 0 || (position.y > TargetCoodinates[0].y && position.y < TargetCoodinates[1].y) || (position.y < TargetCoodinates[0].y && position.y > TargetCoodinates[1].y))
		)){
			return true;
		}
	}
	
	
	private function CheckArea() {
		var inside:Boolean = InArea();
		if (inside && SwitchNeeded) {
			if(m_Controller.dValDev.GetValue()) UtilsBase.PrintChatText("Inside area");
			SwitchNeeded = false;
			//clearInterval(refreshInterval);
			if (hasSwitchAgent()){
				lockNeeded = true;
				m_Controller.m_Icon.ApplyLock();
			} else{
				var currentAgent = DruidSystem.GetAgentInSlot(m_Controller.settingRealSlot).m_AgentId;
				if (currentAgent && DruidSystem.IsDruid(currentAgent)){
					AgentNames.push(string(currentAgent));
					AgentRoles.push("all");
				}
			}
			var f2:Function = Delegate.create(this, kill);
			if (BuildNames.length > 0 || OutfitNames.length > 0) {
				var time:Date = new Date();
				Age = time.valueOf();
				var f:Function = Delegate.create(this, EquipBuild);
				Task.AddTask(Task.inPlayTask, f, f2);
			} else {
				//Task.RemoveTasksByType(Task.OutCombatTask); // Remove queued tasks
				var f:Function = Delegate.create(this, EquipAgent);
				Task.AddTask(Task.OutCombatTask, f, f2);
			}
		}
		else if (!inside && !SwitchNeeded) {
			SwitchNeeded = true;
		}
		else if (!inside && m_Controller.dValDev.GetValue()) {
			if (SimpleCoords)
			{
				UtilsBase.PrintChatText("Not in area\n" +
					"    Target " + TargetCoodinates[0]+ ", " + 
					"" + TargetCoodinates[1] + ", " + 
					"" + TargetCoodinates[2]+ "\n" + 
					"    Current " + Math.floor(Player.GetPosition().x) + ", " + Math.floor(Player.GetPosition().z) + "," + Math.floor(Player.GetPosition().y)
				);
			} else {
				UtilsBase.PrintChatText("Not in area\n" +
					"    Target " + TargetCoodinates[0].x +"-" + TargetCoodinates[1].x + ", " + 
					"" + TargetCoodinates[0].z +"-" + TargetCoodinates[1].z + ", " + 
					"" + TargetCoodinates[0].y +"-" + TargetCoodinates[1].y + "\n" + 
					"    Current " + Math.floor(Player.GetPosition().x) + ", " + Math.floor(Player.GetPosition().z) + "," + Math.floor(Player.GetPosition().y)
				);
			}
		}
	}
	
	public function InRange() {
		if (lockNeeded && InZone() && InArea() && !Char.IsDead()) {
			return true
		}
	}
	
	private function OnBuildEquip(success:Boolean){
		if (BuildNames.length > 0 && success){
			EquipBuild();
			return;
		}
		else if (AgentNames.length > 0){
			EquipAgent();
		}
		BuildNames = BuildOutfitCopies[0].concat();
		BuildRoles = BuildOutfitCopies[1].concat();
		OutfitNames = BuildOutfitCopies[2].concat();
		OutfitRoles = BuildOutfitCopies[3].concat();
	}
	
	private function EquipBuild() {
		var f2:Function = Delegate.create(this, OnBuildEquip);
		var found = super.EquipBuild(f2);
		if (!found && AgentNames.length>0) EquipAgent(); // If no build start agent switch
	}
	
	private function EquipAgent() {
		super.EquipAgent();
	}
}