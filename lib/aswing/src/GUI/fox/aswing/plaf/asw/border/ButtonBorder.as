/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.border.Border;

/**
 * Through, this is same to GUI.fox.aswing.plaf.basic.border.ButtonBorder, 
 * this is just a sample to show, you need implement your own Border for buttons 
 * in your LAF.
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.border.ButtonBorder extends GUI.fox.aswing.plaf.basic.border.ButtonBorder{
	
	private static var aswInstance:ButtonBorder;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(aswInstance == null){
			aswInstance = new ButtonBorder();
		}else{
			aswInstance.reloadColors();
		}
		return aswInstance;
	}
	
	private function ButtonBorder(){
		super();
	}
}
