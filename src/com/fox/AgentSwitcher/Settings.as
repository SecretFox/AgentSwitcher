import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.GameInterface.DistributedValue;
import com.Utils.Archive;
import com.Utils.LDBFormat;
import flash.geom.Point;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Settings {
	public var ModVersion:String = "2.3.0";
	
	public var settingDval:DistributedValue;
	public var agentDisplayDval:DistributedValue;
	public var settingDebugChat:Boolean;
	public var settingDebugFifo:Boolean;
	public var settingDefault:Boolean;
	public var settingDefaultDelay:Number;
	public var settingTargeting:Boolean;
	public var settingPause:Boolean;
	public var settingDisableOnSwitch:Boolean;
	public var settingDisableOnTank:Boolean;
	public var settingDefaultAgent:Number;
	public var settingRange:String;
	public var settingSlot:Number;
	public var settingBlacklist:String;
	public var settingPriority:Array;
	public var settingProximityEnabled:Boolean;
	public var settingQuickselectName:Boolean;
	public var settingDisplayName:Boolean;
	public var settingCleaner:Boolean;
	public var settingWalter:Boolean;
	public var settingUpdateRate:Number;
	public var settingRealSlot:Number;
	public var dValImport:DistributedValue;
	public var dValExport:DistributedValue;

	private var m_swfRoot:MovieClip;
	public var DisplayPos:Point;
	public var iconPos:Point;
	public var RecentAgents:Array;

	public function Settings(swfRoot:MovieClip) {
		m_swfRoot = swfRoot;
		settingDval = DistributedValue.Create("AgentSwitcher_Settings");
		settingDval.SetValue(false);
		agentDisplayDval = DistributedValue.Create("AgentSwitcher_Display");
		agentDisplayDval.SetValue(false);
		
		dValImport = DistributedValue.Create("AgentSwitcher_Import");
		dValExport = DistributedValue.Create("AgentSwitcher_Export");
		dValImport.SetValue(false);
		dValExport.SetValue(false);
	}

	public function GetDestinationSlot() {
		settingRealSlot = settingSlot - 1;
	}

	public function LoadConfig(config: Archive):Void {
		settingSlot = config.FindEntry("Slot", 1);
		GetDestinationSlot();

		settingDebugChat = config.FindEntry("DebugChat", false);
		settingDebugFifo = config.FindEntry("DebugFifo", false);
		settingDefault = config.FindEntry("Switch", false);
		settingDefaultDelay = config.FindEntry("Delay", 2000);
		settingDisableOnSwitch = config.FindEntry("DisableOnSwitch", true);
		settingDisableOnTank = config.FindEntry("DisableOnTank", true);
		settingTargeting = config.FindEntry("Active", true);
		settingBlacklist = config.FindEntry("blacklist", "");
		
		settingPause = config.FindEntry("Pause", false);
		settingDefaultAgent = config.FindEntry("Default", 0);
		iconPos = config.FindEntry("iconPos", new Point(200, 50));
		settingRange = config.FindEntry("Range", "40");
		settingUpdateRate = config.FindEntry("UpdateRate", 500);
		settingProximityEnabled = config.FindEntry("PriorityEnable", true);
		DisplayPos = config.FindEntry("DisplayPos", new Point(300,50));
		agentDisplayDval.SetValue(config.FindEntry("Display", false));
		settingDisplayName = config.FindEntry("DisplayName", false);
		settingQuickselectName = config.FindEntry("QuickName", false);
		settingWalter = config.FindEntry("Walter", false);
		settingCleaner = config.FindEntry("Cleaner", false);

		/*
		if (settingProximityEnabled) {
			if (!DistributedValueBase.GetDValue("ShowVicinityNPCNametags")) {
				setTimeout(Delegate.create(this,EmitError), 5000, "AgentSwitcher /option ShowVicinityNPCNametags must be set to true for proximity targeting");
			}
		}
		*/

		if (settingDefaultAgent == 0) {
			settingDefaultAgent = DruidSystem.GetAgentInSlot(settingRealSlot).m_AgentId | 0;
		}

		RecentAgents = config.FindEntryArray("RecentAgents");
		if (!RecentAgents) {
			RecentAgents = new Array();
			if (settingDefaultAgent) RecentAgents.push(settingDefaultAgent);
		}
		settingPriority = config.FindEntryArray("Priority");
		if (!settingPriority && !config.FindEntry("DefaultsGenerated")) {
			// localized name | override agent | override range
			settingPriority = new Array(
				
				LDBFormat.LDBGetText(51000, 32030) + "|Default|100", // The Unutterable Lurker
				"",
				LDBFormat.LDBGetText(51000, 28731) + "|Filth|45", // Xibalban Bloodhound,
				LDBFormat.LDBGetText(51000, 30582) + "|Animal|onKill", // Dark House Sorcerer,
				LDBFormat.LDBGetText(51000, 30586) + "|Animal|100", // Ak'ab Hatchling
				LDBFormat.LDBGetText(51000, 30590) + "|Filth|onKill", // Mayan Battle Mage,
				LDBFormat.LDBGetText(51000, 28875) + "|Filth|40", // Chilam Psychopomp, override these to filth for Wayeb
				"",
				LDBFormat.LDBGetText(51000, 19280) + "|Construct|50", // Prime Maker
				"",
				LDBFormat.LDBGetText(51000, 30654) + "|Default|onKill",//Dimensional arcachnid
				//LDBFormat.LDBGetText(51000, 30667) + "|Default|onKill",//Research Assistant
				//LDBFormat.LDBGetText(51000, 18181) + "|Default|40", // The Colossus, Melothat
				LDBFormat.LDBGetText(51000, 18180) + "|Default|40" // Klein

				
				//Build switching test cases
				/*
				,
				"antimony|single|30",
				"antimony|demon|30",
				"antimony|aoe|onkill",
				"antimony|tes|onkill",
				"antimony|human|onkill",

				"Corroder|single|20",
				"Corroder|demon|20",
				"Corroder|aoe|onkill",
				"Corroder|tes|onkill",
				"Corroder|human|onkill",

				"tank|single|50",
				"tank|demon|50",
				"tank|aoe|onkill",
				"tank|tes|onkill",
				"tank|human|onkill",

				"trauma|single|50",
				"trauma|demon|50",
				"trauma|aoe|onkill",
				"trauma|tes|onkill",
				"trauma|human|onkill",

				"recursia|single|30",
				"recursia|demon|30",
				"recursia|aoe|onkill",
				"recursia|tes|onkill",
				"recursia|human|onkill",

				"tyrant|single|40",
				"tyrant|demon|40",
				"tyrant|aoe|onkill",
				"tyrant|tes|onkill",
				"tyrant|human|onkill"
				*/
				
			);
		}
	}

	/*
	private function EmitError(msg:String) {
		Debugger.ShowFifo("/option ShowVicinityNPCNametags must be set to true for proximiy targeting",0);
	}
	*/
	
	// Todo store settings in config and get values  through this
	// speeds up settings saving
	/*
	public function GetValue(key){
		
	}
	*/

	public function SaveConfig():Archive {
		var config:Archive = new Archive();
		config.AddEntry("Slot", settingSlot);
		config.AddEntry("DebugChat", settingDebugChat);
		config.AddEntry("DebugFifo", settingDebugFifo);
		config.AddEntry("Switch", settingDefault);
		config.AddEntry("Delay", settingDefaultDelay);
		config.AddEntry("DisableOnSwitch", settingDisableOnSwitch);
		config.AddEntry("DisableOnTank", settingDisableOnTank);
		config.AddEntry("Active", settingTargeting);
		config.AddEntry("blacklist", settingBlacklist);
		config.AddEntry("Pause", settingPause);
		config.AddEntry("Display", agentDisplayDval.GetValue());
		config.AddEntry("Range", settingRange);
		config.AddEntry("DefaultsGenerated", true);
		config.AddEntry("Default", settingDefaultAgent);
		config.AddEntry("iconPos", iconPos);
		config.AddEntry("DisplayPos", DisplayPos);
		config.AddEntry("UpdateRate", settingUpdateRate);
		config.AddEntry("PriorityEnable", settingProximityEnabled);
		config.AddEntry("DisplayName", settingDisplayName);
		config.AddEntry("QuickName", settingQuickselectName);
		config.AddEntry("Walter", settingWalter);
		config.AddEntry("Cleaner", settingCleaner);
		for (var i = 0; i < RecentAgents.length; i++ ) {
			config.AddEntry("RecentAgents", RecentAgents[i]);
		}

		for (var i = 0; i < settingPriority.length; i++ ) {
			config.AddEntry("Priority", settingPriority[i]);
		}
		return config
	}
}