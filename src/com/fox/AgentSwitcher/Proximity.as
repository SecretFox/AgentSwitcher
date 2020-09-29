import com.Utils.StringUtils;
import com.fox.AgentSwitcher.Utils.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.NameFilter;
import com.fox.AgentSwitcher.data.ProximityEntry;
import com.fox.AgentSwitcher.trigger.KillTrigger;
import com.fox.AgentSwitcher.trigger.ProximityTrigger;
import com.fox.AgentSwitcher.trigger.ZoneTrigger;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Utils.Task;
import com.GameInterface.AgentSystem;
import com.GameInterface.Game.Character;
import com.GameInterface.Nametags;
import com.GameInterface.WaypointInterface;
import com.Utils.ID32;
import mx.utils.Delegate;
/*6
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Proximity {
	private var m_Controller:Controller;
	private var Enabled:Boolean;
	private var ProximityCopy:Array; // Copy of proximity array with underleveled agents removed
	private var KillTriggers:Array = [];
	private var ProximityTriggers:Array = [];
	private var ZoneTriggers:Array = [];
	private var retry:Number;
	public var Lock:Boolean = false;

	public function Proximity(cont:Controller) {
		m_Controller = cont;
		WaypointInterface.SignalPlayfieldChanged.Connect(WipeMobTriggers, this);
	}

	public function SetState(state:Boolean, ran:Boolean) {
		clearTimeout(retry);
		if (!Enabled && state) {
			// wait boo for little bit longer
			if (!Build.BooIsLoaded() && !ran) {
				retry = setTimeout(Delegate.create(this, SetState), 1000, state, true);
				return
			}
			Enabled = true;
			GetProximitylistCopy();
			if (ProximityCopy.length > 0) {
				Nametags.SignalNametagAdded.Connect(NametagAdded, this);
				Nametags.SignalNametagUpdated.Connect(NametagAdded, this);
				Nametags.RefreshNametags();
			}
			/* Debugging
			Nametags.SignalNametagAdded.Connect(Delegate.create(this,function(id){
				var data:mobData = DruidSystem.GetRace(id);
				UtilsBase.PrintChatText(string(data.Name) + " "  + data.Race);
			}), this);
			*/
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
		if (Lock) return true;
		for (var trigger in ProximityTriggers) {
			if (ProximityTriggers[trigger].InRange()) {
				return true;
			}
		}
	}

	public function SetLock() {
		if (!Lock) {
			Lock = true;
			m_Controller.m_Icon.ApplyLock();
			var f:Function = Delegate.create(this, ReleaseLock);
			Task.AddTask(Task.InCombatTask, f);
		}
	}

	private function ReleaseLock() {
		Lock = false;
	}

	// Updates refresh rates for proximity based triggers
	public function RangeChanged(old:String) {
		if (Enabled && !m_Controller.settingPause) {
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

	private function GetTrigger(array:Array, id) {
		for (var i:Number = 0; i < array.length ; i++ ) {
			if (array[i].ID == id) {
				return array[i];
			}
		}
		return false
	}

	// Gets copy of ProximityList with underleveled agents removed
	// Also starts the zone triggers
	public function GetProximitylistCopy() {
		ProximityCopy = new Array();
		for (var i:Number = 0; i < m_Controller.settingPriority.length; i++) {
			var entry:Array = m_Controller.settingPriority[i].split("|");
			var entryObj:ProximityEntry = new ProximityEntry();
			entryObj.Name = StringUtils.Strip(entry[0]);
			entryObj.Agent = StringUtils.Strip(entry[1]) || "race";
			entryObj.Range = StringUtils.Strip(entry[2].toLowerCase()) || m_Controller.settingRange.toLowerCase();
			entryObj.Role = StringUtils.Strip(entry[3].toLowerCase()) || "all";
			// skip empty lines
			if (!entryObj.Name) {
				continue;
			}
			//Figure out if "Agent" is actual agent or build name
			if (entryObj.Agent.toLowerCase() == "default" || entryObj.Agent == "race") {
				entryObj.isBuild = false;
			} else {
				for (var x:Number = 0; x < DruidSystem.Druids.length;x++) {
					if (DruidSystem.Druids[x][1].toLowerCase() == entryObj.Agent.toLowerCase()) {
						entryObj.Agent = DruidSystem.Druids[x][0];
						entryObj.isBuild = false;
						break
					}
				}
				if (entryObj.isBuild != false) {
					if (AgentSystem.HasAgent(Number(entryObj.Agent))) {
						entryObj.isBuild = false;
					}
				}
			}

			// Start onZone triggers
			if (entryObj.Range.toLowerCase() == "onzone") {
				StartZoneTrigger(entryObj);
			} 
			//remove entries with unleveled agents, and add rest to active triggers
			else {
				if (entryObj.isBuild != false) {
					entryObj.isBuild = true;
					ProximityCopy.push(entryObj);
				}
				else {
					if (DruidSystem.IsMaxedAgent(entryObj.Agent)) {
						ProximityCopy.push(entryObj);
					}
				}
			}
		}
	}

	private function StartZoneTrigger(entry:ProximityEntry) {
		if (entry.isBuild != false) {
			entry.isBuild = true;
		}
		var trigger:ZoneTrigger = GetTrigger(ZoneTriggers, Number(entry.Name));
		if (!trigger) {
			trigger = new ZoneTrigger(entry.Name);
			ZoneTriggers.push(trigger);
		}
		if (entry.isBuild) {
			if (Build.HasBuild(entry.Agent)) {
				trigger.AddToBuilds(entry.Agent, entry.Role);
			}
			if (Build.HasOutfit(entry.Agent)) {
				trigger.AddToOutfits(entry.Agent, entry.Role);
			}
		} else {
			trigger.AgentNames.push(entry.Agent);
			trigger.AgentRoles.push(entry.Role);
		}
		trigger.StartTrigger();
	}

	private function StartProximityTrigger(entry:ProximityEntry,id:ID32, charName:String) {
		var trigger:ProximityTrigger = GetTrigger(ProximityTriggers, id);
		if (!trigger) {
			trigger = new ProximityTrigger(id, Number(entry.Range));
			trigger.SignalDestruct.Connect(RemoveProximityTrigger, this);
			ProximityTriggers.push(trigger);
		}
		if (entry.isBuild) {
			if (Build.HasBuild(entry.Agent)) {
				trigger.AddToBuilds(entry.Agent, entry.Role);
			}
			if (Build.HasOutfit(entry.Agent)) {
				trigger.AddToOutfits(entry.Agent, entry.Role);
			}
		} else {
			trigger.AddToAgents(entry.Agent, entry.Role);
		}
		trigger.StartTrigger();
	}

	private function StartKillTrigger(entry:ProximityEntry, id:ID32, charName:String) {
		var trigger:KillTrigger = GetTrigger(KillTriggers, id);
		if (!trigger){
			trigger = new KillTrigger(id);
			trigger.SignalLock.Connect(SetLock, this);
			trigger.SignalDestruct.Connect(RemoveKillTrigger, this);
			KillTriggers.push(trigger);
		}
		if (entry.isBuild) {
			if (Build.HasBuild(entry.Agent)) {
				trigger.AddToBuilds(entry.Agent, entry.Role);
			}
			else if (Build.HasOutfit(entry.Agent)) {
				trigger.AddToBuilds(entry.Agent, entry.Role);
			}
		} else {
			trigger.AddToAgents(entry.Agent, entry.Role);
		}
		trigger.StartTrigger();
	}

	private function NametagAdded(id:ID32) {
		var char:Character = new Character(id);
		if (!NameFilter.isFiltered(char)){
			var charName = char.GetName().toLowerCase();
			for (var i:Number = 0; i < ProximityCopy.length; i++) {
				var entry:ProximityEntry = ProximityCopy[i];
				if (charName.indexOf(entry.Name.toLowerCase()) >= 0) {
					if (entry.Range != "onkill"){
						StartProximityTrigger(entry, id, charName);
					} else{
						StartKillTrigger(entry, id, charName);
					}
				}
			}
		}
	}

	private function RemoveKillTrigger(trigger:KillTrigger) {
		for (var i in KillTriggers) {
			if (KillTrigger(KillTriggers[i]) == trigger) {
				KillTrigger(KillTriggers[i]).kill();
				KillTriggers.splice(Number(i), 1);
				break
			}
		}
	}

	private function RemoveProximityTrigger(trigger:ProximityTrigger) {
		for (var i in ProximityTriggers) {
			if (ProximityTrigger(ProximityTriggers[i]) == trigger) {
				ProximityTrigger(ProximityTriggers[i]).kill();
				ProximityTriggers.splice(Number(i), 1);
				break
			}
		}
	}
}