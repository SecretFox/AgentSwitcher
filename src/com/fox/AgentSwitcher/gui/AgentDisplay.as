import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.fox.AgentSwitcher.Controller;
import com.fox.Utils.Common;
import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.DistributedValue;
import com.Utils.Draw;
import flash.geom.Point;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.gui.AgentDisplay {
	private var m_swfRoot:MovieClip;
	private var m_Controller:Controller;
	public var m_Display:MovieClip;

	private var DisplayPos:Point;
	private var TargetSlot:Number;
	private var TargetSlot2:Number;

	//private var clipLoader:MovieClipLoader = new MovieClipLoader();

	public function AgentDisplay(root:MovieClip, cont:Controller) {
		m_swfRoot = root;
		m_Controller = cont;
	}
	
	public function DisplayAgents(dv:DistributedValue) {
		Destroy();
		if (dv.GetValue()) {
			DrawDisplay();
			if (m_Controller.settingDval.GetValue()) {
				Hide();
			}
		}
	}
	
	public function Hide() {
		m_Display._visible = false;
	}
	
	public function Show() {
		m_Display._visible = true;
	}
	
	public function Destroy() {
		AgentSystem.SignalPassiveChanged.Disconnect(ChangeText, this);
		m_Display.removeMovieClip();
	}
	
	public function SlotChanged() {
		TargetSlot = m_Controller.settingRealSlot;
		TargetSlot2 = m_Controller.settingRealSlot2;
		ChangeText(TargetSlot);
		ChangeText(TargetSlot2);
		if (m_Controller.settingDval.GetValue()) Hide();
	}
	
	private function DrawDisplay() {
		m_Display = m_swfRoot.createEmptyMovieClip("AgentDisplay", m_swfRoot.getNextHighestDepth());
		var m_BG = m_Display.createEmptyMovieClip("m_BG", m_Display.getNextHighestDepth());
		m_Display._x = m_Controller.DisplayPos.x;
		m_Display._y = m_Controller.DisplayPos.y;
		var format:TextFormat = new TextFormat("_StandardFont", 14, 0xFFFFFF);
		var Text:TextField = m_Display.createTextField("TargetAgent", m_Display.getNextHighestDepth(), 0, 0, 100, 20);
		Text.autoSize = true;
		Text.setTextFormat(format);
		Text.multiline = true;
		Text.setNewTextFormat(format);
		Text.embedFonts = true;
		AgentSystem.SignalPassiveChanged.Connect(ChangeText, this);
		SlotChanged();
	}
	
	private function ChangeText(slotID:Number) {
		if (slotID == TargetSlot || slotID == TargetSlot2) {
			var SlotAgent:AgentSystemAgent = DruidSystem.GetAgentInSlot(TargetSlot);
			var SlotAgent2:AgentSystemAgent = DruidSystem.GetAgentInSlot(TargetSlot2);
			m_Display.TargetAgent.text = "";
			m_Display.m_BG.clear();
			if (SlotAgent) {
				var name = SlotAgent.m_Name;
				if (!m_Controller.settingDisplayName) {
					var n = DruidSystem.GetName(SlotAgent.m_AgentId);
					if (n) name = n;
				}
				m_Display.TargetAgent.text = name;
			}
			if (SlotAgent2 && DruidSystem.IsDruid(SlotAgent2.m_AgentId)) {
				var name = SlotAgent2.m_Name;
				if (!m_Controller.settingDisplayName) {
					var n = DruidSystem.GetName(SlotAgent2.m_AgentId);
					if (n) name = n;
				}
				if (m_Display.TargetAgent.text) m_Display.TargetAgent.text += "\n"+ name;
				else m_Display.TargetAgent.text = name;
			}
			Draw.DrawRectangle(m_Display.m_BG, 0, 0, m_Display.TargetAgent._width + 10,  m_Display.TargetAgent._height + 10, 0x000000, 0, [8, 8, 8, 8]);
			if(SlotAgent || (SlotAgent2 && DruidSystem.IsDruid(SlotAgent2.m_AgentId))) Show();
			else {
				Hide();
			}
		}
	}
	
	private function OpenQuickSelect() {
		m_Controller.m_QuickSelect.QuickSelectStateChanged(false, true);
	}
	
	public function GuiEdit(state) {
		if (state) {
			m_Display.onPress = Delegate.create(this, StartDrag);
			m_Display.onRelease = Delegate.create(this, StopDrag);
			m_Display.onReleaseOutside = Delegate.create(this, StopDrag);
		} else {
			m_Display.onPress = Delegate.create(this, OpenQuickSelect);
			m_Display.onRelease = undefined;
			m_Display.onReleaseOutside = undefined;
		}
	}
	
	private function StartDrag() {
		m_Display.startDrag();
	}
	
	private function StopDrag() {
		m_Display.stopDrag();
		m_Controller.DisplayPos = Common.getOnScreen(m_Display);
		m_Display._x = m_Controller.DisplayPos.x;
		m_Display._y = m_Controller.DisplayPos.y;
	}
}