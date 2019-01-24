import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.data.ProximityEntry;
import com.fox.AgentSwitcher.trigger.KillTrigger;
import com.fox.AgentSwitcher.trigger.ProximityTrigger;
import com.fox.AgentSwitcher.trigger.ZoneTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.AgentSystem;
import com.GameInterface.Game.Character;
import com.GameInterface.Nametags;
import com.GameInterface.WaypointInterface;
import com.Utils.ID32;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Proximity {
	private var m_Controller:Controller;
	private var m_Player:Player;
	private var Enabled:Boolean;
	private var ProximityCopy:Array; // Copy of proximity array with underleveled agents removed
	private var TrackedNametags:Object = new Object(); // Arrays of triggers with mob name as key
	private var TrackedZones:Object = new Object(); // Arrays of triggers with zoneID as key
	public var Lock:Boolean = false;

	public function Proximity(cont:Controller) {
		m_Controller = cont;
		m_Player = m_Controller.m_Player;
		WaypointInterface.SignalPlayfieldChanged.Connect(WipeMobTriggers, this);
	}

	public function SetState(state:Boolean) {
		if (!Enabled && state) {
			Enabled = true;
			GetProximitylistCopy();
			if (ProximityCopy.length > 0) {
				Nametags.SignalNametagAdded.Connect(NametagAdded, this);
				Nametags.SignalNametagUpdated.Connect(NametagAdded, this);
				Nametags.RefreshNametags();
			}
		}
		if (Enabled && !state) {
			Enabled = false;
			Nametags.SignalNametagAdded.Disconnect(NametagAdded, this);
			Nametags.SignalNametagUpdated.Disconnect(NametagAdded, this);
			WipeMobTriggers();
			WipeZoneTriggers();
		}
	}

	public function WipeMobTriggers() {
		for (var id in TrackedNametags) {
			for (var trigger in TrackedNametags[id]) {
				TrackedNametags[id][trigger].SignalDestruct.Disconnect(RemoveTrigger, this);
				TrackedNametags[id][trigger].SignalLock.Disconnect(SetLock, this);
				TrackedNametags[id][trigger].kill();
			}
		}
		Task.RemoveTasksByType(Task.OutCombatTask);
		Task.RemoveTasksByType(Task.InCombatTask);
		// Build switches can stil be finished after zoning
		TrackedNametags = new Object();
		Lock = false;
		for (var i in ProximityCopy) {
			ProximityCopy[i].disabled = false;
		}
	}

	public function WipeZoneTriggers() {
		Task.RemoveTasksByType(Task.inPlayTask);
		for (var zone in TrackedZones) {
			for (var trigger in TrackedZones[zone]) {
				TrackedZones[zone][trigger].kill();
			}
		}
		TrackedZones = new Object();
	}

	public function ReloadProximityList() {
		WipeMobTriggers();
		WipeZoneTriggers();
		GetProximitylistCopy();
		Nametags.RefreshNametags();
	}

	public function inProximity() {
		if(Lock) return true
		for (var id in TrackedNametags) {
			for (var trigger in TrackedNametags[id]) {
				if (TrackedNametags[id][trigger].InRange()) {
					return true;
				}
			}
		}
	}

	public function SetLock() {
		if (!Lock) {
			Lock = true;
			var f:Function = Delegate.create(this, ReleaseLock);
			Task.AddTask(Task.InCombatTask, f);
		}
	}

	private function ReleaseLock() {
		Lock = false;
	}

	// Updates refresh rates for proximity based triggers
	public function RangeChanged(old:String) {
		WipeMobTriggers();
		GetProximitylistCopy();
		Nametags.RefreshNametags();
	}

	// Updates refresh rates for proximity based triggers
	public function UpdateRateChanged() {
		for (var id in TrackedNametags) {
			for (var trigger in TrackedNametags[id]) {
				if (TrackedNametags[id][trigger] instanceof ProximityTrigger) {
					TrackedNametags[id][trigger].SetRefresh();
				}
			}
		}
	}
	
	// When build trigger gets triggered we don't want to change agent back if agent switch has been queued
	// We also want to delay agent change until build finishes changing
	public function HasTrigger(TriggerType:Number, id:String, isbuild:Boolean){
		// Proximity
		if (TriggerType == 0){
			var Triggers:Array = TrackedNametags[id];
			for (var i:Number = 0; i < Triggers.length; i++){
				if (Triggers[i] instanceof ProximityTrigger){
					if (Triggers[i].isBuild == isbuild){
						return true;
					}
				}
			}
		}
		// Kill
		else if (TriggerType == 1){
			var Triggers:Array = TrackedNametags[id];
			for (var i:Number = 0; i < Triggers.length; i++){
				if (Triggers[i] instanceof KillTrigger){
					if (Triggers[i].isBuild == isbuild){
						return true;
					}
				}
			}
		}
		// Zone
		else if (TriggerType == 2){
			var Triggers:Array = TrackedZones[id];
			for (var i:Number = 0; i < Triggers.length; i++){
				if (Triggers[i] instanceof ZoneTrigger){
					if (Triggers[i].isBuild == isbuild){
						return true;
					}
				}
			}
		}
	}

	
	/*
	UNUSED, not always desirable behaviour (e.g after wiping on DW6), may need to add single use proximity triggers?
	Once proximity build switch triggers it be can be disabled so it wont trigger again after each wipe
	
	public function DisableBuildTrigger(pattern:String, range:Number, Build:String) {
		Debugger.PrintText("Attempting to disable proximity " + pattern + range + Build);
		for (var i = 0; i < ProximityCopy.length; i++) {
			var entry:ProximityEntry = ProximityCopy[i];
			if (entry.Name == pattern && entry.Range != "onkill" && range == entry.Range && Build == entry.Agent) {
				entry.disabled = true;
				ProximityCopy[i] = entry;
				Debugger.PrintText("Found and disabled proximity trigger for " + pattern);
				break
			}
		}
	}
	*/

	// Gets copy of ProximityList with underleveled agents removed
	// Also starts the zone triggers
	public function GetProximitylistCopy() {
		ProximityCopy = new Array();
		for (var i:Number = 0; i < m_Controller.settingPriority.length; i++){
			var entry:Array = m_Controller.settingPriority[i].split("|");
			var entryObj:ProximityEntry = new ProximityEntry();
			entryObj.Name = entry[0];
			entryObj.Agent = entry[1] || m_Controller.settingDefaultAgent;
			entryObj.Range = entry[2].toLowerCase() || m_Controller.settingRange;
			entryObj.Role = entry[3].toLowerCase() || "all";
			if (!entryObj.Name) {
				continue;
			}
			
			//Figure out if "Agent" is actual agent or build name
			if (entryObj.Agent.toLowerCase() == "default") {
				entryObj.isBuild = false;
			} else {
				for (var x in DruidSystem.Druids) {
					if (DruidSystem.Druids[x][1].toLowerCase() == entryObj.Agent.toLowerCase()) {
						entryObj.Agent = string(DruidSystem.Druids[x][0]);
						entryObj.isBuild = false;
						break
					}
					/* If agent/buildname is a number,and player doesn't own agent with that ID
					 * If buildname is the same as one of the agentID's there will be a conflict, unlikely to happen when agentID's are all 4 digit
					*/
				}
				if (entryObj.isBuild != false){
					if (!isNaN(Number(entryObj.Agent)) && AgentSystem.HasAgent(Number(entryObj.Agent))) {
						entryObj.isBuild = false;
					}
				}
			}
			
			// onZone triggers
			if (entryObj.Range.toLowerCase() == "onzone") {
				if (!TrackedZones[entryObj.Name]) {
					TrackedZones[entryObj.Name] = new Array();
				}
				if (entryObj.isBuild != false){
					entryObj.isBuild = true;
				}
				var Trigger:ZoneTrigger = new ZoneTrigger(entryObj.Name, entryObj.Agent, entryObj.Role, entryObj.isBuild);
				Trigger.StartTrigger();
				TrackedZones[entryObj.Name].push(Trigger);
			}
			// Nametags
			else {
				if (entryObj.isBuild == false) {
					if (entryObj.Agent.toLowerCase() == "default"){
						ProximityCopy.push(entryObj);
					}
					else if (AgentSystem.HasAgent(Number(entryObj.Agent))) {
						if (Number(entryObj.Agent) == m_Controller.settingDefaultAgent && AgentSystem.GetAgentById(Number(entryObj.Agent)).m_Level >= 25) {
							ProximityCopy.push(entryObj);
						} else if (AgentSystem.GetAgentById(Number(entryObj.Agent)).m_Level == 50) {
							ProximityCopy.push(entryObj);
						}
					}
				} else {
					entryObj.isBuild = true;
					ProximityCopy.push(entryObj);
				}
			}
		}
	}

	private function NametagAdded(id:ID32) {
		var char:Character = new Character(id);
		if (!TrackedNametags[id.toString()]) {
			for (var i:Number = 0; i < ProximityCopy.length; i++){
				var entry:ProximityEntry = ProximityCopy[i];
				if (entry.disabled) {
					continue
				} else if (char.GetName().toLowerCase().indexOf(entry.Name.toLowerCase()) >= 0) {
					if (Player.IsRightRole(entry.Role) || !entry.isBuild) {
						if (!TrackedNametags[id.toString()]) {
							TrackedNametags[id.toString()] = new Array();
						}
						if (entry.Range != "onkill") {
							var Trigger:ProximityTrigger= new ProximityTrigger(id, entry.Agent, Number(entry.Range), entry.isBuild);
							Trigger.SignalDestruct.Connect(RemoveTrigger, this);
							Trigger.StartTrigger();
							TrackedNametags[id.toString()].push(Trigger);
						} else {
							var Trigger:KillTrigger = new KillTrigger(id, entry.Agent, entry.isBuild);
							Trigger.SignalDestruct.Connect(RemoveTrigger, this);
							Trigger.SignalLock.Connect(SetLock, this);
							TrackedNametags[id.toString()].push(Trigger);
						}
					}
				}
			}
		}
	}

	// Removes all triggers belonging to mobID from tracked objects
	// Task will keep reference to them if they are still doing something
	private function RemoveTrigger(id:ID32) {
		delete TrackedNametags[id.toString()];
	}
}