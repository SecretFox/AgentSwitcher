 
import org.aswing.Icon;

/**
 * @author iiley
 */
class com.f1sr.aswing.plaf.office2003.icon.CheckBoxIcon extends org.aswing.plaf.basic.icon.CheckBoxIcon{
	private static var aswInstance:Icon;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Icon{
		if(aswInstance == null){
			aswInstance = new CheckBoxIcon();
		}
		return aswInstance;
	}

	private function CheckBoxIcon(){
		super();
	}
}
