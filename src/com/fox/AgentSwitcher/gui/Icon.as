import com.fox.AgentSwitcher.Controller;
import com.fox.Utils.Common;
import com.Utils.Colors;
import flash.geom.Point;
import mx.utils.Delegate;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipManager;
import com.GameInterface.Tooltip.TooltipInterface;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.Icon{
	private var m_swfRoot:MovieClip;
	private var m_Controller:Controller;
	public var m_Icon:MovieClip;
	private var Tooltip:TooltipInterface;
	
	public function Icon(root:MovieClip, cont:Controller){
		m_swfRoot = root;
		m_Controller = cont;
	}
	public function CreateTopIcon(pos:Point, enabled:Boolean) {
		if (!m_Icon) {
			m_Icon = m_swfRoot.createEmptyMovieClip("m_TopIcon", m_swfRoot.getNextHighestDepth());
			m_Icon._x = pos.x;
			m_Icon._y = pos.y;
			var m_Img = m_Icon.attachMovie("src.assets.topbarIcon.png", "m_Img", m_Icon.getNextHighestDepth(), {_x:2, _y:2, _width:17, _height:17});
			StateChanged(enabled);
			GuiEdit(false);
		}
	}
	private function Clicked(){
		m_Controller.m_QuickSelect.QuickSelectStateChanged();
	}
	private function ClickedAux(){
		m_Controller.settingDval.SetValue(!m_Controller.settingDval.GetValue());
	}
	public function StateChanged(state:Boolean) {
		if (state) Colors.ApplyColor(m_Icon.m_Img, 0x00C400);
		else Colors.ApplyColor(m_Icon.m_Img, 0xFFFFFF);
	}
	private function onRollOut(){
		Tooltip.Close();
	}
	private function OnRollOver(){
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.m_Title = "<font size='14'><b>AgentSwitcher</b></font>";
		m_TooltipData.m_SubTitle = "<font size='9'>v2.1.0 by Starfox</font>";
		m_TooltipData.m_Color = 0xFF8000;
		m_TooltipData.m_MaxWidth = 220;
		m_TooltipData.AddDescription("<font size='11'>Left-Click for QuickSelect menu\nRight-Click for settings\nMoveable while in GUIEdit</font>");
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	public function GuiEdit(state) {
		if (!state) {
			m_Icon.stopDrag()
			m_Controller.iconPos = Common.getOnScreen(m_Icon);
			m_Icon._x = m_Controller.iconPos.x;
			m_Icon._y = m_Controller.iconPos.y;
			m_Icon.onPress = Delegate.create(this, Clicked);
			m_Icon.onPressAux = Delegate.create(this, ClickedAux);
			m_Icon.onRelease = undefined;
			m_Icon.onReleaseOutside = undefined;
			m_Icon.onRollOver = OnRollOver;
			m_Icon.onRollOut = onRollOut;
		} else {
			m_Icon.onPress = Delegate.create(this, function() {
				this.m_Icon.startDrag();
			});
			m_Icon.onPressAux = undefined;
			m_Icon.onRelease = Delegate.create(this, function() {
				this.m_Icon.stopDrag();
			});
			m_Icon.onReleaseOutside = Delegate.create(this, function() {
				this.m_Icon.stopDrag();
			});
			m_Icon.onRollOver = undefined;
			m_Icon.onRollOut = undefined;
		}
	}
}