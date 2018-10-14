/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/
 
import org.aswing.plaf.ASColorUIResource;
import org.aswing.plaf.asw.ASWingLookAndFeel;
import org.aswing.UIDefaults;


class com.f1sr.aswing.plaf.grey.GreyLAF extends ASWingLookAndFeel
{
	public function GreyLAF()
	{
		super();
	}
	

	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		
		var uiDefaults:Array = [
			   "ButtonUI", org.aswing.plaf.asw.ASWingButtonUI,
			   "PanelUI", org.aswing.plaf.asw.ASWingPanelUI,
			   "ToggleButtonUI", org.aswing.plaf.asw.ASWingToggleButtonUI,
			   "RadioButtonUI", org.aswing.plaf.asw.ASWingRadioButtonUI,
			   "CheckBoxUI", org.aswing.plaf.asw.ASWingCheckBoxUI,
			   "FrameUI", org.aswing.plaf.asw.ASWingFrameUI
			   ];
		table.putDefaults(uiDefaults);
	}

	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
	   // *** JButton
	    var comDefaults:Array = [
	    "Button.background", new ASColorUIResource(0xE7E7E5),
		    "Button.border", org.aswing.plaf.asw.border.ButtonBorder];
	    table.putDefaults(comDefaults);
	    
	    // *** ToggleButton
	    comDefaults = [
		    "ToggleButton.border", org.aswing.plaf.asw.border.ButtonBorder];
	    table.putDefaults(comDefaults);
	    
	    // *** RadioButton
	    comDefaults = [
		    "RadioButton.icon", org.aswing.plaf.basic.icon.RadioButtonIcon];
	    table.putDefaults(comDefaults);	    
	    	    
	    // *** CheckBox
	    comDefaults = [
		    "CheckBox.icon", org.aswing.plaf.basic.icon.CheckBoxIcon];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollBar
	    
	    // *** Panel
	    
	    // *** Window
	    comDefaults = [	   
		    "Window.modalColor", new ASColorUIResource(0xFFFFFF,0),
		    "Window.contentPaneBorder", undefined,
		    "WindowUI",com.f1sr.aswing.plaf.grey.GreyWindowUI
	    	];
	    table.putDefaults(comDefaults);
	   
	    // *** Frame
	    comDefaults = [	   
	    "Frame.titleBarUI", org.aswing.plaf.asw.frame.ASWingTitleBarUI,
	    "Frame.border", org.aswing.plaf.asw.border.FrameBorder	   
	    ];
	    table.putDefaults(comDefaults);
	}
	
	
	
}