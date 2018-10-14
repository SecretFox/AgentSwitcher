/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.border.EmptyBorder;
import GUI.fox.aswing.border.LineBorder;
import GUI.fox.aswing.Insets;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.border.ProgressBarBorder extends LineBorder implements UIResource{
	
	private static var instance:Border;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new ProgressBarBorder();
		}
		return instance;
	}
	
	public function ProgressBarBorder() {
		super(new EmptyBorder(null, new Insets(1,1,1,1)), UIManager.getColor("ProgressBar.foreground"));
	}

}
