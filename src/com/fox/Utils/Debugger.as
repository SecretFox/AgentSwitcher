import com.GameInterface.Chat;
import com.GameInterface.Log;
/*
 * ...
 * @author fox
 */
class com.fox.Utils.Debugger {
	static function LogText(text) {
		Log.Warning("AgentSwitcher", text)
	}
	static function PrintText(text) {
		com.GameInterface.UtilsBase.PrintChatText(string(text));
	}
	static function PrintArray(arr:Array) {
		com.GameInterface.UtilsBase.PrintChatText(string(arr.join(" ")));
	}
	static function PrintObject(obj:Object) {
		for (var i in obj){
			com.GameInterface.UtilsBase.PrintChatText(i + " : " +  string(obj[i]));
		}
		
	}
	static function ShowFifo(text) {
		Chat.SignalShowFIFOMessage.Emit(string(text),0);
	}
}