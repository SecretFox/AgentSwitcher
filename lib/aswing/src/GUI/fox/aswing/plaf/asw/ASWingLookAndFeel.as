/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import GUI.fox.aswing.plaf.ASColorUIResource;
import GUI.fox.aswing.plaf.basic.BasicLookAndFeel;
import GUI.fox.aswing.UIDefaults;
 
/**
 *
 * @author iiley
 */
class GUI.fox.aswing.plaf.asw.ASWingLookAndFeel extends BasicLookAndFeel{
	
	
	public function ASWingLookAndFeel(){
		super();
	}
	
	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		
		var uiDefaults:Array = [
				//"ButtonUI", GUI.fox.aswing.plaf.asw.ASWingButtonUI,
				//"PanelUI", GUI.fox.aswing.plaf.asw.ASWingPanelUI,
				//"ToggleButtonUI", GUI.fox.aswing.plaf.asw.ASWingToggleButtonUI,
				//"RadioButtonUI", GUI.fox.aswing.plaf.asw.ASWingRadioButtonUI,
				//"CheckBoxUI", GUI.fox.aswing.plaf.asw.ASWingCheckBoxUI,
				//"FrameUI", GUI.fox.aswing.plaf.asw.ASWingFrameUI,
				//"ScrollBarUI", GUI.fox.aswing.plaf.asw.ASWingScrollBarUI,
				//"TableHeaderUI", GUI.fox.aswing.plaf.asw.ASWingTableHeaderUI,
				//"TabbedPaneUI", GUI.fox.aswing.plaf.asw.ASWingTabbedPaneUI, 
				//"SliderUI", GUI.fox.aswing.plaf.asw.ASWingSliderUI
			   ];
		table.putDefaults(uiDefaults);
	}

	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
		
		var buttonBG:ASColorUIResource = new ASColorUIResource(0xE7E7E5);
	   // *** JButton
	    var comDefaults:Array = [
	    "Button.background", buttonBG,
		    "Button.border", GUI.fox.aswing.plaf.asw.border.ButtonBorder];
	    table.putDefaults(comDefaults);
	    
	    // *** ToggleButton
	    comDefaults = [
		    "ToggleButton.border", GUI.fox.aswing.plaf.asw.border.ButtonBorder];
	    table.putDefaults(comDefaults);
	    
	    // *** RadioButton
	    comDefaults = [
		    "RadioButton.icon", GUI.fox.aswing.plaf.basic.icon.RadioButtonIcon];
	    table.putDefaults(comDefaults);	    
	    	    
	    // *** CheckBox
	    comDefaults = [
		    "CheckBox.icon", GUI.fox.aswing.plaf.basic.icon.CheckBoxIcon];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollBar
	    comDefaults = [
		    "ScrollBar.thumb", buttonBG
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** Panel
	    	   
	    // *** Frame
	    comDefaults = [	   
		    "Frame.activeCaption", new ASColorUIResource(0xF7F7F7),
		    "Frame.activeCaptionText", table.get("activeCaptionText"),
		    "Frame.activeCaptionBorder", new ASColorUIResource(0xC0C0C0),
		    "Frame.inactiveCaption", new ASColorUIResource(0xE7E7E7),
		    "Frame.inactiveCaptionText", table.get("inactiveCaptionText"),
		    "Frame.inactiveCaptionBorder", new ASColorUIResource(0x888888),
		    "Frame.titleBarUI", GUI.fox.aswing.plaf.asw.frame.ASWingTitleBarUI,
		    "Frame.border", GUI.fox.aswing.plaf.asw.border.FrameBorder	   
	    ];
	    table.putDefaults(comDefaults);
	    
		// *** JTabbedPane
	    comDefaults = [ 
	    	"TabbedPane.shadow", table.getColor("controlShadow"),        
        	"TabbedPane.darkShadow", table.getColor("controlDkShadow"),        
        	"TabbedPane.light", table.getColor("controlHighlight"),       
       		"TabbedPane.highlight", table.getColor("controlLtHighlight")
       	];
	    table.putDefaults(comDefaults);
	    

	     // *** Table
	    
	     // *** TableHeader
	    comDefaults = [
		    "TableHeader.background", buttonBG,
	    	"TableHeader.opaque", true,  
	    	"TableHeader.cellBorder", GUI.fox.aswing.plaf.asw.border.TableHeaderCellBorder
	    ];
	    table.putDefaults(comDefaults);	  
	    
	    // *** Slider
	    comDefaults = [
		    "Slider.thumb", buttonBG
	    ];
	    table.putDefaults(comDefaults);  
	}
}
