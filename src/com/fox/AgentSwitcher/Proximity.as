import com.fox.AgentSwitcher.Build;
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
	private var KillTriggers:Array = new Array(); // Arrays of KillTriggers
	private var ProximityTriggers:Array = new Array(); // Arrays of ProximityTriggers
	private var ZoneTriggers:Array = new Array(); // Arrays of ZoneTriggers
	public var Lock:Boolean = false;

	public function Proximity(cont:Controller) {
		m_Controller = cont;
		m_Player = m_Controller.m_Player;
		WaypointInterface.SignalPlayfieldChanged.Connect(WipeMobTriggers, this);
	}

	public function SetState(state:Boolean, ran:Boolean) {
		// wait boo for little bit longer
		if (!Enabled && state) {
			if (!Build.BooIsLoaded() && !ran){
				setTimeout(Delegate.create(this, SetState), 1000, state, true);
				return
			}
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
		for (var trigger in KillTriggers) {
			KillTriggers[trigger].SignalDestruct.Disconnect(RemoveKillTrigger, this);
			KillTriggers[trigger].SignalLock.Disconnect(SetLock, this);
			KillTriggers[trigger].kill();
		}
		for (var trigger in ProximityTriggers) {
			ProximityTriggers[trigger].SignalDestruct.Disconnect(RemoveProximityTrigger, this);
			ProximityTriggers[trigger].SignalLock.Disconnect(SetLock, this);
			ProximityTriggers[trigger].kill();
		}
		Task.RemoveTasksByType(Task.OutCombatTask);
		Task.RemoveTasksByType(Task.InCombatTask);
		ProximityTriggers = new Array();
		KillTriggers = new Array();
		Lock = false;
	}

	public function WipeZoneTriggers(caller) {
		Task.RemoveTasksByType(Task.inPlayTask);
		for (var trigger in ZoneTriggers) {
			ZoneTriggers[trigger].kill();
		}
		ZoneTriggers = new Array();
	}

	public function ReloadProximityList() {
		WipeMobTriggers();
		GetProximitylistCopy();
		Nametags.RefreshNametags();
	}

	public function inProximity() {
		if(Lock) return true
		for (var trigger in ProximityTriggers) {
			if (ProximityTriggers[trigger].InRange()) {
				return true;
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
		if(Enabled && !m_Controller.settingPause) {
			WipeMobTriggers();
			GetProximitylistCopy();
			Nametags.RefreshNametags();
		}
	}

	// Updates refresh rates for proximity based triggers
	public function UpdateRateChanged() {
		for (var trigger in ProximityTriggers) {
			ProximityTriggers[trigger].SetRefresh();
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
	private function GetTrigger(array:Array, id:String){
		for (var i:Number = 0; i < array.length ; i++ ) {
			if (array[i].ID == id){
				return array[i];
			}
		}
		return false
	}

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
				}
				if (entryObj.isBuild != false){
					/* If agent/buildname is a number,and player doesn't own agent with that ID
					* If buildname is the same as one of the agentID's there will be a conflict, unlikely to happen when agentID's are all 4 digit
					*/
					if (!isNaN(Number(entryObj.Agent)) && AgentSystem.HasAgent(Number(entryObj.Agent))) {
						entryObj.isBuild = false;
					}
				}
			}
			
			// onZone triggers
			if (entryObj.Range.toLowerCase() == "onzone") {
				if (entryObj.isBuild != false){
					entryObj.isBuild = true;
				}
				var trigger:ZoneTrigger = GetTrigger(ZoneTriggers, entryObj.Name);
				if (!trigger){
					trigger = new ZoneTrigger(entryObj.Name);
					ZoneTriggers.push(trigger);
				}
				// Zone triggers only get loaded once, so builds/agent/outfits must be stored in an array, ignoring the role
				// Role is only checked on trigger.
				if (entryObj.isBuild){
					if (Build.HasBuild(entryObj.Agent)){
						trigger.BuildNames.push(entryObj.Agent);
						trigger.BuildRoles.push(entryObj.Role);
					}
					if (Build.HasOutfit(entryObj.Agent)){
						trigger.OutfitNames.push(entryObj.Agent);
						trigger.OutfitRoles.push(entryObj.Role);
					}
				}
				else{
					trigger.AgentNames.push(entryObj.Agent);
					trigger.AgentRoles.push(entryObj.Role);
				}
				trigger.StartTrigger();
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
		var charName = char.GetName().toLowerCase();
		if (!GetTrigger(ProximityTriggers, charName) && !GetTrigger(KillTriggers, charName)) {
			for (var i:Number = 0; i < ProximityCopy.length; i++){
				var entryObj:ProximityEntry = ProximityCopy[i];
				/*
				if (entryObj.disabled) {
					continue
				}
				*/
				if (charName.indexOf(entryObj.Name.toLowerCase()) >= 0) {
					if (Player.IsRightRole(entryObj.Role)) {
						if (entryObj.Range != "onkill") {
							// Using charName as trigger ID, that way it wont create new trigger for every enemy of same name
							var trigger:ProximityTrigger = GetTrigger(ProximityTriggers, charName);
							if (!trigger){
								trigger = new ProximityTrigger(charName, Number(entryObj.Range));
								trigger.SignalDestruct.Connect(RemoveProximityTrigger, this);
								ProximityTriggers.push(trigger);
							}
							if (entryObj.isBuild){
								if (Build.HasBuild(entryObj.Agent)){
									trigger.BuildName = entryObj.Agent;
									trigger.BuildRole = entryObj.Role
								}
								if (Build.HasOutfit(entryObj.Agent)){
									trigger.OutfitName = entryObj.Agent;
									trigger.OutfitRole = entryObj.Role
								}
							}
							else{
								trigger.AgentName = entryObj.Agent;
								trigger.AgentRole = entryObj.Role
							}
							trigger.StartTrigger(id);
						} 
						else {
							var trigger:KillTrigger = GetTrigger(KillTriggers, charName);
							if (!trigger){
								trigger = new KillTrigger(charName);
								trigger.SignalLock.Connect(SetLock, this);
								trigger.SignalDestruct.Connect(RemoveKillTrigger, this);
								KillTriggers.push(trigger);
							}
							if (entryObj.isBuild){
								if (Build.HasBuild(entryObj.Agent)){
									trigger.BuildName = entryObj.Agent;
									trigger.BuildRole = entryObj.Role
								}
								if (Build.HasOutfit(entryObj.Agent)){
									trigger.OutfitName = entryObj.Agent;
									trigger.OutfitRole = entryObj.Role
								}
							}
							else{
								trigger.AgentName = entryObj.Agent;
								trigger.AgentRole = entryObj.Role
							}
							trigger.StartTrigger(id);
						}
					}
				}
			}
		}
	}

	// Removes all triggers belonging to mobID from proxity triggers
	private function RemoveProximityTrigger(trigger:ProximityTrigger) {
		for (var i in ProximityTriggers){
			if (ProximityTriggers[i] == trigger){
				ProximityTriggers[i].kill();
				ProximityTriggers.splice(Number(i), 1);
			}
		}
	}
	// Removes all triggers belonging to mobID from kill triggers
	private function RemoveKillTrigger(trigger:ProximityTrigger) {
		for (var i in KillTriggers){
			if (KillTriggers[i] == trigger){
				KillTriggers[i].kill();
				KillTriggers.splice(Number(i), 1);
			}
		}
	}
}