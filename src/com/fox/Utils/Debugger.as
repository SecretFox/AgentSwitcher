import com.GameInterface.Log;
/*
 * ...
 * @author fox
 */
class com.fox.Utils.Debugger{
	static function LogText(text){
		Log.Warning("AgentSwitcher", text)
	}
	static function PrintText(text){
		com.GameInterface.UtilsBase.PrintChatText(string(text));
	}
}