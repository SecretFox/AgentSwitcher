/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.Icon;


class com.f1sr.aswing.plaf.spring.icon.CheckBoxIcon extends org.aswing.plaf.basic.icon.CheckBoxIcon{
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
