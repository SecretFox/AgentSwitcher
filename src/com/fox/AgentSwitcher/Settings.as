import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.GridLayout;
import GUI.fox.aswing.Icon;
import GUI.fox.aswing.JCheckBox;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.JTextField;
import GUI.fox.aswing.SoftBoxLayout;
import GUI.fox.aswing.border.BevelBorder;
import com.fox.AgentSwitcher.Main;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Settings extends JFrame  {
	
	private var Debug:JCheckBox;
	private var Active:JCheckBox;
	private var Default:JCheckBox;
	private var Delay:JTextField;
	private var Slot:JTextField;
	private var m_parent:Main;
	
	public function Settings(x,y,parent) {
		super("Settings");
		m_parent = parent;
		setResizable(false);
		setDragable(false);
		setLocation(x, y + 21);
		var icon:Icon = new Icon();//Empty icon
		setIcon(icon);
		setBorder(new BevelBorder(undefined, BevelBorder.RAISED, new ASColor(0xD8D8D8), new ASColor(0x7C7C7C), new ASColor(0x000000), new ASColor(0x373737), 3));
		
		var content:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
		var settingsPanel:JPanel = new JPanel(new GridLayout(7, 1, 2, 2));
		settingsPanel.append(GetActive());
		settingsPanel.append(GetDebug());
		settingsPanel.append(GetDefault());
		
		var tf1:JTextField = new JTextField("Default Delay", 10);
		tf1.setBorder(null);
		tf1.setEnabled(false);
		tf1.setEditable(false);
		settingsPanel.append(tf1);
		settingsPanel.append(GetDelay());
		var tf2:JTextField = new JTextField("Slot", 10);
		tf2.setBorder(null);
		tf2.setEnabled(false);
		tf2.setEditable(false);
		settingsPanel.append(tf2);
		settingsPanel.append(GetSlot());
		content.append(settingsPanel);
		setContentPane(content);

		show();
		pack();
		bringToTopDepth();
	}
	private function __ActiveChanged(box:JCheckBox){
		m_parent.ActiveDval.SetValue(box.isSelected());
	}
	private function __DebugChanged(box:JCheckBox){
		m_parent.DebugDval.SetValue(box.isSelected());
	}
	private function __DefaultChanged(box:JCheckBox){
		m_parent.SwitchDval.SetValue(box.isSelected());
	}
	private function GetActive(){
		if (Active == null){
			Active = new JCheckBox("Enabled");
			Active.setSelected(m_parent.ActiveDval.GetValue());
			Active.addActionListener(__ActiveChanged, this);
		}
		return Active;
	}
	private function GetDebug(){
		if (Debug == null){
			Debug = new JCheckBox("Debug");
			Debug.setSelected(m_parent.DebugDval.GetValue());
			Debug.addActionListener(__DebugChanged, this);
		}
		return Debug;
	}
	private function GetDefault(){
		if (Default == null){
			Default = new JCheckBox("Default on combat end");
			Default.setSelected(m_parent.SwitchDval.GetValue());
			Default.addActionListener(__DefaultChanged, this);
		}
		return Default;
	}

	private function __DelayChanged(field:JTextField){
		var input:String = field.getText();
		if (input.length > 4){
			input = "9999";
			field.setText(input);
		}
		else if (!input){
			return
		}
		m_parent.DefaultDelayDval.SetValue(Number(input));
		
	}
	private function __SlotChanged(field:JTextField){
		var input:String = field.getText();
		if (input.length > 1){
			input = "9";
			field.setText(input);
		}
		else if (!input){
			return
		}
		m_parent.SlotDval.SetValue(Number(input));
		
	}

	private function GetDelay(){
		if (Delay == null){
			Delay = new JTextField(m_parent.DefaultDelayDval.GetValue(), 1);
			Delay.setEditable(true);
			Delay.setRestrict("0123456789");
			Delay.addEventListener(JTextField.ON_TEXT_CHANGED, __DelayChanged, this);
			Delay.setFocusable(false);
		}
		return Delay;
	}
	
	private function GetSlot(){
		if (Slot == null){
			Slot = new JTextField(m_parent.SlotDval.GetValue(), 1);
			Slot.setRestrict("0123456789");
			Slot.setEditable(true);
			Slot.addEventListener(JTextField.ON_TEXT_CHANGED, __SlotChanged, this);
			Slot.setFocusable(false);
		}
		return Slot;
	}
}