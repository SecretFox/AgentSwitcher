import com.GameInterface.AgentSystem;
import com.GameInterface.Game.Character;
import com.GameInterface.Nametags;
import com.GameInterface.WaypointInterface;
import com.Utils.ID32;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.trigger.KillTrigger;
import com.fox.AgentSwitcher.trigger.ProximityTrigger;
import com.fox.Utils.AgentHelper;
import com.fox.Utils.CombatTask;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Proximity{
	private var m_Controller:Controller;
	private var Enabled:Boolean;
	private var settingPriorityCopy:Array;//Copy of proximity array with underleveled agents removed
	private var TrackedNametags:Object = new Object();
	public var Lock:Boolean = false;

	public function Proximity(cont:Controller) {
		m_Controller = cont;
		WaypointInterface.SignalPlayfieldChanged.Connect(WipeTrackingList, this);
	}
	public function WipeTrackingList(){
		for (var id in TrackedNametags){
			for (var trigger in TrackedNametags[id]){
				TrackedNametags[id][trigger].SignalDestruct.Disconnect(RemoveTrigger, this);
				TrackedNametags[id][trigger].SignalLock.Disconnect(SetLock, this);
				TrackedNametags[id][trigger].kill();
			}
		}
		CombatTask.RemoveAllTasks();
		TrackedNametags = new Object();
		Lock = false;
	}
	public function SetState(state:Boolean){
		if (!Enabled && state){
			GetPriorityCopy()
			if (settingPriorityCopy.length > 0){
				Enabled = true;
				Nametags.SignalNametagAdded.Connect(NametagAdded, this);
				Nametags.SignalNametagUpdated.Connect(NametagAdded, this);
			}
		}
		if (Enabled && !state){
			Nametags.SignalNametagAdded.Disconnect(NametagAdded, this);
			Nametags.SignalNametagUpdated.Disconnect(NametagAdded, this);
			WipeTrackingList();
		}
	}
	public function inProximity() {
		if (Lock) return true;
		for (var id in TrackedNametags) {
			for (var trigger in TrackedNametags[id]){
				if (TrackedNametags[id][trigger] instanceof ProximityTrigger){
					if (TrackedNametags[id][trigger].InRange()){
						return true;
					}
				}
			}
		}
	}
	
	public function SetLock(){
		if (!Lock){
			Lock = true;
			var f:Function = Delegate.create(this,ReleaseLock)
			CombatTask.AddTask(CombatTask.InTask, f);
		}
	}
	
	private function ReleaseLock(){
		Lock = false;
	}
	
	public function RangeChanged(old:String) {
		if (old.toLowerCase() == "onkill" || m_Controller.settingRange.toLowerCase() == "onkill"){
			//Too much trouble to update the old ones
			TrackedNametags = new Object();
		}else{
			for (var id in TrackedNametags) {
				for (var trigger in TrackedNametags[id]){
					if (TrackedNametags[id][trigger] instanceof ProximityTrigger){
						if (TrackedNametags[id][trigger]["Range"] == old){
							TrackedNametags[id][trigger]["Range"] = m_Controller.settingRange;
						}
					}
				}
			}
		}
	}
	public function UpdateRateChanged(){
		for (var id in TrackedNametags){
			for (var trigger in TrackedNametags[id]){
				if (TrackedNametags[id][trigger] instanceof ProximityTrigger){
					TrackedNametags[id][trigger].SetRefresh();
				}
			}
		}
	}
	
	public function GetPriorityCopy() {
		settingPriorityCopy = new Array();
		for (var prio in m_Controller.settingPriority) {
			var entry:Array = m_Controller.settingPriority[prio].split("|");
			if (!entry[1]) { // no override specified
				settingPriorityCopy.push(entry);
			} else {
				var id:Number = undefined;
				if (entry[1].toLowerCase() == "default") {
					id = m_Controller.settingDefaultAgent;
				} else {
					for (var i in AgentHelper.Druids) {
						if (AgentHelper.Druids[i][1].toLowerCase() == entry[1].toLowerCase()) {
							id = AgentHelper.Druids[i][0];
						}
					}
				}
				if (id) {
					if (AgentSystem.HasAgent(id)) {
						if (id == m_Controller.settingDefaultAgent && AgentSystem.GetAgentById(id).m_Level >= 25) {
							settingPriorityCopy.push(entry);
						} else if (AgentSystem.GetAgentById(id).m_Level == 50) {
							settingPriorityCopy.push(entry);
						}
					}
				}
			}
		}
	}
	private function NametagAdded(id:ID32) {
		var char:Character = new Character(id);
		if (!TrackedNametags[id.toString()]) {
			//var char:Character = new Character(id);
			for (var i in settingPriorityCopy) {
				var entry:Array = settingPriorityCopy[i];
				if (entry[0] == char.GetName()) {
					if (!TrackedNametags[id.toString()]){
						// need to be able to use both kill and proximity triggers together (and maybe even more later)
						TrackedNametags[id.toString()] = new Array();
					}
					if (entry[2].toLowerCase() != "onkill" && !(!entry[2] && m_Controller.settingRange.toLowerCase() == "onkill")){
						var Trigger:ProximityTrigger= new ProximityTrigger(id, entry[1], Number(entry[2]) ||  Number(m_Controller.settingRange));;
						Trigger.SignalDestruct.Connect(RemoveTrigger, this);
						Trigger.StartTrigger();
						TrackedNametags[id.toString()].push(Trigger);
					}else{
						var Trigger:KillTrigger = new KillTrigger(id, entry[1]);
						Trigger.SignalDestruct.Connect(RemoveTrigger, this);
						Trigger.SignalLock.Connect(SetLock, this);
						TrackedNametags[id.toString()].push(Trigger);
					}
				}
			}
		}
	}
	
	private function RemoveTrigger(id:ID32){
		delete TrackedNametags[id.toString()];
	}
}