import com.Utils.SignalGroup;
import com.Utils.StringUtils;
import com.fox.AgentSwitcher.Utils.Build;
import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.NameFilter;
import com.fox.AgentSwitcher.Utils.Player;
import com.fox.AgentSwitcher.data.ProximityEntry;
import com.fox.AgentSwitcher.trigger.CoordinateTrigger;
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
	private var m_SignalGroup:SignalGroup;
	private var ProximityCopy:Array; // Copy of proximity array with underleveled agents removed
	private var KillTriggers:Array = [];
	private var ProximityTriggers:Array = [];
	private var CoordinateTriggers:Array = [];
	private var ZoneTriggers:Array = [];
	private var retry:Number;
	public var Lock:Boolean = false;

	public function Proximity(cont:Controller) {
		m_Controller = cont;
		WaypointInterface.SignalPlayfieldChanged.Connect(WipeMobTriggers, this);
		m_SignalGroup = new SignalGroup();
	}

	public function SetState(state:Boolean, ran:Boolean, roleChanged:Boolean) {
		clearTimeout(retry);
		if (!Enabled && state) {
			// wait boo for little bit longer
			if (!Build.BooIsLoaded() && !ran) {
				retry = setTimeout(Delegate.create(this, SetState), 1000, state, true, roleChanged);
				return
			}
			Enabled = true;
			GetProximitylistCopy();
		}
		else if (Enabled && !state) {
			Enabled = false;
			m_SignalGroup.DisconnectAll();
			WipeMobTriggers();
			WipeZoneTriggers();
			WipeCoordinateTriggers();
		}
		if (Enabled && roleChanged) {
			//UtilsBase.PrintChatText("role changed,reload");
			ReloadProximityList();
		}
	}

	public function WipeMobTriggers() {
		for (var trigger in KillTriggers) {
			KillTrigger(KillTriggers[trigger]).SignalDestruct.Disconnect(RemoveKillTrigger, this);
			KillTrigger(KillTriggers[trigger]).SignalLock.Disconnect(SetLock, this);
			KillTrigger(KillTriggers[trigger]).kill();
		}
		for (var trigger in ProximityTriggers) {
			ProximityTrigger(ProximityTriggers[trigger]).SignalDestruct.Disconnect(RemoveProximityTrigger, this);
			ProximityTrigger(ProximityTriggers[trigger]).SignalLock.Disconnect(SetLock, this);
			ProximityTrigger(ProximityTriggers[trigger]).kill();
		}
		Task.RemoveTasksByType(Task.OutCombatTask);
		Task.RemoveTasksByType(Task.InCombatTask);
		ProximityTriggers = new Array();
		KillTriggers = new Array();
		Lock = false;
	}

	public function WipeZoneTriggers() {
		Task.RemoveTasksByType(Task.inPlayTask);
		for (var trigger in ZoneTriggers) {
			ZoneTriggers[trigger].kill();
		}
		ZoneTriggers = new Array();
	}
	
	public function WipeCoordinateTriggers() {
		for (var trigger in CoordinateTriggers) {
			CoordinateTriggers[trigger].kill();
		}
		CoordinateTriggers = new Array();
	}
	
	public function ReloadProximityList() {
		if (Enabled && !m_Controller.settingPause) {
			WipeZoneTriggers();
			WipeMobTriggers();
			WipeCoordinateTriggers();
			GetProximitylistCopy();
		}
	}

	public function inProximity() {
		if (Lock) return true;
		for (var trigger in ProximityTriggers) {
			if (ProximityTriggers[trigger].InRange()) {
				return true;
			}
		}
		for (var trigger in CoordinateTriggers) {
			if (CoordinateTriggers[trigger].InRange()) {
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

	public function ReleaseLock() {
		Lock = false;
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
			// if there's only one entry then it can't be area trigger
			entryObj.Agent = StringUtils.Strip(entry[1]) || "race";
			entryObj.Range = StringUtils.Strip(entry[2].toLowerCase()) || m_Controller.settingRange.toLowerCase();
			entryObj.Role = StringUtils.Strip(entry[3].toLowerCase()) || m_Controller.settingRole.toLowerCase() || "all";
			// skip empty lines, lines that start with #, and wrong roles
			if (
				!entryObj.Name ||
				entryObj.Name.charAt(0) == "#" ||
				(!Player.IsRightRole(entryObj.Role) && entryObj.Range.toLowerCase() != "onzone")
			) {
				//UtilsBase.PrintChatText("discarding " + entry.toString());
				continue;
			}
			//Figure out if "Agent" is actual agent or build name
			if (entryObj.Agent.toLowerCase() == "default" || entryObj.Agent == "race" ) {
				entryObj.isBuild = false;
			} 
			else {
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
			else if (entryObj.Range.toLowerCase() == "onarea") {
				StartCoordinateTrigger(entryObj);
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
		if (ProximityCopy.length > 0) {
			//UtilsBase.PrintChatText(ProximityCopy.length + " proximity signals to connect");
			m_SignalGroup.DisconnectAll();
			Nametags.SignalNametagAdded.Connect(m_SignalGroup, NametagAdded, this);
			Nametags.SignalNametagUpdated.Connect(m_SignalGroup, NametagAdded, this);
			Nametags.RefreshNametags();
		}else{
			//UtilsBase.PrintChatText("no proximity signals to connect");
			//UtilsBase.PrintChatText(CoordinateTriggers.length +" coord triggers");
			//UtilsBase.PrintChatText(ZoneTriggers.length +" zone triggers");
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
			trigger.AddToAgents(entry.Agent, entry.Role);
		}
		trigger.StartTrigger();
	}
	
	private function StartCoordinateTrigger(entry:ProximityEntry) {
		if (entry.isBuild != false) {
			entry.isBuild = true;
		}
		var trigger:CoordinateTrigger = GetTrigger(CoordinateTriggers, entry.Name);
		if (!trigger) {
			trigger = new CoordinateTrigger(entry.Name);
			CoordinateTriggers.push(trigger);
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
	
	private function RemoveCoordinateTrigger(trigger:CoordinateTrigger) {
		for (var i in CoordinateTriggers) {
			if (CoordinateTrigger(CoordinateTriggers[i]) == trigger) {
				CoordinateTrigger(CoordinateTriggers[i]).kill();
				CoordinateTriggers.splice(Number(i), 1);
				break
			}
		}
	}
}