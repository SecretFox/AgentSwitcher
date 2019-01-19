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
	private var m_Display:MovieClip;

	private var DisplayPos:Point;
	private var TargetSlot:Number;

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
		ChangeText(TargetSlot);
		if (m_Controller.settingDval.GetValue()) Hide();
	}
	/*
	function onLoadComplete(clip:MovieClip){
		clip._height = 50;
		clip._width = 50;
	}
	*/
	private function DrawDisplay() {
		m_Display = m_swfRoot.createEmptyMovieClip("AgentDisplay", m_swfRoot.getNextHighestDepth());
		//if(m_Controller.superSecretKittenSetting){
		// var img = m_Display.createEmptyMovieClip("Mittens", m_Display.getNextHighestDepth());
		// clipLoader.addListener(this);
		// clipLoader.loadClip("AgentMittens\\MittenRoster\\x.png",img );
		var m_BG = m_Display.createEmptyMovieClip("m_BG", m_Display.getNextHighestDepth());
		m_Display._x = m_Controller.DisplayPos.x;
		m_Display._y = m_Controller.DisplayPos.y;
		var format:TextFormat = new TextFormat("_StandardFont", 14, 0xFFFFFF);
		var Text:TextField = m_Display.createTextField("TargetAgent", m_Display.getNextHighestDepth(), 6, 6, 100, 20);
		Text.autoSize = true;
		Text.setTextFormat(format);
		Text.setNewTextFormat(format);
		Text.embedFonts = true;
		AgentSystem.SignalPassiveChanged.Connect(ChangeText, this);
		SlotChanged();
	}
	private function ChangeText(slotID:Number) {
		if (slotID == TargetSlot) {
			var SlotAgent:AgentSystemAgent = DruidSystem.GetAgentInSlot(slotID);
			if (SlotAgent) {
				var name;
				for (var i in DruidSystem.Druids) {
					if (!m_Controller.settingDisplayName) {
						if (DruidSystem.Druids[i][0] == SlotAgent.m_AgentId) {
							name = DruidSystem.Druids[i][1];
							break
						}
					}
					name = SlotAgent.m_Name
				}
				m_Display.TargetAgent.text = name;
				Draw.DrawRectangle(m_Display.m_BG, 0, 0, m_Display.TargetAgent._width + 10,  m_Display.TargetAgent._height + 10, 0x000000, 0, [8, 8, 8, 8]);
				Show();
			} else {
				Hide();
			}
		}
	}
	public function GuiEdit(state) {
		if (state) {
			m_Display.onPress = Delegate.create(this, StartDrag);
			m_Display.onRelease = Delegate.create(this, StopDrag);
			m_Display.onReleaseOutside = Delegate.create(this, StopDrag);
		} else {
			m_Display.onPress = undefined;
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