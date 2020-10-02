import com.GameInterface.Game.Character;
import com.GameInterface.MathLib.Vector3;
import com.Utils.LDBFormat;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Utils.NameFilter {
	public static var DeadOps:Array = [LDBFormat.LDBGetText(51000, 31937),new Vector3(373,0,263)];
	public static var Hound:Array = [LDBFormat.LDBGetText(51000, 30556),new Vector3(125,0,500)];
	public static var Warcaller:Array = [LDBFormat.LDBGetText(51000, 31392), new Vector3(169.9,0,497.7)];


	// Returns True if character should not be tracked
	public static function isFiltered(Char:Character):Boolean{
		if (!Char.IsEnemy() || Char.IsDead()) return true;
		/* Unneeded with the coordinate system
		switch(Char.GetName()){
			case DeadOps[0]:
				var distance:Vector3 = Vector3.Sub(Char.GetPosition(), DeadOps[1]);
				if (Math.abs(distance.x + distance.z) < 2){
					//com.GameInterface.UtilsBase.PrintChatText("not filtering " + DeadOps[0] + "  " + Char.GetDistanceToPlayer() +" "+distance.x + " " + distance.z);
					return false;
				}
				//com.GameInterface.UtilsBase.PrintChatText("filtering " + DeadOps[0] + "  " + Char.GetDistanceToPlayer()+ " " + Char.GetPosition().x + " " + Char.GetPosition().z+ " " + (distance.x + distance.z));
				return true;
			case Warcaller[0]:
				var distance:Vector3 = Vector3.Sub(Char.GetPosition(), Warcaller[1]);
				if (Math.abs(distance.x + distance.z) < 2){
					//com.GameInterface.UtilsBase.PrintChatText("not filtering " + Warcaller[0] + "  " + Char.GetDistanceToPlayer() +" "+distance.x + " " + distance.z);
					return false;
				}
				//UtilsBase.PrintChatText("filtering " + Warcaller[0] + "  " + Char.GetDistanceToPlayer()+ " " + Char.GetPosition().x + " " + Char.GetPosition().z+ " " + (distance.x + distance.z));
				return true;
			case Hound[0]:
				var distance:Vector3 = Vector3.Sub(Char.GetPosition(), Hound[1]);
				if (Math.abs(distance.x + distance.z) < 5){
					//com.GameInterface.UtilsBase.PrintChatText("not filtering " + Hound[0] + "  " + Char.GetDistanceToPlayer() +" "+distance.x + " " + distance.z);
					return false;
				}
				//com.GameInterface.UtilsBase.PrintChatText("filtering " + Hound[0] + "  " + Char.GetDistanceToPlayer()+ " " + Char.GetPosition().x + " " + Char.GetPosition().z+ " " + (distance.x + distance.z));
				return true;
			default:
				return false;
		}
		*/
	}

	
}