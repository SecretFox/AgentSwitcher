import GUI.fox.aswing.border.LineBorder;
import com.fox.AgentSwitcher.Controller;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipManager;
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
import flash.geom.Point;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.SettingsWindow extends JFrame  {

	private var m_Controller:Controller;
	
	private var Active:JCheckBox;
	private var DebugChat:JCheckBox;
	private var DebugFifo:JCheckBox;
	private var slotText:JTextField;
	private var Slot:JTextField;
	
	private var Default:JCheckBox;
	private var delayText:JTextField;
	private var Delay:JTextField;
	
	private var Display:JCheckBox;
	private var DisplayName:JCheckBox;
	private var Disable:JCheckBox;
	
	private var QuickName:JCheckBox;
	
	private var ProximityToggle:JCheckBox;
	private var ProximityList:JTextArea;
	private var scrollPane:JScrollPane;
	private var rangeText:JTextField;
	private var Range:JTextField;
	private var rateText:JTextField;
	private var Rate:JTextField;
	private var Tooltip:TooltipInterface;

	public function SettingsWindow(iconPos:Point, cont:Controller) {
		// Setup
		super("Settings");
		m_Controller = cont;
		setResizable(false);
		setDragable(false);
		setLocation(iconPos.x, iconPos.y + 30);
		setMinimumWidth(275);
		var icon:Icon = new Icon();//Empty icon
		setIcon(icon);
		//setBorder();
		setBorder(new LineBorder(null,new ASColor(0xFFFFFF,100), 1, 8));
		var content:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,0,SoftBoxLayout.CENTER))
		var slotPanel:JPanel =  new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,0,SoftBoxLayout.CENTER))
		var delayPanel:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,0,SoftBoxLayout.CENTER))
		var ProximitySettingPanel:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,0,SoftBoxLayout.CENTER))
	//Main Controls
		slotText = new JTextField("Agent slot:");
		slotText.setBorder(null);
		slotText.setEnabled(false);
		slotText.setEditable(false);
		
		content.append(GetActive());
		content.append(GetDefault());
		content.append(GetProximityTogggle());
		content.append(new JSeparator());
	//Misc Settings
		//Agent Slot
		slotPanel.append(slotText);
		slotPanel.append(GetSlot());
		content.append(slotPanel);
		//Print target on chat
		content.append(GetDebugChat());
		//Print target on fifo
		content.append(GetDebugFifo());
		//Disable on switch
		content.append(GetDisable());
		//Delay field
		delayText = new JTextField("Default delay");
		delayText.setBorder(null);
		delayText.setEnabled(false);
		delayText.setEditable(false);
		delayPanel.append(delayText);
		delayPanel.append(GetDelay());
		content.append(delayPanel);
		//Agent display
		content.append(GetDisplay());
		content.append(GetDisplayName());
		content.append(GetQuickName());
		content.append(new JSeparator());


	//Proximity settings
		var tf3:JTextField = new JTextField("Proximity Switching(?)");
		tf3.addEventListener(Component.ON_ROLLOVER,OpenProximityTooltip,this);
		tf3.addEventListener(Component.ON_ROLLOUT,CloseProximityTooltip,this);
		tf3.setBorder(null);
		tf3.setEnabled(false);
		tf3.setEditable(false);
		content.append(tf3);
		
		scrollPane = new JScrollPane(GetProximityList(),JScrollPane.SCROLLBAR_ALWAYS);
		scrollPane.setBorder(new LineBorder());
		var scrollbar:JScrollBar = scrollPane.getVerticalScrollBar();
		scrollbar.addEventListener(ON_PRESS, __startDragThumb, this);
		scrollbar.addEventListener(ON_RELEASE, __stopDragThumb, this);
		scrollbar.addEventListener(ON_RELEASEOUTSIDE, __stopDragThumb, this);
		content.append(scrollPane);
		
		rangeText = new JTextField("Range");
		rangeText.setBorder(null);
		rangeText.setEnabled(false);
		rangeText.setEditable(false);
		ProximitySettingPanel.append(rangeText);
		ProximitySettingPanel.append(GetRange());

		rateText = new JTextField("Update rate");
		rateText.setBorder(null);
		rateText.setEnabled(false);
		rateText.setEditable(false);
		ProximitySettingPanel.append(rateText);
		ProximitySettingPanel.append(GetRate());
		content.append(ProximitySettingPanel);

	//Show window + Reposition based on icon location
		setContentPane(content);
		show();
		pack();
		bringToTopDepth();
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);//get pos before closing
		if (iconPos.y > Stage.height / 2) {
			setY(iconPos.y - 5 - getHeight());
		}
		if (iconPos.x > Stage.width / 2) {
			setX(iconPos.x - 30 - getWidth());
		}
	}
	private function OpenProximityTooltip() {
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.m_Title = "<font size='14'><b>Proximity Switching</b></font>";
		m_TooltipData.m_Color = 0xFFFFFF;
		m_TooltipData.m_MaxWidth = 400;
		m_TooltipData.AddDescription(
			"<font size='12'>When enabled agent will be automatically switched when any of the mobs on the list gets close to the player.\n" +
			"Format: &lt;Name&gt;|&lt;Agent&gt;|&lt;Distance/Trigger&gt;\n" +
			"Only &lt;Name&gt; is required\n\n" +
			" &lt;Agent&gt; overrides the mobtype, allowing you to equip agent meant for other species, this may be helpful when adds and boss are different type\n" +
			"Valid agent values: Construct, Cybernetic, Demon, Aquatic, Filth, Human, Spirit, Supernatural, Undead, Animal, Default\n\n" +
			"If &lt;Distance&gt; is not specified (e.g. Kermit|Animal) then value from Range field is used instead\n"+
			"Alternatively you can substitute Distance with a trigger.\n" +
			"Currently there's only one trigger, &quot;onKill&quot;. onKill triggers the switch when specified target is killed\n\n" +
			"Range sets the default range,in case Distance wasn't specified" +
			"Update Rate controls how often distance will be checked, too often may cause lag.</font>"
		);
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, -1, m_TooltipData);
	}
	private function CloseProximityTooltip() {
		Tooltip.Close();
	}
	private function __startDragThumb(){
		scrollPane.getVerticalScrollBar().getUI()["__startDragThumb"]();
	}
	private function __stopDragThumb(){
		scrollPane.getVerticalScrollBar().getUI()["__stopDragThumb"]();
	}
	public function tryToClose():Void {
		Tooltip.Close();
		m_Controller.settingDval.SetValue(false);
	}
	private function __ActiveChanged(box:JCheckBox) {
		m_Controller.settingEnabled = box.isSelected();
		m_Controller.m_Icon.StateChanged(box.isSelected());
		m_Controller.SettingChanged();
	}
	private function __DebugChatChanged(box:JCheckBox) {
		m_Controller.settingDebugChat = box.isSelected();
		m_Controller.SettingChanged();
	}
	private function __DebugFifoChanged(box:JCheckBox) {
		m_Controller.settingDebugFifo = box.isSelected();
		m_Controller.SettingChanged();
	}
	private function __DefaultChanged(box:JCheckBox) {
		m_Controller.settingDefault = box.isSelected();
		m_Controller.SettingChanged();
		Delay.setEnabled(m_Controller.settingDefault);
	}
	private function __DisplayChanged(box:JCheckBox) {
		m_Controller.agentDisplayDval.SetValue(box.isSelected());
		DisplayName.setEnabled(box.isSelected());
	}
	private function __DisplayNameChanged(box:JCheckBox) {
		m_Controller.settingDisplayName = box.isSelected()
		m_Controller.m_AgentDisplay.SlotChanged();
	}
	private function __DisableChanged(box:JCheckBox) {
		m_Controller.settingDisableOnSwitch = box.isSelected();
	}
	private function __QuickSelectChanged(box:JCheckBox){
		m_Controller.settingQuickselectName = box.isSelected();
	}
	private function  __ProximityToggled(box:JCheckBox) {
		m_Controller.settingProximityEnabled = box.isSelected();
		m_Controller.SettingChanged();
		Range.setEnabled(m_Controller.settingProximityEnabled);
		Rate.setEnabled(m_Controller.settingProximityEnabled);
	}
	private function GetActive() {
		if (Active == null) {
			Active = new JCheckBox("Switch on target change");
			Active.setSelected(m_Controller.settingEnabled);
			Active.addActionListener(__ActiveChanged, this);
		}
		return Active;
	}
	private function GetDebugChat() {
		if (DebugChat == null) {
			DebugChat = new JCheckBox("Print race to chat");
			DebugChat.setSelected(m_Controller.settingDebugChat);
			DebugChat.addActionListener(__DebugChatChanged, this);
		}
		return DebugChat;
	}
	private function GetDebugFifo() {
		if (DebugFifo == null) {
			DebugFifo = new JCheckBox("Print race as FIFO");
			DebugFifo.setSelected(m_Controller.settingDebugFifo);
			DebugFifo.addActionListener(__DebugFifoChanged, this);
		}
		return DebugFifo;
	}
	private function GetDefault() {
		if (Default == null) {
			Default = new JCheckBox("Default on combat end");
			Default.setSelected(m_Controller.settingDefault);
			Default.addActionListener(__DefaultChanged, this);
		}
		return Default;
	}
	private function GetDisplay() {
		if (Display == null) {
			Display = new JCheckBox("Agent display");
			Display.setSelected(m_Controller.agentDisplayDval.GetValue());
			Display.addActionListener(__DisplayChanged, this);
		}
		return Display;
	}
	private function GetDisplayName() {
		if (DisplayName == null) {
			DisplayName = new JCheckBox("Use agent name on display");
			DisplayName.setSelected(m_Controller.settingDisplayName);
			DisplayName.addActionListener(__DisplayNameChanged, this);
			DisplayName.setEnabled(m_Controller.agentDisplayDval.GetValue());
		}
		return DisplayName;
	}
	private function GetQuickName() {
		if (QuickName == null) {
			QuickName = new JCheckBox("Use agent name on quickselect");
			QuickName.setSelected(m_Controller.settingQuickselectName);
			QuickName.addActionListener(__QuickSelectChanged, this);
		}
		return QuickName;
	}
	
	private function GetDisable() {
		if (Disable == null) {
			Disable = new JCheckBox("Disable on quickselect");
			Disable.setSelected(m_Controller.settingDisableOnSwitch);
			Disable.addActionListener(__DisableChanged, this);
		}
		return Disable;
	}
	private function GetProximityTogggle() {
		if (ProximityToggle == null) {
			ProximityToggle = new JCheckBox("Enable proximity switching");
			ProximityToggle.setSelected(m_Controller.settingProximityEnabled);
			ProximityToggle.addActionListener(__ProximityToggled, this);
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
			input = "9";
			field.setText(input);
		} else if (!input) {
			return
		}
		m_Controller.settingSlot = Number(input);
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
		m_Controller.SettingChanged();
	}
	private function __RangeChanged(field:JTextField) {
		var input:String = field.getText();
		if (input) {
			var old = m_Controller.settingRange;
			m_Controller.settingRange = input;
			m_Controller.m_Proximity.RangeChanged(old);
		}
	}
	private function __RateChanged(field:JTextField) {
		var input:String = field.getText();
		if (input) {
			m_Controller.settingUpdateRate = Number(input);
			m_Controller.m_Proximity.UpdateRateChanged();
		}
	}
	private function GetDelay() {
		if (Delay == null) {
			Delay = new JTextField(string(m_Controller.settingDefaultDelay), 5);
			Delay.setEditable(true);
			Delay.setEnabled(m_Controller.settingDefault);
			Delay.setRestrict("0123456789");
			Delay.addEventListener(JTextField.ON_TEXT_CHANGED, __DelayChanged, this);
			Delay.setFocusable(false);
		}
		return Delay;
	}

	private function GetSlot() {
		if (Slot == null) {
			Slot = new JTextField(string(m_Controller.settingSlot), 5);
			Slot.setRestrict("0123456789");
			Slot.setEditable(true);
			Slot.addEventListener(JTextField.ON_TEXT_CHANGED, __SlotChanged, this);
			Slot.setFocusable(false);
		}
		return Slot;
	}
	private function GetProximityList() {
		if (ProximityList == null) {
			ProximityList = new JTextArea(m_Controller.settingPriority.join("\n"), 8, 1);
			ProximityList.setRestrict("^\\^");// This is stupid, setting to null didn't work, so this allows all characters except ^
			ProximityList.setOpaque(false);
			ProximityList.setEditable(true);
			ProximityList.addEventListener(JTextField.ON_TEXT_CHANGED, __ProximityListChanged, this);
			ProximityList.setFocusable(false);
			
		}
		return ProximityList;
	}
	private function GetRange() {
		if (Range == null) {
			Range = new JTextField(m_Controller.settingRange, 5);
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
			Rate.setEditable(true);
			Rate.addEventListener(JTextField.ON_TEXT_CHANGED, __RateChanged, this);
			Rate.setFocusable(false);
		}
		return Rate;
	}
}