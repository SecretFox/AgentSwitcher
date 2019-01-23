import com.GameInterface.Game.Character;
import com.fox.AgentSwitcher.Utils.Player;
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
	static var inPlayTask:Number = 2;

	public var Type:Number;
	private var Callback:Function;
	private var AbortCallback:Function;
	private var SignalDone:Signal;
	private var timeout:Number;
	private var m_Player:Character;

	static function AddTask(type, f, f2) {
		var task:Task = new Task(f, type, f2)
		TaskQueue.push(task);
		task.SignalDone.Connect(TaskDone);
		task.Start();
	}
	static function TaskDone(task:Task) {
		for (var i:Number = 0; i < TaskQueue.length;i++){
			if (TaskQueue[i] == task) {
				TaskQueue[i].dispose();
				TaskQueue.splice(i, 1);
				break
			}
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
	public function Task(f, type, f2) {
		m_Player = Player.GetPlayer();
		Callback = f;
		AbortCallback = f2;
		Type = type;
		SignalDone = new Signal();
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
		dispose();
	}
	private function dispose() {
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat2, this);
		clearTimeout(timeout);
		Callback = undefined;
		AbortCallback = undefined;
	}
//Tasktype 1
//Triggers when player exits combat
	public function StartTask1() {
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat, this);
		SlotToggleCombat();
	}
	private function SlotToggleCombat(state:Boolean) {
		if (!Player.IsinPlay()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this,SlotToggleCombat), 200);
			return
		}
		if (!m_Player.IsInCombat()) {
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
			Callback();
			SignalDone.Emit(this);
		}
	}
//Tasktype 2
//Triggers when player starts combat (!=threatened!)
	public function StartTask2() {
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat2, this);
		if (m_Player.IsThreatened()) SlotToggleCombat2(true);
	}
	private function SlotToggleCombat2(state:Boolean) {
		if (!Player.IsinPlay()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this,SlotToggleCombat2), 200);
			return
		}
		if (m_Player.IsInCombat()) {
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat2, this);
			Callback();
			SignalDone.Emit(this);
		} else if (m_Player.IsThreatened()) {
			clearTimeout(timeout);
			timeout = setTimeout(Delegate.create(this, SlotToggleCombat2), 200);
		}
	}
//Tasktype 3
//Triggers when player has no cooldowns and is out of combat
	public function StartTask3() {
		if (Player.IsinPlay()){
			Callback();
			SignalDone.Emit(this);
		}else{
			setTimeout(Delegate.create(this, StartTask3), 500);
		}
	}
}