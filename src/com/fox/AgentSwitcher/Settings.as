import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.GameInterface.DistributedValue;
import com.Utils.Archive;
import flash.geom.Point;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Settings {
	public var ModVersion:String = "3.0.0";
	
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
	public var settingDisableOnHealer:Boolean;
	public var settingDefaultAgent:Number;
	public var settingDefaultAgent2:Number;
	public var settingRange:String;
	public var settingSlot:Number;
	public var settingSlot2:Number;
	public var settingBlacklist:String;
	public var settingPriority:Array;
	public var settingProximityEnabled:Boolean;
	public var settingQuickselectName:Boolean;
	public var settingDisplayName:Boolean;
	public var settingUpdateRate:Number;
	public var settingRealSlot:Number;
	public var settingRealSlot2:Number;
	public var dValImport:DistributedValue;
	public var dValExport:DistributedValue;
	public var dValDev:DistributedValue;

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
		dValDev = DistributedValue.Create("AgentSwitcher_Dev");
		dValImport.SetValue(false);
		dValExport.SetValue(false);
	}

	public function GetDestinationSlot() {
		settingRealSlot = settingSlot - 1;
		settingRealSlot2 = settingSlot2 - 1;
	}

	public function LoadConfig(config: Archive):Void {
		settingSlot = config.FindEntry("Slot", 3);
		settingSlot2 = config.FindEntry("Slot2", 2);
		GetDestinationSlot();
		settingDebugChat = config.FindEntry("DebugChat", false);
		settingDebugFifo = config.FindEntry("DebugFifo", false);
		settingDefault = config.FindEntry("Switch", false);
		settingDefaultDelay = config.FindEntry("Delay", 2000);
		settingDisableOnSwitch = config.FindEntry("DisableOnSwitch", true);
		settingDisableOnTank = config.FindEntry("DisableOnTank", true);
		settingDisableOnHealer = config.FindEntry("DisableOnHealer", true);
		settingTargeting = config.FindEntry("Active", true);
		settingBlacklist = config.FindEntry("blacklist", "");
		
		settingPause = config.FindEntry("Pause", false);
		settingDefaultAgent = config.FindEntry("Default", 0);
		settingDefaultAgent2 = config.FindEntry("Default2", 0);
		iconPos = config.FindEntry("iconPos", new Point(200, 50));
		settingRange = config.FindEntry("Range", "40");
		settingUpdateRate = config.FindEntry("UpdateRate", 500);
		settingProximityEnabled = config.FindEntry("PriorityEnable", true);
		DisplayPos = config.FindEntry("DisplayPos", new Point(300,50));
		agentDisplayDval.SetValue(config.FindEntry("Display", false));
		settingDisplayName = config.FindEntry("DisplayName", false);
		settingQuickselectName = config.FindEntry("QuickName", false);
		dValDev.SetValue(config.FindEntry("DevMode", false));

		if (settingDefaultAgent == 0) {
			settingDefaultAgent = DruidSystem.GetAgentInSlot(settingRealSlot).m_AgentId | 0;
		}
		if (settingDefaultAgent2 == 0) {
			settingDefaultAgent2 = DruidSystem.GetAgentInSlot(settingRealSlot2).m_AgentId | 0;
		}
		
		RecentAgents = config.FindEntryArray("RecentAgents");
		if (!RecentAgents) {
			RecentAgents = new Array();
			if (settingDefaultAgent && !DruidSystem.IsDruid(settingDefaultAgent)) RecentAgents.push(settingDefaultAgent);
			if (settingDefaultAgent2 && !DruidSystem.IsDruid(settingDefaultAgent)) RecentAgents.push(settingDefaultAgent2);
		}
		settingPriority = config.FindEntryArray("Priority");
		if (!config.FindEntry("DefaultsGenerated3") || !settingPriority || settingPriority.length == 0){
			settingPriority = [
				"#~~~~ Polaris ~~~~",
				"5040;0,500,500,0|aquatic|onArea",
				"",
				"#~~~~ Hell Raised ~~~~",
				"5140;0,1000,1000,0|demon|onArea",
				"",
				"#~~~~ DW ~~~~",
				"5170;245,520,160,595|human|onArea",
				"5170;176,510,113,460|filth|onArea",
				"5170;131,519,70,608|human|onArea",
				"5170;60,613,135,694|animal|onArea",
				"5170;157,701,73,825|human|onArea",
				"5170;400,660,650,385|filth|onArea",
				"",
				"#~~~~ Ankh ~~~~",
				"5080;362,260,175,341,215,195|undead|onArea",
				"5080;380,315,55,500,180,165|filth|onArea",
				"5080;378,296,70,175,195,35|undead|onArea",
				"5080;170,255,55,65,210,1|filth|onArea",
				"5080;65,270,1,10,210,60|undead|onArea",
				"",
				"#~~~~ Hell Eternal ~~~~",
				"5160;0,1000,465,300|demon|onArea",
				"5160;490,385,560,300|construct|onArea",
				"5160;570,200,800,600|demon|onArea",
				"",
				"#~~~~ Penthouse ~~~~",
				"6892;228,280,266,240|human|onArea",
				"6892;267,350,300,220|filth|onArea",
				"",
				"#~~~~ NY ~~~~",
				"5710;0,1000,1000,0|filth|onArea",
				"5715;0,1000,1000,0|filth|onArea"
			];
		}
	}

	public function SaveConfig():Archive {
		var config:Archive = new Archive();
		config.AddEntry("Slot", settingSlot);
		config.AddEntry("Slot2", settingSlot2);
		config.AddEntry("DebugChat", settingDebugChat);
		config.AddEntry("DebugFifo", settingDebugFifo);
		config.AddEntry("Default", settingDefault);
		config.AddEntry("Switch", settingDefault);
		config.AddEntry("Delay", settingDefaultDelay);
		config.AddEntry("DisableOnSwitch", settingDisableOnSwitch);
		config.AddEntry("DisableOnTank", settingDisableOnTank);
		config.AddEntry("DisableOnHealer", settingDisableOnHealer);
		config.AddEntry("Active", settingTargeting);
		config.AddEntry("blacklist", settingBlacklist);
		config.AddEntry("Pause", settingPause);
		config.AddEntry("Display", agentDisplayDval.GetValue());
		config.AddEntry("Range", settingRange);
		config.AddEntry("DefaultsGenerated3", true);
		config.AddEntry("Default", settingDefaultAgent);
		config.AddEntry("Default2", settingDefaultAgent2);
		config.AddEntry("iconPos", iconPos);
		config.AddEntry("DisplayPos", DisplayPos);
		config.AddEntry("UpdateRate", settingUpdateRate);
		config.AddEntry("PriorityEnable", settingProximityEnabled);
		config.AddEntry("DisplayName", settingDisplayName);
		config.AddEntry("QuickName", settingQuickselectName);
		config.AddEntry("DevMode", dValDev.GetValue());
		for (var i = 0; i < RecentAgents.length; i++ ) {
			config.AddEntry("RecentAgents", RecentAgents[i]);
		}

		for (var i = 0; i < settingPriority.length; i++ ) {
			config.AddEntry("Priority", settingPriority[i]);
		}
		return config
	}
}