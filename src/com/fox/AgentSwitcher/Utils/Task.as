import com.fox.AgentSwitcher.Utils.Player;
import com.GameInterface.Game.Shortcut;
import com.Utils.Signal;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.AgentSwitcher.Utils.Task {
	static var TaskQueue:Array = [];
	static var OutCombatTask:Number = 0;
	static var InCombatTask:Number = 1;
	static var BuildTask:Number = 2;

	public var ID:Number;
	public var Type:Number;
	private var Callback:Function;
	private var AbortCallback:Function;
	private var SignalDone:Signal;
	private var timeout:Number;
	private var m_Player:Player;

	static function AddTask(type, f, f2) {
		var id = TaskQueue.length;
		var task:Task = new Task(id, f, type, f2)
		TaskQueue.push(task);
		task.SignalDone.Connect(RemoveTask);
		task.Start();
	}
	static function RemoveTask(id) {
		TaskQueue[id].kill();
		TaskQueue.splice(id, 1);
		for (var i = 0; i < TaskQueue.length; i++ ) {
			TaskQueue[i].ID = i;
		}
	}
	static function RemoveTasksByType(type:Number) {
		//Removes existing tasks of this type
		for (var i in TaskQueue) {
			if (TaskQueue[i].Type == type) {
				TaskQueue[i].kill();
				TaskQueue.splice(Number(i), 1);
			}
		}
		for (var i = 0; i < TaskQueue.length; i++ ) {
			TaskQueue[i].ID = i;
		}
	}
	static function RemoveAllTasks() {
		for (var i in TaskQueue) {
			TaskQueue[i].kill();
		}
		TaskQueue = new Array();
	}
	static function HasTaskType(type:Number) {
		for (var i in TaskQueue) {
			if (TaskQueue[i].type == type) {
				return true;
			}
		}
		return false;
	}
	public function Task(id, f, type, f2) {
		m_Player = Player.GetPlayer();
		Callback = f;
		AbortCallback = f2;
		Type = type;
		SignalDone = new Signal();
		ID = id;
	}
	public function Start() {
		if (Type == 0) StartTask1();
		else if (Type == 1) StartTask2();
		else if (Type == 2) StartTask3();
	}
	public function GetType() {
		return Type
	}
	private function kill() {
		AbortCallback();
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat2, this);
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat3, this);
		Shortcut.SignalCooldownTime.Disconnect(CooldownChangedBuffer, this);
		clearTimeout(timeout);
		Callback = undefined;
	}
//Tasktype 1
//Triggers when player exits combat
	public function StartTask1() {
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat, this);
		SlotToggleCombat();
	}
	private function SlotToggleCombat(state:Boolean) {
		if (!m_Player.IsinPlay()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this,SlotToggleCombat), 200);
			return
		}
		if (!m_Player.IsInCombat()) {
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
			Callback();
			SignalDone.Emit(ID);
		}
	}
//Tasktype 2
//Triggers when player starts combat (!=threatened!)
	public function StartTask2() {
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat2, this);
		if (m_Player.IsThreatened()) SlotToggleCombat2(true);
	}
	private function SlotToggleCombat2(state:Boolean) {
		if (!m_Player.IsinPlay()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this,SlotToggleCombat2), 200);
			return
		}
		if (m_Player.IsInCombat()) {
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat2, this);
			Callback();
			SignalDone.Emit(ID);
		} else if (m_Player.IsThreatened()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this, SlotToggleCombat2), 200);
		}
	}
//Tasktype 3
//Triggers when player has no cooldowns and is out of combat
	public function StartTask3() {
		Shortcut.SignalCooldownTime.Connect(CooldownChangedBuffer, this);
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat3, this);
		CheckIfCompleted();
	}
	private function CooldownChangedBuffer(itemPos, cooldownStart, cooldownEnd, cooldownFlags) {
		if (cooldownStart == cooldownEnd) {
			clearTimeout(timeout);
			// Ability slot has to update first
			timeout = setTimeout(Delegate.create(this, CheckIfCompleted), 50);
		}
	}
	private function SlotToggleCombat3() {
		if (!m_Player.IsInCombat()) {
			CheckIfCompleted();
		}
	}
	private function CheckIfCompleted() {
		if (!m_Player.IsinPlay()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this,CheckIfCompleted), 200);
			return
		}
		if (!Player.HasCooldown() && !m_Player.IsInCombat()) {
			Shortcut.SignalCooldownTime.Disconnect(CooldownChangedBuffer, this);
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat3, this);
			Callback();
			SignalDone.Emit(ID);
		}
	}
}