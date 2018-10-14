/*
 Copyright aswing.org, see the LICENCE.txt.
*/
 
import org.aswing.plaf.ASColorUIResource;
import org.aswing.plaf.basic.BasicLookAndFeel;
import org.aswing.plaf.InsetsUIResource;
import org.aswing.UIDefaults;
 
/**
 *
 * @author Firdosh
 */
class org.aswing.plaf.winxp.WinXpLookAndFeel extends BasicLookAndFeel{
	
	public function WinXpLookAndFeel(){
		super();
	}
	
	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		var uiDefaults:Array = [
			   "ButtonUI", org.aswing.plaf.winxp.WinXpButtonUI,
			   "PanelUI", org.aswing.plaf.basic.BasicPanelUI,
			   "WindowUI", org.aswing.plaf.basic.BasicWindowUI,
			   "ToggleButtonUI", org.aswing.plaf.winxp.WinXpToggleButtonUI,
			   "RadioButtonUI", org.aswing.plaf.winxp.WinXpRadioButtonUI,
			    "FrameUI", org.aswing.plaf.winxp.WinXpFrameUI,
			     "TextFieldUI", org.aswing.plaf.winxp.WinXpTextFieldUI,
			      "TextAreaUI", org.aswing.plaf.winxp.WinXpTextAreaUI,
			         "CheckBoxUI", org.aswing.plaf.winxp.WinXpCheckBoxUI
			   ];
		table.putDefaults(uiDefaults);
	}
	
	private function initSystemColorDefaults(table:UIDefaults):Void{
			var defaultSystemColors:Array = [
				  "activeCaption", 0xE0E0E0, /* Color for captions (title bars) when they are active. */
			      "activeCaptionText", 0x000000, /* Text color for text in captions (title bars). */
			    "activeCaptionBorder", 0xC0C0C0, /* Border color for caption (title bar) window borders. */
			        "inactiveCaption", 0x808080, /* Color for captions (title bars) when not active. */
			    "inactiveCaptionText", 0xC0C0C0, /* Text color for text in inactive captions (title bars). */
			  "inactiveCaptionBorder", 0xC0C0C0, /* Border color for inactive caption (title bar) window borders. */
				         "window", 0xF4F4F4, /* Default color for the interior of windows */
				   "windowBorder", 0x000000, /* ??? */
				     "windowText", 0x000000, /* ??? */
					   "menu", 0xC0C0C0, /* Background color for menus */
				       "menuText", 0x000000, /* Text color for menus  */
					   "text", 0xC0C0C0, /* Text background color */
				       "textText", 0x000000, /* Text foreground color */
				  "textHighlight", 0x000080, /* Text background color when selected */
			      "textHighlightText", 0xFFFFFF, /* Text color when selected */
			       "textInactiveText", 0x808080, /* Text color when disabled */
				        "control", 0xF4F4F4,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				    "controlText", 0x000000, /* Default color for text in controls */
			       "controlHighlight", 0xEEEEEE, /* Specular highlight (opposite of the shadow) */
			     "controlLtHighlight", 0x666666, /* Highlight color for controls */
				  "controlShadow", 0xC7C7C5, /* Shadow color for controls */
			        "controlDkShadow", 0x666666, /* Dark shadow color for controls */
				      "scrollbar", 0xE0E0E0 /* Scrollbar background (usually the "track") */
			];
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
					
	}
	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
		
	    // *** Buttons
	    var comDefaults:Array = [
	    "Button.upperBgGradDown", new ASColorUIResource(0xdcd8cf),
	    "Button.lowerBgGradDown", new ASColorUIResource(0xf2f1ee),
	    "Button.upperBgGradUp", new ASColorUIResource(0xFFFFFF),
	    "Button.lowerBgGradUp", new ASColorUIResource(0xd6d0c5),
        "Button.highlight", new ASColorUIResource(0x003c74),
	    "Button.border", org.aswing.plaf.winxp.border.ButtonBorder,
	    "Button.margin", new InsetsUIResource(2, 14, 2, 14),
	    "Button.textIconGap", 2,
	    "Button.textShiftOffset", 1];
	    table.putDefaults(comDefaults);
	    
	     // *** ToggleButton
	     comDefaults = [
	    "ToggleButton.upperBgGradDown", new ASColorUIResource(0xdcd8cf),
	    "ToggleButton.lowerBgGradDown", new ASColorUIResource(0xe0e0d7),
	    "ToggleButton.upperBgGradUp", new ASColorUIResource(0xFFFFFF),
	    "ToggleButton.lowerBgGradUp", new ASColorUIResource(0xd6d0c5),
        "ToggleButton.highlight", new ASColorUIResource(0x003c74),
        "ToggleButton.font", table.getFont("controlFont"),
		"ToggleButton.border", org.aswing.plaf.winxp.border.ButtonBorder,
		"ToggleButton.margin", new InsetsUIResource(0, 0, 0, 0),
		"ToggleButton.textShiftOffset", 1];
	    table.putDefaults(comDefaults);
	    
	    // *** Panel
	    comDefaults = [
	    "Panel.background", new ASColorUIResource(0xece9d8),
	    "Panel.foreground", table.get("windowText")
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** RadioButton
	    comDefaults = [
	    "RadioButton.background", new ASColorUIResource(0xece9d8),
	    "RadioButton.foreground", table.get("controlText"),
	    "RadioButton.shadow", new ASColorUIResource(0xEAEAEA),
        "RadioButton.upperGradUp", new ASColorUIResource(0xe5e5e2),
        "RadioButton.lowerGradUp",new ASColorUIResource(0xfbfbfa),
        "RadioButton.dotUpperGradUp", new ASColorUIResource(0x55d551),
        "RadioButton.dotLowerGradUp",new ASColorUIResource(0x22a220),
        "RadioButton.highlight",new ASColorUIResource(0x003c74),
        "RadioButton.font", table.getFont("controlFont"),
		"RadioButton.icon", org.aswing.plaf.winxp.icon.RadioButtonIcon,
		"RadioButton.margin", new InsetsUIResource(0, 0, 0, 0),
		"RadioButton.textShiftOffset", 1];
	    table.putDefaults(comDefaults);	    
	    
	    // *** CheckBox
	    comDefaults = [
	    "CheckBox.background",new ASColorUIResource(0xece9d8),
	    "CheckBox.foreground", table.get("controlText"),
	    "CheckBox.shadow", table.getColor("controlShadow"),
	     "CheckBox.highlight",new ASColorUIResource(0x003c74),
        "CheckBox.upperGradUp", new ASColorUIResource(0xe5e5e2),
        "CheckBox.lowerGradUp", new ASColorUIResource(0xfbfbfa),
        "CheckBox.dotUpperGradUp", new ASColorUIResource(0x21a121),
         "CheckBox.dotLowerGradUp",new ASColorUIResource(0x22a220),
        "CheckBox.font", table.getFont("controlFont"),
		"CheckBox.icon", org.aswing.plaf.winxp.icon.CheckBoxIcon,
		"CheckBox.margin", new InsetsUIResource(0, 0, 0, 0),
		"CheckBox.textShiftOffset", 1];
	    table.putDefaults(comDefaults);
	    
	     // *** TextField
	    comDefaults = [
	    "TextField.background", new ASColorUIResource(0xffffff),
	    "TextField.foreground", new ASColorUIResource(0x000000),
        "TextField.shadow", new ASColorUIResource(0x999999),
        "TextField.darkShadow", new ASColorUIResource(0xDCDEDD),
        "TextField.light", new ASColorUIResource(0xDCDEDD),
        "TextField.highlight", new ASColorUIResource(0x7f9db9),
        "TextField.font", table.getFont("controlFont"),
		"TextField.border", org.aswing.plaf.winxp.border.TextFieldBorder];
	    table.putDefaults(comDefaults);
	    
	     // *** TextField
	    comDefaults = [
	    "TextArea.background", new ASColorUIResource(0xffffff),
	    "TextArea.foreground", new ASColorUIResource(0x000000),
        "TextArea.shadow", new ASColorUIResource(0x999999),
        "TextArea.darkShadow", new ASColorUIResource(0xDCDEDD),
        "TextArea.light", new ASColorUIResource(0xDCDEDD),
        "TextArea.highlight", new ASColorUIResource(0x7f9db9),
        "TextArea.font", table.getFont("controlFont"),
		"TextArea.border", org.aswing.plaf.winxp.border.TextAreaBorder];
	    table.putDefaults(comDefaults);
	    
	     // *** Frame
	    comDefaults = [
	    "Frame.background", table.get("window"),
	    "Frame.foreground", new ASColorUIResource(0xffffff),
	    "Frame.activeCaption", table.get("activeCaption"),
	    "Frame.activeCaptionText", table.get("activeCaptionText"),
	    "Frame.activeCaptionBorder", table.get("activeCaptionBorder"),
	    "Frame.inactiveCaption", table.get("inactiveCaption"),
	    "Frame.inactiveCaptionText", table.get("inactiveCaptionText"),
	    "Frame.inactiveCaptionBorder", table.get("inactiveCaptionBorder"),
	    "Frame.resizeArrow", table.get("inactiveCaption"),
	    "Frame.resizeArrowLight", table.get("window"),
	    "Frame.resizeArrowDark", table.get("activeCaptionText"),
	    "Frame.titleBarUI", org.aswing.plaf.winxp.frame.WinXpTitleBarUI,
	    "Frame.font", table.get("windowFont"),
	    "Frame.border", org.aswing.plaf.basic.border.FrameBorder,
	    "Frame.icon", org.aswing.plaf.basic.frame.TitleIcon,
	    "Frame.iconifiedIcon", org.aswing.plaf.basic.icon.FrameIconifiedIcon,
	    "Frame.normalIcon", org.aswing.plaf.basic.icon.FrameNormalIcon,
	    "Frame.maximizeIcon", org.aswing.plaf.basic.icon.FrameMaximizeIcon,
	    "Frame.closeIcon", org.aswing.plaf.basic.icon.FrameCloseIcon
	    ];
	    table.putDefaults(comDefaults);	  
	    
	    // *** Window
	    comDefaults = [
	    "Window.background", new ASColorUIResource(0xece9d8),
	    "Window.foreground", table.get("windowText"),
	    "Window.modalColor", table.get("controlShadow")
	    ];
	    table.putDefaults(comDefaults);
	}	
	
	
}
