/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.ASFont;
import org.aswing.plaf.ASColorUIResource;
import org.aswing.plaf.ASFontUIResource;
import org.aswing.plaf.basic.BasicLookAndFeel;
import org.aswing.plaf.InsetsUIResource;
import org.aswing.UIDefaults;

import com.iiley.aswing.laf.comeny.AdvancedColorUIResource;

/**
 * @author iiley
 */
class com.iiley.aswing.laf.comeny.ComenyLookAndFeel extends BasicLookAndFeel {
	
	public function ComenyLookAndFeel(){
		super();
	}
	
	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		var uiDefaults:Array = [
			   "ButtonUI", com.iiley.aswing.laf.comeny.ComenyButtonUI,
			   "TextFieldUI", com.iiley.aswing.laf.comeny.ComenyTextFieldUI,
			   "TextAreaUI", com.iiley.aswing.laf.comeny.ComenyTextAreaUI,
			   "FrameUI", com.iiley.aswing.laf.comeny.ComenyFrameUI,
			   "SliderUI", com.iiley.aswing.laf.comeny.ComenySliderUI
		   ];
		table.putDefaults(uiDefaults);
	}
	
	private function initSystemColorDefaults(table:UIDefaults):Void{
		super.initSystemColorDefaults(table);
		
		var defaultSystemColors:Array = [
			"control", 0xB6B6B6, /* Default color for controls (buttons, sliders, etc) */
			"controlText", 0x67152F, /* Default color for text in controls */
			"controlLight", 0xFFADC9 /* Specular highlight (rollover light) */
		];
				
		for(var i:Number=0; i<defaultSystemColors.length; i+=2){
			table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
		}
		table.put("focusInner", new ASColorUIResource(0x40FF40, 30));
		table.put("focusOutter", new ASColorUIResource(0x40FF40, 50));
					
	}
	
	private function initSystemFontDefaults(table:UIDefaults):Void{
		super.initSystemFontDefaults(table);
		var defaultSystemFonts:Array = [
				"systemFont", new ASFontUIResource("Arial", 12, true), 
				"menuFont", new ASFontUIResource("Arial", 12, true), 
				"controlFont", new ASFontUIResource("Arial", 12, true), 
				"windowFont", new ASFontUIResource("Arial", 12, true)
		];
		table.putDefaults(defaultSystemFonts);
	}
	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
		
		var control:AdvancedColorUIResource = AdvancedColorUIResource.makeResource(table.getColor("control"));
		var text:AdvancedColorUIResource = AdvancedColorUIResource.makeResource(table.getColor("controlText"));
		var light:AdvancedColorUIResource = AdvancedColorUIResource.makeResource(table.getColor("controlLight"));
		var shadow:AdvancedColorUIResource = control.luminanceAdjusted(-0.7);
		var window:AdvancedColorUIResource = control.luminanceAdjusted(0.9);
		var font:ASFont = table.getFont("controlFont");
		
	   // *** JButton
	    var comDefaults:Array = [
	    	"Button.background", control.luminanceAdjusted(0.4),
	    	"Button.foreground", text,
	    	"Button.opaque", true,  
	    	"Button.focusable", true,  
	    	"Button.shadow", shadow,            
        	"Button.light", light,       
        	"Button.font", font,
			"Button.border", undefined,
			"Button.margin", new InsetsUIResource(5, 10, 5, 10),
			"Button.textShiftOffset", 1
		];
	    table.putDefaults(comDefaults);
	    
	    // *** RadioButton
	    comDefaults = [
		    "RadioButton.background", window,
		    "RadioButton.foreground", text,
	    	"RadioButton.opaque", false,  
	    	"RadioButton.focusable", true,  
		    "RadioButton.shadow", control,
	        "RadioButton.light", light,
        	"RadioButton.font", font,
		    "RadioButton.icon", com.iiley.aswing.laf.comeny.icon.RadioButtonIcon,
		    "RadioButton.margin", new InsetsUIResource(0, 0, 0, 0),
		    "RadioButton.textShiftOffset", 1
	  	];
	    table.putDefaults(comDefaults);	     
	    	    
	    // *** CheckBox
	    comDefaults = [
		    "CheckBox.background", window,
		    "CheckBox.foreground", text,
	    	"CheckBox.opaque", false,  
	    	"CheckBox.focusable", true,  
		    "CheckBox.shadow", control,
	        "CheckBox.light", light,
        	"CheckBox.font", font,
		    "CheckBox.icon", com.iiley.aswing.laf.comeny.icon.CheckBoxIcon,
		    "CheckBox.margin", new InsetsUIResource(0, 0, 0, 0),
		    "CheckBox.textShiftOffset", 1
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** TextField
	    comDefaults = [
		    "TextField.background", window.luminanceAdjusted(0.2),
		    "TextField.foreground", text,
	    	"TextField.opaque", true,  
	    	"TextField.focusable", true,
        	"TextField.font", font,
		    "TextField.border", com.iiley.aswing.laf.comeny.border.TextBorder
	   	];
	    table.putDefaults(comDefaults);
	    
	     // *** TextArea
	    comDefaults = [
		    "TextArea.background", window.luminanceAdjusted(0.2),
		    "TextField.foreground", text,
		    "TextArea.foreground", text,
	    	"TextArea.opaque", true,  
	    	"TextArea.focusable", true,
        	"TextArea.font", font,
		    "TextArea.border", com.iiley.aswing.laf.comeny.border.TextBorder
		];
	    table.putDefaults(comDefaults);
	    
	    // *** Frame
	    comDefaults = [
		    "Frame.background", window,
		    "Frame.foreground", text,
	    	"Frame.opaque", true,  
	    	"Frame.focusable", true,
		    "Frame.activeCaption", control,
		    "Frame.activeCaptionText", text,
		    "Frame.inactiveCaption", control,
		    "Frame.inactiveCaptionText", text,
		    "Frame.titleBarUI", com.iiley.aswing.laf.comeny.frame.ComenyTitleBarUI,
		    "Frame.resizer", org.aswing.plaf.basic.frame.FrameResizer,
		    "Frame.font", font,
		    "Frame.border", undefined,
		    "Frame.icon", org.aswing.plaf.basic.frame.TitleIcon,
		    "Frame.iconifiedIcon", com.iiley.aswing.laf.comeny.icon.FrameIconifiedIcon,
		    "Frame.normalIcon", com.iiley.aswing.laf.comeny.icon.FrameNormalIcon,
		    "Frame.maximizeIcon", com.iiley.aswing.laf.comeny.icon.FrameMaximizeIcon,
		    "Frame.closeIcon", com.iiley.aswing.laf.comeny.icon.FrameCloseIcon
	    ];
	    table.putDefaults(comDefaults);	  
	    
	    // *** Slider
	    comDefaults = [
		    "Slider.background", window,
		    "Slider.foreground", text,
	    	"Slider.opaque", false,  
	    	"Slider.focusable", true,  
		    "Slider.shadow", control,
	        "Slider.light", light,
        	"Slider.font", font,
	    	"Slider.border", undefined
	    ];
	    table.putDefaults(comDefaults);
	}
	
}