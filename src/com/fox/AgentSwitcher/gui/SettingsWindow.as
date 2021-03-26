import GUI.fox.aswing.ASFont;
import GUI.fox.aswing.ASWingConstants;
import GUI.fox.aswing.FlowLayout;
import com.fox.AgentSwitcher.Controller;
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JCheckBox;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.JScrollBar;
import GUI.fox.aswing.JScrollPane;
import GUI.fox.aswing.JSeparator;
import GUI.fox.aswing.JTextArea;
import GUI.fox.aswing.JTextField;
import GUI.fox.aswing.SoftBoxLayout;
import GUI.fox.aswing.border.LineBorder;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipManager;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.SettingsWindow extends JFrame  {
	static var ScrollPosition:Number;
	
	private var m_Controller:Controller;

	private var Active:JCheckBox;
	private var Blacklist:JTextArea;
	private var DebugChat:JCheckBox;
	private var DebugFifo:JCheckBox;
	private var slotText:JTextField;
	private var slot2Text:JTextField;
	private var blacklisText:JTextField;
	private var Slot:JTextField;
	private var Slot2:JTextField;

	private var Default:JCheckBox;
	private var delayText:JTextField;
	private var Delay:JTextField;

	private var Display:JCheckBox;
	private var DisplayName:JCheckBox;
	private var Disable:JCheckBox;
	private var DisableTank:JCheckBox;
	private var DisableHealer:JCheckBox;
	private var PauseProximity:JCheckBox;
	
	private var useCleaner:JCheckBox;
	private var useWalter:JCheckBox;

	private var QuickName:JCheckBox;

	private var ProximityToggle:JCheckBox;
	private var ProximityList:JTextArea;
	private var scrollPane:JScrollPane;
	private var scrollPane2:JScrollPane;
	private var Range:JTextField;
	private var Rate:JTextField;
	private var Role:JTextField;
	private var Tooltip:TooltipInterface;
	private var font:ASFont;

	public function SettingsWindow(cont:Controller) {
	// Setup
		super("AgentSwitcher " + cont.ModVersion);
		setFont(new ASFont("_StandardFont", 14, false));
		font = new ASFont("_StandardFont", 13);
		m_Controller = cont;
		setResizable(false);
		setDragable(false);
		setLocation(m_Controller.iconPos.x, m_Controller.iconPos.y + 30);
		setMinimumWidth(275);
		var icon:Icon = new Icon();//Empty icon
		setIcon(icon);
	//Panels
		setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 100), 1, 2));
		var content:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 5));
		var leftcontent:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
		var rightcontent:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
		var blacklistPanel:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		var slotPanel:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 1, 1));
		var slot2Panel:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 1, 1));
		var delayPanel:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 0));
		var ProximityHeader:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 15, 0));
		var proximityOptions:JPanel  = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5, 0));
		var proximityOptionHeader:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 5, 0));
		var proximityOptionInputs:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 5, 0));
		
	//Main Controls
		//Switch on target
		leftcontent.append(GetActive());
		//Print target on chat
		leftcontent.append(GetDebugChat());
		//Print target on fifo
		leftcontent.append(GetDebugFifo());

	//Pause Settings
		leftcontent.append(GetDisable());
		leftcontent.append(GetTank());
		leftcontent.append(GetHealer());
		leftcontent.append(new JSeparator());
	//Agent Slots
		slotText = new JTextField("Primary Agent slot:");
		slotText.setFont(font);
		slotText.setBorder(null);
		slotText.setEnabled(false);
		slotText.setEditable(false);
		slotPanel.append(slotText);
		slotPanel.append(GetSlot());
		leftcontent.append(slotPanel);
		
		slot2Text = new JTextField("Secondary Agent slot:");
		slot2Text.setFont(font);
		slot2Text.setBorder(null);
		slot2Text.setEnabled(false);
		slot2Text.setEditable(false);
		slot2Panel.append(slot2Text);
		slot2Panel.append(GetSlot2());
		leftcontent.append(slot2Panel);
		leftcontent.append(new JSeparator());
	// Display
		leftcontent.append(GetDisplay());
		leftcontent.append(GetDisplayName());
		leftcontent.append(GetQuickName());
		leftcontent.append(new JSeparator());
	//Defaulting
		leftcontent.append(GetDefault());
		delayText = new JTextField("Default delay");
		delayText.setFont(font);
		delayText.setBorder(null);
		delayText.setEnabled(false);
		delayText.setEditable(false);
		delayPanel.append(delayText);
		delayPanel.append(GetDelay());
		leftcontent.append(delayPanel);
		
		
	// Targeting blacklist
		blacklisText = new JTextField("Targeting Blacklist:(?)");
		blacklisText.setFont(font);
		blacklisText.addEventListener(Component.ON_ROLLOVER, OpenBlacklistTooltip, this);
		blacklisText.addEventListener(Component.ON_ROLLOUT, CloseToolTips, this);
		blacklisText.setBorder(null);
		blacklisText.setEnabled(false);
		blacklisText.setEditable(false);
		rightcontent.append(blacklisText);
		scrollPane2 = new JScrollPane(GetBlacklist(),JScrollPane.SCROLLBAR_ALWAYS);
		scrollPane2.setBorder(new LineBorder());
		scrollPane2.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_AS_NEEDED);
		var scrollbar2:JScrollBar = scrollPane2.getVerticalScrollBar();
		scrollbar2.addEventListener(ON_PRESS, __startDragThumb2, this);
		scrollbar2.addEventListener(ON_RELEASE, __stopDragThumb2, this);
		scrollbar2.addEventListener(ON_RELEASEOUTSIDE, __stopDragThumb2, this);
		rightcontent.append(scrollPane2);
		rightcontent.append(new JSeparator());
	//Proximity settings
		
		ProximityHeader.append(GetProximityTogggle());
		var rateText:JTextField = new JTextField("Update rate");
		rateText.setFont(font);
		rateText.setBorder(null);
		rateText.setEnabled(false);
		rateText.setEditable(false);
		var inputs:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 0));
		inputs.append(rateText);
		inputs.append(GetRate());
		ProximityHeader.append(inputs);
		rightcontent.append(ProximityHeader);
		
		scrollPane = new JScrollPane(GetProximityList(),JScrollPane.SCROLLBAR_ALWAYS);
		scrollPane.setBorder(new LineBorder());
		scrollPane.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_AS_NEEDED);
		//scrollPane.addAdjustmentListener(__onScroll, this);
		var scrollbar:JScrollBar = scrollPane.getVerticalScrollBar();
		scrollbar.addEventListener(ON_PRESS, __startDragThumb, this);
		scrollbar.addEventListener(ON_RELEASE, __stopDragThumb, this);
		scrollbar.addEventListener(ON_RELEASEOUTSIDE, __stopDragThumb, this);
		rightcontent.append(scrollPane);
		
		var defaults = new JTextField("Default values(?)");
		defaults.setFont(font);
		defaults.setBorder(null);
		defaults.addEventListener(Component.ON_ROLLOVER, OpenDefaultTooltip, this);
		defaults.addEventListener(Component.ON_ROLLOUT, CloseToolTips, this);
		defaults.setEnabled(false);
		defaults.setEditable(false);
		
		proximityOptionHeader.append(defaults);
		
		var rangeText = new JTextField("Distance");
		rangeText.setFont(font);
		rangeText.setBorder(null);
		rangeText.setEnabled(false);
		rangeText.setEditable(false);
		proximityOptionInputs.append(rangeText);
		proximityOptionInputs.append(GetRange());

		var roleText = new JTextField("Role");
		roleText.setFont(font);
		roleText.setBorder(null);
		roleText.setEnabled(false);
		roleText.setEditable(false);
		proximityOptionInputs.append(roleText);
		proximityOptionInputs.append(GetRole());

		proximityOptions.append(proximityOptionHeader);
		proximityOptions.append(proximityOptionInputs);
		rightcontent.append(proximityOptions);
		
	//Show window + Reposition based on icon location
		content.append(new JSeparator(JSeparator.VERTICAL));
		content.append(leftcontent);
		content.append(new JSeparator(JSeparator.VERTICAL));
		content.append(rightcontent);
		content.append(new JSeparator(JSeparator.VERTICAL));
		setContentPane(content);
		show();
		pack();
		bringToTopDepth();
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
		if (m_Controller.iconPos.y > Stage.height / 2) {
			setY(m_Controller.iconPos.y - 5 - getHeight());
		}
		if (m_Controller.iconPos.x > Stage.width / 2) {
			setX(m_Controller.iconPos.x - 30 - getWidth());
		}
		if (ScrollPosition) scrollbar.setValue(ScrollPosition);
	}
	private function __onScroll(){}
	//scrollbar is broken
	private function __startDragThumb() {
		scrollPane.getVerticalScrollBar().getUI()["__startDragThumb"]();
	}
	private function __stopDragThumb() {
		scrollPane.getVerticalScrollBar().getUI()["__stopDragThumb"]();
	}
	private function __startDragThumb2() {
		scrollPane2.getVerticalScrollBar().getUI()["__startDragThumb"]();
	}
	private function __stopDragThumb2() {
		scrollPane2.getVerticalScrollBar().getUI()["__stopDragThumb"]();
	}
	public function tryToClose():Void {
		Tooltip.Close();
		// Reload proximity list if changed
		ScrollPosition = scrollPane.getVerticalScrollBar().getValue();
		if (m_Controller.settingPriority.toString() != ProximityList.getText().split("\n").toString()) {
			m_Controller.ReloadProximityList();
		}
		var blacklistContent = Blacklist.getText().split("\r").join(",");
		if (m_Controller.settingBlacklist != blacklistContent){
			m_Controller.settingBlacklist = blacklistContent;
			m_Controller.m_Targeting.SetBlacklist(blacklistContent);
		}
		m_Controller.settingDval.SetValue(false);
	}
	private function __ActiveChanged(box:JCheckBox) {
		m_Controller.settingTargeting = box.isSelected();
		m_Controller.ApplySettings();
		Blacklist.setEnabled(box.isSelected());
	}
	private function __DebugChatChanged(box:JCheckBox) {
		m_Controller.settingDebugChat = box.isSelected();
		m_Controller.ApplySettings();
	}
	private function __DebugFifoChanged(box:JCheckBox) {
		m_Controller.settingDebugFifo = box.isSelected();
		m_Controller.ApplySettings();
	}
	private function __DefaultChanged(box:JCheckBox) {
		m_Controller.settingDefault = box.isSelected();
		m_Controller.ApplySettings();
		Delay.setEnabled(m_Controller.settingDefault);
	}
	private function __DisplayChanged(box:JCheckBox) {
		m_Controller.agentDisplayDval.SetValue(box.isSelected());
		DisplayName.setEnabled(box.isSelected());
	}
	private function __DisplayNameChanged(box:JCheckBox) {
		m_Controller.settingDisplayName = box.isSelected();
		m_Controller.m_AgentDisplay.SlotChanged();
	}
	private function __DisableChanged(box:JCheckBox) {
		m_Controller.settingDisableOnSwitch = box.isSelected();
	}
	private function __TankChanged(box:JCheckBox) {
		m_Controller.settingDisableOnTank = box.isSelected();
		PauseProximity.setEnabled(m_Controller.settingDisableOnHealer || m_Controller.settingDisableOnTank);
		m_Controller.ApplySettings(true);
	}
	private function __HealerChanged(box:JCheckBox) {
		m_Controller.settingDisableOnHealer = box.isSelected();
		PauseProximity.setEnabled(m_Controller.settingDisableOnHealer || m_Controller.settingDisableOnTank);
		m_Controller.ApplySettings(true);
	}
	private function __QuickSelectChanged(box:JCheckBox) {
		m_Controller.settingQuickselectName = box.isSelected();
	}
	public function redrawProximityList(){
		ProximityList.setText(m_Controller.settingPriority.join("\n"));
	}
	private function __ProximityToggled(box:JCheckBox) {
		m_Controller.settingProximityEnabled = box.isSelected();
		m_Controller.ApplySettings();
		ProximityList.setEnabled(ProximityToggle.isSelected());
		Range.setEnabled(ProximityToggle.isSelected());
		Rate.setEnabled(ProximityToggle.isSelected());
		Role.setEnabled(ProximityToggle.isSelected());
	}
	
	private function __BlacklistChanged(){
		//empty on purpose
	}
	private function GetActive() {
		if (Active == null) {
			Active = new JCheckBox("Switch on target change");
			Active.setFont(font);
			Active.setSelected(m_Controller.settingTargeting);
			Active.addActionListener(__ActiveChanged, this);
		}
		return Active;
	}
	private function GetDebugChat() {
		if (DebugChat == null) {
			DebugChat = new JCheckBox("Print race to chat");
			DebugChat.setFont(font);
			DebugChat.setSelected(m_Controller.settingDebugChat);
			DebugChat.addActionListener(__DebugChatChanged, this);
		}
		return DebugChat;
	}
	private function GetDebugFifo() {
		if (DebugFifo == null) {
			DebugFifo = new JCheckBox("Print race as FIFO");
			DebugFifo.setFont(font);
			DebugFifo.setSelected(m_Controller.settingDebugFifo);
			DebugFifo.addActionListener(__DebugFifoChanged, this);
		}
		return DebugFifo;
	}
	private function GetDefault() {
		if (Default == null) {
			Default = new JCheckBox("Default on combat end");
			Default.setHorizontalAlignment(ASWingConstants.RIGHT);
			Default.setFont(font);
			Default.setSelected(m_Controller.settingDefault);
			Default.addActionListener(__DefaultChanged, this);
		}
		return Default;
	}
	private function GetDisplay() {
		if (Display == null) {
			Display = new JCheckBox("Display active agent");
			Display.setFont(font);
			Display.setSelected(m_Controller.agentDisplayDval.GetValue());
			Display.addActionListener(__DisplayChanged, this);
		}
		return Display;
	}
	private function GetDisplayName() {
		if (DisplayName == null) {
			DisplayName = new JCheckBox("Use agent name on display");
			DisplayName.setFont(font);
			DisplayName.setSelected(m_Controller.settingDisplayName);
			DisplayName.addActionListener(__DisplayNameChanged, this);
			DisplayName.setEnabled(m_Controller.agentDisplayDval.GetValue());
		}
		return DisplayName;
	}
	private function GetQuickName() {
		if (QuickName == null) {
			QuickName = new JCheckBox("Use agent name on quickselect");
			QuickName.setFont(font);
			QuickName.setSelected(m_Controller.settingQuickselectName);
			QuickName.addActionListener(__QuickSelectChanged, this);
		}
		return QuickName;
	}
	private function GetDisable() {
		if (Disable == null) {
			Disable = new JCheckBox("Disable on quickselect");
			Disable.setFont(font);
			Disable.setSelected(m_Controller.settingDisableOnSwitch);
			Disable.addActionListener(__DisableChanged, this);
		}
		return Disable;
	}
	private function GetTank() {
		if (DisableTank == null) {
			DisableTank = new JCheckBox("Pause while tanking(?)");
			DisableTank.setFont(font);
			DisableTank.addEventListener(Component.ON_ROLLOVER, OpenTankingTooltip, this);
			DisableTank.addEventListener(Component.ON_ROLLOUT, CloseToolTips, this);
			DisableTank.setSelected(m_Controller.settingDisableOnTank);
			DisableTank.addActionListener(__TankChanged, this);
		}
		return DisableTank;
	}
	private function GetHealer() {
		if (DisableHealer == null) {
			DisableHealer = new JCheckBox("Pause while healing(?)");
			DisableHealer.setFont(font);
			DisableHealer.addEventListener(Component.ON_ROLLOVER, OpenHealingTooltip, this);
			DisableHealer.addEventListener(Component.ON_ROLLOUT, CloseToolTips, this);
			DisableHealer.setSelected(m_Controller.settingDisableOnHealer);
			DisableHealer.addActionListener(__HealerChanged, this);
		}
		return DisableHealer;
	}
	private function OpenBlacklistTooltip(){
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.AddDescription("Targeting based switching will ignore these mobs, one mob per line");
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	private function OpenDefaultTooltip(){
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.AddDescription("These values will be used if one of the parameters is left unspecified in the above list");
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	private function OpenHealingTooltip(){
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.AddDescription("Pauses targeting based switching while healing");
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	private function OpenTankingTooltip(){
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.AddDescription("Pauses targeting based switching while tanking");
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	
	private function OpenProximityTooltip() {
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.m_Title = "<font size='14'><b>Proximity Switching</b></font>";
		m_TooltipData.m_Color = 0xFFFFFF;
		m_TooltipData.m_MaxWidth = 600;
		m_TooltipData.AddDescription(
			"<font size='12'>When Proximity switching is enabled agent will be automatically switched based on player coodinates and zone\n" + 
			"Switching can also be based on nearby enemies, killed enemies, or entering a zone\n" +
			"Some examples:\n" +
			"&lt;Name&gt;\n" +
			"&lt;Name&gt;|&lt;Agent&gt;\n" +
			"&lt;Name&gt;|&lt;Agent&gt;|&lt;Distance&gt;\n" +
			"&lt;Name/Zone/Zone+Coordinate&gt;|&lt;Agent/Build/Outfit&gt;|&lt;Distance/Trigger&gt;|&lt;Role&gt;\n\n" +
			" &lt;Name/Zone/Coordinate&gt; : Monsters name, zoneID, zoneID+coordinate,or zoneID+area\n\n" +
			" &lt;Agent/Oufit/Build&gt; Either agent(if using MobName can be omitted), buildname, or outfit name. Builds support BooBuilds and Gearmanager. Outfits only works with BooBuilds\n" +
			"Valid agent overrides are : Construct, Cybernetic, Demon, Aquatic, Filth, Human, Spirit, Supernatural, Undead, Animal, Default\n\n" +
			"&lt;Distance/Trigger&gt; either range or trigger, if not specified default range from settings will be used.\n"+
			"Valid triggers are &quot;onKill&quot;,&quot;onArea&quot;, and &quot;onZone&quot;. onKill triggers the switch when specified target is killed,onArea when player is near coordinate or inside an area, and onZone triggers when entering new zone\n" +
			"&lt;onArea&gt; triggers supports any of the following formats; &quot;ZoneID;x,y&quot; &quot;ZoneID;x,y,z&quot; &quot;ZoneID;x1,y1,x2,x2&quot; &quot;ZoneID;x1,y1,z1,x2,y2,z2&quot;\n\n" +
			"&lt;Role&gt; : Valid values are &quot;All&quot;, &quot;Tank&quot;, &quot;DPS&quot;, and &quot;Healer&quot;. If specified then the action will only be performed when the players role matches the value. If not specified defaults to All. Build will not be switched while player has ongoing cooldown\n"+
			"----\n" +
			"Distance field under the list sets the default range,in case Distance wasn't specified in the list entry\n" +
			"Update Rate controls how often distance will be checked, too often may cause lag.</font>"
		);
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	
	private function CloseToolTips() {
		Tooltip.Close();
	}
	
	private function GetProximityTogggle() {
		//var stupidAllignment:JPanel
		if (ProximityToggle == null) {
			//stupidAllignment = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
			ProximityToggle = new JCheckBox("Enable proximity switching(?)");
			ProximityToggle.setFont(font);
			ProximityToggle.setHorizontalAlignment(ASWingConstants.LEFT);
			ProximityToggle.addEventListener(Component.ON_ROLLOVER, OpenProximityTooltip, this);
			ProximityToggle.addEventListener(Component.ON_ROLLOUT, CloseToolTips, this);
			ProximityList.setEnabled(ProximityToggle.isSelected());
			ProximityToggle.setSelected(m_Controller.settingProximityEnabled);
			ProximityToggle.addActionListener(__ProximityToggled, this);
			//stupidAllignment.append(ProximityToggle);
		}
		return ProximityToggle;
	}
	private function __DelayChanged(field:JTextField) {
		var input:String = field.getText();
		if (input.length > 4) {
			input = "9999";
			field.setText(input);
		} else if (!input) {
			return
		}
		m_Controller.settingDefaultDelay = Number(input);
	}
	private function __SlotChanged(field:JTextField) {
		var input:String = field.getText();
		if (input.length > 1) {
			input = "3";
			field.setText(input);
		}
		else if (!input) {
			input = "0"
		}
		m_Controller.settingSlot = Number(input);
		m_Controller.GetDestinationSlot();
		m_Controller.m_AgentDisplay.SlotChanged();
	}
	private function __Slot2Changed(field:JTextField) {
		var input:String = field.getText();
		if (input.length > 1) {
			input = "2";
			field.setText(input);
		} else if (!input) {
			input = "0"
		}
		m_Controller.settingSlot2 = Number(input);
		m_Controller.GetDestinationSlot();
		m_Controller.m_AgentDisplay.SlotChanged();
	}
	private function __ProximityListChanged(field:JTextArea) {
		var input:String = field.getText();
		var priorities:Array = new Array();
		if (input) {
			priorities = input.split("\r");
		}
		m_Controller.settingPriority = priorities;
	}
	private function __RangeChanged(field:JTextField) {
		var input:String = field.getText();
		if (input) {
			var old = m_Controller.settingRange;
			m_Controller.settingRange = input;
			m_Controller.m_Proximity.ReloadProximityList();
		}
	}
	private function __RateChanged(field:JTextField) {
		var input:String = field.getText();
		if (input) {
			m_Controller.settingUpdateRate = Number(input);
			m_Controller.m_Proximity.ReloadProximityList();
		}
	}
	private function __RoleChanged(field:JTextField) {
		var input:String = field.getText();
		if (input) {
			var old = m_Controller.settingRole;
			m_Controller.settingRole = input;
			m_Controller.m_Proximity.ReloadProximityList();
		}
	}
	private function GetDelay() {
		if (Delay == null) {
			Delay = new JTextField(string(m_Controller.settingDefaultDelay), 5);
			Delay.setEditable(true);
			Delay.setEnabled(m_Controller.settingDefault);
			Delay.setRestrict("0-9");
			Delay.addEventListener(JTextField.ON_TEXT_CHANGED, __DelayChanged, this);
			Delay.setFocusable(false);
		}
		return Delay;
	}

	private function GetSlot() {
		if (Slot == null) {
			Slot = new JTextField(string(m_Controller.settingSlot), 5);
			Slot.setRestrict("0-9");
			Slot.setEditable(true);
			Slot.addEventListener(JTextField.ON_TEXT_CHANGED, __SlotChanged, this);
			Slot.setFocusable(false);
		}
		return Slot;
	}
	private function GetSlot2() {
		if (Slot2 == null) {
			Slot2 = new JTextField(string(m_Controller.settingSlot2), 5);
			Slot2.setRestrict("0-9");
			Slot2.setEditable(true);
			Slot2.addEventListener(JTextField.ON_TEXT_CHANGED, __Slot2Changed, this);
			Slot2.setFocusable(false);
		}
		return Slot2;
	}
	private function GetBlacklist() {
		if (Blacklist == null){
			Blacklist = new JTextArea(string(m_Controller.settingBlacklist.split(",").join("\r")), 4, 1);
			Blacklist.setFont(font);
			Blacklist.setRestrict("^,");
			Blacklist.setOpaque(false);
			Blacklist.setHtml(false);
			Blacklist.setEditable(true);
			Blacklist.addEventListener(JTextField.ON_TEXT_CHANGED, __BlacklistChanged, this);
			Blacklist.setFocusable(false);
			Blacklist.setEnabled(Active.isSelected());
		}
		return Blacklist
	}
	private function GetProximityList() {
		if (ProximityList == null) {
			ProximityList = new JTextArea(m_Controller.settingPriority.join("\n"), 11, 1);
			ProximityList.setFont(font);
			ProximityList.setPreferredWidth(375);
			ProximityList.setRestrict("^\\^");// This is stupid, setting to null didn't work, so this allows all characters except ^
			ProximityList.setOpaque(false);
			ProximityList.setHtml(false);
			ProximityList.setEditable(true);
			ProximityList.addEventListener(JTextField.ON_TEXT_CHANGED, __ProximityListChanged, this);
			ProximityList.setFocusable(false);
		}
		return ProximityList;
	}
	private function GetRange() {
		if (Range == null) {
			Range = new JTextField(m_Controller.settingRange, 5);
			Range.setFont(font);
			Range.setRestrict("^\\^");// This is stupid, setting to null didn't work, so this allows all characters except ^
			Range.setEditable(true);
			Range.addEventListener(JTextField.ON_TEXT_CHANGED, __RangeChanged, this);
			Range.setFocusable(false);
		}
		return Range;
	}
	private function GetRate() {
		if (Rate == null) {
			Rate = new JTextField(string(m_Controller.settingUpdateRate), 5);
			Rate.setRestrict("0-9");
			Rate.setFont(font);
			Rate.setEditable(true);
			Rate.addEventListener(JTextField.ON_TEXT_CHANGED, __RateChanged, this);
			Rate.setFocusable(false);
		}
		return Rate;
	}
	private function GetRole() {
		if (Role == null) {
			Role = new JTextField(m_Controller.settingRole, 5);
			Role.setFont(font);
			Role.setRestrict("^\\^");// This is stupid, setting to null didn't work, so this allows all characters except ^
			Role.setEditable(true);
			Role.addEventListener(JTextField.ON_TEXT_CHANGED, __RoleChanged, this);
			Role.setFocusable(false);
		}
		return Role;
	}
}