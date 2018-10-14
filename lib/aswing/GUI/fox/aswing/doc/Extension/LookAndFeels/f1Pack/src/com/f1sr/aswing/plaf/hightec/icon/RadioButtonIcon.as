/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.Icon;
 
/**
 *
 * @author iiley
 */
class com.f1sr.aswing.plaf.hightec.icon.RadioButtonIcon extends org.aswing.plaf.basic.icon.RadioButtonIcon{
	
	private static var aswInstance:Icon;
	
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Icon{
		if(aswInstance == null){
			aswInstance = new RadioButtonIcon();
		}
		return aswInstance;
	}

	private function RadioButtonIcon(){
		super();
	}
}
