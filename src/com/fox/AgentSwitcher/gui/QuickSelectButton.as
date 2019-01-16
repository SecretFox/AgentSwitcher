import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.Character;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipManager;
import com.GameInterface.Tooltip.TooltipDataProvider;
import GUI.fox.aswing.ASColor;
import GUI.fox.aswing.ASFont;
import GUI.fox.aswing.JButton;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.QuickSelectButton extends JButton {
	public var AgentData:AgentSystemAgent;
	private var Tooltip:TooltipInterface;
	public function QuickSelectButton(text) {
		super(text);
		var font:ASFont = new ASFont("_StandardFont", 16, false, false, false, true);
		setBackground(new ASColor(0x353535, 100));
		setFont(font);
	}

	public function SetData(data:AgentSystemAgent) {
		AgentData = data;
	}
	private function ____onRollOver() {
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.m_Title = "<font size='14'><b>" + AgentData.m_Name+"</b></font>";
		m_TooltipData.m_Color = 0xFF8000;
		m_TooltipData.AddDescription(TooltipDataProvider.GetBuffTooltip( AgentData.m_BonusBuffID, Character.GetClientCharID()).m_Descriptions[0]);
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, -1, m_TooltipData);
	}
	private function ____onRollOut() {
		Tooltip.Close();
	}
	public function CloseTooltip() {
		Tooltip.Close();
	}
}