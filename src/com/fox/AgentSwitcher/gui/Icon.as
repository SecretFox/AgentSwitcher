import com.fox.AgentSwitcher.Controller;
import com.fox.Utils.Common;
import flash.geom.Point;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipManager;
import com.Utils.Colors;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.Icon {
	private var m_swfRoot:MovieClip;
	private var m_Controller:Controller;
	public var m_IconClip:MovieClip;
	public var Tooltip:TooltipInterface;
	private var lockCheck:Number;

	public function Icon(root:MovieClip, cont:Controller) {
		m_swfRoot = root;
		m_Controller = cont;
	}

	public function CreateTopIcon(pos:Point) {
		if (!m_IconClip) {
			m_IconClip = m_swfRoot.createEmptyMovieClip("m_TopIcon", m_swfRoot.getNextHighestDepth());
			m_IconClip._x = pos.x;
			m_IconClip._y = pos.y;
			var m_Img = m_IconClip.attachMovie("src.assets.topbarIcon.png", "m_icon", m_IconClip.getNextHighestDepth(), {_x:2, _y:2, _width:17, _height:17});
			var m_lock = m_IconClip.attachMovie("src.assets.LockIcon_Locked.png", "m_lock", m_IconClip.getNextHighestDepth(), {_x:5, _y:2, _width:10, _height:17});
			m_lock._visible = false;
			StateChanged();
			GuiEdit(false);
		}
	}
	
	public function ApplyLock(){
		clearInterval(lockCheck);
		lockCheck = setInterval(Delegate.create(this, CheckLock), 1000);
		CheckLock();
	}
	
	private function CheckLock(){
		if (m_Controller.m_Proximity.inProximity()){
			if (!m_IconClip.m_lock._visible){
				m_IconClip.m_lock._visible = true;
				Colors.ApplyColor(m_IconClip.m_icon, 0xE80000);
			}
		}else{
			clearInterval(lockCheck);
			m_IconClip.m_lock._visible = false;
			StateChanged();
			m_Controller.m_Default.LockUpdated();
		}
	}
	
	private function Clicked() {
		if (Key.isDown(Key.SHIFT)){
			m_Controller.settingPause = !m_Controller.settingPause;
			m_Controller.ApplyPause();
			StateChanged(m_Controller.settingPause);
		} else{
			m_Controller.m_QuickSelect.QuickSelectStateChanged();
		}
	}
	
	private function ClickedAux() {
		m_Controller.settingDval.SetValue(!m_Controller.settingDval.GetValue());
	}
	
	public function StateChanged() {
		if (m_Controller.settingPause){
			Colors.ApplyColor(m_IconClip.m_icon, 0xC40000)
		}else{
			if ((m_Controller.settingTargeting || m_Controller.settingProximityEnabled) && !(m_Controller.settingDisableOnTank && m_Controller.m_Tanking) && !(m_Controller.settingDisableOnHealer && m_Controller.m_Healing)){
				Colors.ApplyColor(m_IconClip.m_icon, 0x00C400);
			}else{
				Colors.ApplyColor(m_IconClip.m_icon, 0xFFFFFF);
			}
		}
	}
	
	private function onRollOut() {
		Tooltip.Close();
	}
	
	private function OnRollOver() {
		Tooltip.Close();
		var m_TooltipData:TooltipData = new TooltipData();
		m_TooltipData.m_Title = "<font size='14'><b>AgentSwitcher</b></font>";
		if (m_Controller.settingPause){
			m_TooltipData.m_Title = "<font size='14'><b>AgentSwitcher PAUSED(Shift+Click)</b></font>";
		}else{
			m_TooltipData.m_Title = "<font size='14'><b>AgentSwitcher</b></font>";
		}
		m_TooltipData.m_SubTitle = "<font size='9'>" + m_Controller.ModVersion + " by Starfox</font>";
		m_TooltipData.m_Color = 0xFF8000;
		m_TooltipData.m_MaxWidth = 220;
		m_TooltipData.AddDescription("<font size='11'>Left-Click for QuickSelect menu\nRight-Click for settings\nMoveable while in GUIEdit</font>");
		Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0.4, m_TooltipData);
	}
	
	public function GuiEdit(state) {
		if (!state) {
			m_IconClip.stopDrag()
			m_Controller.iconPos = Common.getOnScreen(m_IconClip);
			m_IconClip._x = m_Controller.iconPos.x;
			m_IconClip._y = m_Controller.iconPos.y;
			m_IconClip.onPress = Delegate.create(this, Clicked);
			m_IconClip.onPressAux = Delegate.create(this, ClickedAux);
			m_IconClip.onRelease = undefined;
			m_IconClip.onReleaseOutside = undefined;
			m_IconClip.onRollOver = Delegate.create(this,OnRollOver);
			m_IconClip.onRollOut = Delegate.create(this,onRollOut);
		} else {
			m_IconClip.onPress = Delegate.create(this, function() {
				this.m_IconClip.startDrag();
			});
			m_IconClip.onPressAux = undefined;
			m_IconClip.onRelease = Delegate.create(this, function() {
				this.m_IconClip.stopDrag();
			});
			m_IconClip.onReleaseOutside = Delegate.create(this, function() {
				this.m_IconClip.stopDrag();
			});
			m_IconClip.onRollOver = undefined;
			m_IconClip.onRollOut = undefined;
		}
	}
}