import GUI.fox.aswing.ASFont;
import GUI.fox.aswing.JButton;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.Game.Character;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipManager;
import com.GameInterface.Tooltip.TooltipDataProvider;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.QuickSelectButton extends JButton{
	public var AgentData:AgentSystemAgent;
	private var Tooltip:TooltipInterface;
	public function QuickSelectButton(text){
		super(text);
		var font:ASFont = new ASFont(ASFont.DEFAULT_NAME, 16, false, false, false, true);
		setFont(font);
	}
	
	public function SetData(data:AgentSystemAgent){
		AgentData = data;
	}
	private function ____onRollOver(){
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.AddDescription(TooltipDataProvider.GetBuffTooltip( AgentData.m_BonusBuffID, Character.GetClientCharID()).m_Descriptions[0]);
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, -1, m_TooltipData);
	}
	public function CloseTooltip(){
		Tooltip.Close();
	}
	private function ____onRollOut(){
		Tooltip.Close();
	}
}