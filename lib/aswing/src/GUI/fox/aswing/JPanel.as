/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.Container;
import GUI.fox.aswing.FlowLayout;
import GUI.fox.aswing.LayoutManager;
import GUI.fox.aswing.plaf.PanelUI;
import GUI.fox.aswing.UIManager;

/**
 * The general container - panel.
 * @author iiley
 */
class GUI.fox.aswing.JPanel extends Container{
	
	public function JPanel(layout:LayoutManager){
		super();
		setName("JPanel");
		if(layout == undefined) layout = new FlowLayout();
		this.layout = layout;
		updateUI();
	}
	
    public function updateUI():Void{
    	setUI(PanelUI(UIManager.getUI(this)));
    }
    
    public function setUI(newUI:PanelUI):Void{
    	super.setUI(newUI);
    }
	
	public function getUIClassID():String{
		return "PanelUI";
	}	
	
	public function getDefaultBasicUIClass():Function{
    	return GUI.fox.aswing.plaf.asw.ASWingPanelUI;
    }
}
