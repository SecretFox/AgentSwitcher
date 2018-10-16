import com.GameInterface.AgentSystem;
import com.GameInterface.AgentSystemAgent;
import com.GameInterface.DistributedValue;
import com.Utils.Draw;
import com.Utils.GlobalSignal;
import com.Utils.Signal;
import com.fox.AgentSwitcher.AgentHelper;
import com.fox.Utils.Common;
import flash.geom.Point;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.AgentDisplay{
	public var SignalMoved:Signal;
	private var m_swfRoot:MovieClip;
	private var m_Display:MovieClip;
	private var DisplayPos:Point;
	private var TargetSlot:Number;
	private var SlotDval:DistributedValue;
	
	public function AgentDisplay(root, pos) {
		SignalMoved = new Signal();
		m_swfRoot = root;
		DisplayPos = pos;
		SlotDval = DistributedValue.Create("AgentSwitcher_Slot");
		SlotDval.SignalChanged.Connect(SlotChanged, this);
		TargetSlot = SlotDval.GetValue();
		DrawDisplay();
	}
	private function SlotChanged(dv:DistributedValue){
		TargetSlot = dv.GetValue();
	}
	private function DrawDisplay(){
		m_Display.removeMovieClip();
		m_Display = m_swfRoot.createEmptyMovieClip("AgentDisplay", m_swfRoot.getNextHighestDepth());
		var m_BG = m_Display.createEmptyMovieClip("m_BG", m_Display.getNextHighestDepth());
		m_Display._x = DisplayPos.x;
		m_Display._y = DisplayPos.y;
		var format:TextFormat = new TextFormat("_StandardFont", 14, 0xFFFFFF);
		var Text:TextField = m_Display.createTextField("TargetAgent", m_Display.getNextHighestDepth(), 6, 6, 100, 20);
		Text.autoSize = true;
		Text.setTextFormat(format);
		Text.setNewTextFormat(format);
		Text.embedFonts = true;
		ChangeText(TargetSlot - 1);
		GlobalSignal.SignalSetGUIEditMode.Connect(guiEdit, this);
		AgentSystem.SignalPassiveChanged.Connect(ChangeText, this);
	}
	public function Hide(){
		m_Display._visible = false;
	}
	public function Show(){
		m_Display._visible = true;
	}
	private function ChangeText(slotID){
		if (slotID == TargetSlot - 1){
			var SlotAgent:AgentSystemAgent = AgentHelper.GetAgentInSlot(slotID);
			if (SlotAgent){
				m_Display.TargetAgent.text = SlotAgent.m_Name;
				Draw.DrawRectangle(m_Display.m_BG, 0, 0, m_Display.TargetAgent._width + 10,  m_Display.TargetAgent._height + 10, 0x000000, 0, [8, 8, 8, 8]);
				Show();
			}else{
				Hide();
			}
		}
	}
	
	public function Destroy(){
		GlobalSignal.SignalSetGUIEditMode.Disconnect(guiEdit, this);
		AgentSystem.SignalPassiveChanged.Disconnect(ChangeText, this);
		SlotDval.SignalChanged.Disconnect(SlotChanged, this);
		m_Display.removeMovieClip();
	}
	
	
	private function guiEdit(state){
		if (state){
			m_Display.onPress = Delegate.create(this, StartDrag);
			m_Display.onRelease = Delegate.create(this, StopDrag);
			m_Display.onReleaseOutside = Delegate.create(this, StopDrag);
		}else{
			m_Display.onPress = undefined;
			m_Display.onRelease = undefined;
			m_Display.onReleaseOutside = undefined;
		}
	}
	private function StartDrag(){
		m_Display.startDrag();
	}
	private function StopDrag(){
		m_Display.stopDrag();
		var newPos:Point = Common.getOnScreen(m_Display);
		m_Display._x = newPos.x;
		m_Display._y = newPos.y;
		DisplayPos = newPos;
		SignalMoved.Emit(newPos);
	}
}