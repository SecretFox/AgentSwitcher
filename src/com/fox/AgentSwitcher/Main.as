import com.fox.AgentSwitcher.Controller;
import com.Utils.Archive;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Main{
	public static function main(swfRoot:MovieClip):Void {
		var m_controller = new Controller(swfRoot);
		swfRoot.onLoad =  function() {return m_controller.Load()};
		swfRoot.onUnload =  function() {return m_controller.Unload()};
		swfRoot.OnModuleActivated = function(config:Archive) {m_controller.Activate(config)};
		swfRoot.OnModuleDeactivated = function() {return m_controller.Deactivate()};
	}
	public function Main(root) {}
}