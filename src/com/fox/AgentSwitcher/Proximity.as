import com.GameInterface.AgentSystem;
import com.GameInterface.Game.Character;
import com.GameInterface.Nametags;
import com.GameInterface.WaypointInterface;
import com.Utils.ID32;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.data.ProximityEntry;
import com.fox.AgentSwitcher.trigger.KillTrigger;
import com.fox.AgentSwitcher.trigger.ProximityTrigger;
import com.fox.AgentSwitcher.trigger.ZoneTrigger;
import com.fox.Utils.AgentHelper;
import com.fox.Utils.Builds;
import com.fox.Utils.Task;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Proximity{
	private var m_Controller:Controller;
	private var Enabled:Boolean;
	private var ProximityCopy:Array;//Copy of proximity array with underleveled agents removed
	private var TrackedNametags:Object = new Object();
	private var TrackedZones:Object = new Object();
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
		Task.RemoveTasksByType(Task.OutCombatTask);
		Task.RemoveTasksByType(Task.InCombatTask);
		if (!Enabled){
			Task.RemoveTasksByType(Task.BuildTask);
			for (var i in TrackedZones){
				TrackedZones[i].kill();
			}
			TrackedZones = new Object();
		}
		// Build switches can stil be finished after zoning
		TrackedNametags = new Object();
		Lock = false;
		for (var i in ProximityCopy){
			ProximityCopy[i].disabled = false;
		}
		
	}
	public function SetState(state:Boolean){
		if (!Enabled && state){
			GetPriorityCopy();
			if (ProximityCopy.length > 0){
				Enabled = true;
				Nametags.SignalNametagAdded.Connect(NametagAdded, this);
				Nametags.SignalNametagUpdated.Connect(NametagAdded, this);
				Nametags.RefreshNametags();
			}else{
				Enabled = false;
			}
		}
		if (Enabled && !state){
			Enabled = false;
			Nametags.SignalNametagAdded.Disconnect(NametagAdded, this);
			Nametags.SignalNametagUpdated.Disconnect(NametagAdded, this);
			WipeTrackingList();
		}
	}
	public function inProximity() {
		if (Lock) return true;
		for (var id in TrackedNametags) {
			for (var trigger in TrackedNametags[id]){
				if (TrackedNametags[id][trigger].InRange()){
					return true;
				}
			}
		}
	}
	
	public function SetLock(){
		if (!Lock){
			Lock = true;
			var f:Function = Delegate.create(this,ReleaseLock)
			Task.AddTask(Task.InCombatTask, f);
		}
	}
	
	private function ReleaseLock(){
		Lock = false;
	}
	
	public function RangeChanged(old:String) {
		TrackedNametags = new Object();
		Nametags.RefreshNametags();
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
	
	/* 
	* Once proximity build switch triggers it be can be disabled so it wont trigger again after each wipe
	* KillTrigger is fine as it is, since the target will only trigger Destructed Signal on resetting, and not Killed signal.
	*/ 
	public function DisableBuildTrigger(name:String, range:Number, Build:String){
		for (var i = 0; i < ProximityCopy.length; i++){
			var entry:ProximityEntry = ProximityCopy[i];
			if (name == entry.Name && entry.Range != "onKill" && range == entry.Range && Build == entry.Agent){
				entry.disabled = true;
				ProximityCopy[i] = entry;
				break
			}
		}
		
	}
	
	public function GetPriorityCopy() {
		ProximityCopy = new Array();
		for (var prio in m_Controller.settingPriority) {
			var entry:Array = m_Controller.settingPriority[prio].split("|");
			var entryObj:ProximityEntry = new ProximityEntry();
			entryObj.Name = entry[0];
			entryObj.Agent = entry[1] || m_Controller.settingDefaultAgent;
			entryObj.Range = entry[2].toLowerCase() || m_Controller.settingRange;
			entryObj.Role = entry[3].toLowerCase() || "all";
			if (!entryObj.Name) continue;
			if (entryObj.Range.toLowerCase() == "onzone"){
				entryObj.isBuild = true;
				if (!TrackedZones[entryObj.Name]){
					TrackedZones[entryObj.Name] = new ZoneTrigger(entryObj.Name, entryObj.Agent, entryObj.Role);
				}
			}
			else{
				if (entryObj.Agent.toLowerCase() == "default") {
					entryObj.Agent = string(m_Controller.settingDefaultAgent);
					entryObj.isBuild = false;
				} else {
					for (var i in AgentHelper.Druids) {
						if (AgentHelper.Druids[i][1].toLowerCase() == entryObj.Agent.toLowerCase()) {
							entryObj.Agent = string(AgentHelper.Druids[i][0]);
							entryObj.isBuild = false;
							break
						}
						/* If agent/buildname is a number,and player doesn't own agent with that ID
						 * If buildname is the same as one of the agentID's there will be a conflict, unlikely to happen when agentID's are all 4 digit
						*/
						if (!isNaN(Number(entryObj.Agent)) && AgentSystem.HasAgent(Number(entryObj.Agent))){ 
							entryObj.isBuild = false;
						}
					}
				}
				
				if (entryObj.isBuild == false) {
					if (AgentSystem.HasAgent(Number(entryObj.Agent))) {
						if (Number(entryObj.Agent) == m_Controller.settingDefaultAgent && AgentSystem.GetAgentById(Number(entryObj.Agent)).m_Level >= 25) {
							ProximityCopy.push(entryObj);
						} 
						else if (AgentSystem.GetAgentById(Number(entryObj.Agent)).m_Level == 50) {
							ProximityCopy.push(entryObj);
						}
					}
				}
				else{
					entryObj.isBuild = true;
					ProximityCopy.push(entryObj);
				}
			}
		}
	}

	private function NametagAdded(id:ID32) {
		var char:Character = new Character(id);
		if (!TrackedNametags[id.toString()]) {
			//var char:Character = new Character(id);
			for (var i in ProximityCopy) {
				var entry:ProximityEntry = ProximityCopy[i];
				if (entry.disabled){
					continue
				}
				else if (entry.Name == char.GetName()) {
					if (Builds.IsRightRole(entry.Role) || !entry.isBuild){
						/*
						if (entry.isBuild){
							Debugger.PrintText("Right role for " + entry.Name + " " +entry.Agent);
						}
						*/
						if (!TrackedNametags[id.toString()]){
							// need to be able to use both kill and proximity triggers together (and maybe even more later)
							TrackedNametags[id.toString()] = new Array();
						}
						if (entry.Range != "onkill" && !(!entry.Range && m_Controller.settingRange.toLowerCase() == "onkill")) {
							var Trigger:ProximityTrigger= new ProximityTrigger(id, entry.Agent, Number(entry.Range), entry.isBuild);
							Trigger.SignalDestruct.Connect(RemoveTrigger, this);
							Trigger.StartTrigger();
							TrackedNametags[id.toString()].push(Trigger);
						}else{
							var Trigger:KillTrigger = new KillTrigger(id, entry.Agent, entry.isBuild);
							Trigger.SignalDestruct.Connect(RemoveTrigger, this);
							Trigger.SignalLock.Connect(SetLock, this);
							TrackedNametags[id.toString()].push(Trigger);
						}
					}
					/*
					else{
						Debugger.PrintText("Wrong role for " + entry.Name + " " +entry.Agent);
					}
					*/
				}
			}
		}
	}
	
	private function RemoveTrigger(id:ID32){
		delete TrackedNametags[id.toString()];
	}
}