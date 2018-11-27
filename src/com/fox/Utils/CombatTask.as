import com.GameInterface.Game.Character;
import com.Utils.Signal;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.Utils.CombatTask{
	static var Tasks:Array = [];
	static var OutTask:Number = 0;
	static var InTask:Number = 1;
	
	private var m_Player:Character;
	private var Callback:Function;
	private var ID:Number;
	private var SignalDone:Signal;
	private var taskType:Number;
	private var threatTimeout:Number;
	
	static function AddTask(type, f) {
		var id = Tasks.length;
		var task:CombatTask = new CombatTask(id, f, type)
		Tasks.push(task);
		task.SignalDone.Connect(RemoveTask);
		task.Start();
	}
	static function RemoveTask(id){
		Tasks.splice(id, 1);
		for (var i = 0; i < Tasks.length;i++ ){
			Tasks[i].id = i;
		}
	}
	static function RemoveAllTasks(){
		for (var i in Tasks){
			Tasks[i].kill();
		}
		Tasks = new Array();
	}
	static function HasTaskType(type:Number){
		for (var i in Tasks){
			if (Tasks[i].taskType == type){
				return true;
			}
		}
		return false;
	}
	public function CombatTask(id, f, type) {
		m_Player = Character.GetClientCharacter();
		Callback = f;
		taskType = type;
		SignalDone = new Signal();
		ID = id;
	}
	public function Start(){
		if (!taskType) onOutOfCombat();
		else onStartCombat();
	}
	public function GetType(){
		return taskType
	}
	private function kill(){
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
		m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat2, this);
		clearTimeout(threatTimeout);
		Callback = undefined;
	}
	//Triggers when player exits combat
	public function onOutOfCombat(callback:Function){
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat, this);
		SlotToggleCombat();
	}
	private function SlotToggleCombat(state:Boolean){
		if (!m_Player.IsInCombat() && !m_Player.IsDead()){
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
			Callback();
			SignalDone.Emit(ID);
		}
	}
	
	//Triggers when player starts combat (!=threatened!)
	public function onStartCombat(callback:Function){
		m_Player.SignalToggleCombat.Connect(SlotToggleCombat2, this);
		if(m_Player.IsThreatened()) SlotToggleCombat2(true);
	}
	private function SlotToggleCombat2(state:Boolean){
		if (m_Player.IsInCombat()){
			m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat2, this);
			Callback();
			SignalDone.Emit(ID);
		}else if (m_Player.IsThreatened()){
			clearTimeout(threatTimeout);
			threatTimeout = setTimeout(Delegate.create(this, SlotToggleCombat2), 200);
		}
	}
}