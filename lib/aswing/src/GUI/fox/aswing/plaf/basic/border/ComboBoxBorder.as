import GUI.fox.aswing.border.BevelBorder;
import GUI.fox.aswing.border.Border;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.geom.Rectangle;
import GUI.fox.aswing.graphics.Graphics;
import GUI.fox.aswing.JComboBox;
import GUI.fox.aswing.plaf.UIResource;
import GUI.fox.aswing.UIManager;

/**
 * @author iiley
 */
class GUI.fox.aswing.plaf.basic.border.ComboBoxBorder extends BevelBorder implements UIResource{
	
	private static var instance:Border;
	/**
	 * this make shared instance and construct when use.
	 */	
	public static function createInstance():Border{
		if(instance == null){
			instance = new ComboBoxBorder();
		}
		return instance;
	}
	
	public function ComboBoxBorder() {
		super(null,
			LOWERED,
			UIManager.getColor("ComboBox.light"), 
            UIManager.getColor("ComboBox.highlight"), 
            UIManager.getColor("ComboBox.darkShadow"), 
            UIManager.getColor("ComboBox.shadow"));
	}
	
    public function paintBorderImp(c:Component, g:Graphics, b:Rectangle):Void{
    	var box:JComboBox = JComboBox(c);
    	if(box.isEditable()){
    		bevelType = LOWERED;
    	}else{
    		bevelType = RAISED;
    	}
       	super.paintBorderImp(c, g, b);
    }
}