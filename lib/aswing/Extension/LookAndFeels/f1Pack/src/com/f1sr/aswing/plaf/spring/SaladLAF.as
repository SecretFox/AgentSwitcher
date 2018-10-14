/**
* Сopyright (c) F1 System Resource, Inc. 2006
* @author Rustem Mustafaiev msrustem@gmail.com
* @author Igor Sadovskiy isadovskiy@gmail.com
*/

import org.aswing.plaf.ASColorUIResource;
import org.aswing.plaf.ASFontUIResource;
import org.aswing.plaf.basic.BasicLookAndFeel;
import org.aswing.plaf.InsetsUIResource;
import org.aswing.UIDefaults;

class com.f1sr.aswing.plaf.spring.SaladLAF extends BasicLookAndFeel
{
	public function SaladLAF()
	{
		super();
	}
	
	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		
		var uiDefaults:Array = [
			"ComboBoxUI",com.f1sr.aswing.plaf.spring.ComboBoxUI,
			"TextFieldUI",com.f1sr.aswing.plaf.spring.SaladTextFieldUI,
        	"TextAreaUI",com.f1sr.aswing.plaf.spring.SaladTextAreaUI
		];
		table.putDefaults(uiDefaults);
	}
	
	private function initSystemColorDefaults(table:UIDefaults):Void{
			var defaultSystemColors:Array = [
				  "activeCaption", 0x57D602, /* Color for captions (title bars) when they are active. */
			      "activeCaptionText", 0x085004, /* Text color for text in captions (title bars). */
			    "activeCaptionBorder", 0xB3EE3A, /* Border color for caption (title bar) window borders. */
			        "inactiveCaption", 0xD7F95E, /* Color for captions (title bars) when not active. */
			    "inactiveCaptionText", 0x57D602, /* Text color for text in inactive captions (title bars). */
			  "inactiveCaptionBorder", 0xE6FACD, /* Border color for inactive caption (title bar) window borders. */
				         "window", 0xE6FACD, /* Default color for the interior of windows */
				   "windowBorder", 0x085004, /* ??? */
				     "windowText", 0x085004, /* ??? */
					   "menu", 0xE6FACD, /* Background color for menus */
				       "menuText", 0x085004, /* Text color for menus  */
					   "text", 0xE6FACD, /* Text background color */
				       "textText", 0x085004, /* Text foreground color */
				  "textHighlight", 0xEAFFA2, /* Text background color when selected */
			      "textHighlightText", 0xE6FACD, /* Text color when selected */
			       "textInactiveText", 0x7D9E07, /* Text color when disabled */
				        "control", 0x9AE904,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				    "controlText", 0x085004, /* Default color for text in controls */
			       "controlHighlight", 0xFFFFDC, /* Specular highlight (opposite of the shadow) */
			     "controlLtHighlight", 0x9AE904, /* Highlight color for controls */
				  "controlShadow", 0xE6FACD, /* Shadow color for controls */
			        "controlDkShadow", 0x6CA401, /* Dark shadow color for controls */
				      "scrollbar", 0xE6FACD /* Scrollbar background (usually the "track") */
			];
					
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
					
	}
	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
	   // *** JButton
	    var comDefaults:Array = [
	   		"ButtonUI", com.f1sr.aswing.plaf.spring.SaladButtonUI,
	    	"Button.background", new ASColorUIResource(0xC1F40D),
		    "Button.border", com.f1sr.aswing.plaf.spring.border.ButtonBorder
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ToggleButton
	    comDefaults = [
		    "ToggleButton.border", com.f1sr.aswing.plaf.spring.border.ButtonBorder,
		    "ToggleButtonUI", com.f1sr.aswing.plaf.spring.SaladToggleButtonUI
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** RadioButton
	    comDefaults = [
		    "RadioButton.icon", com.f1sr.aswing.plaf.spring.icon.RadioButtonIcon];
	    table.putDefaults(comDefaults);	    
	    	    
	    // *** CheckBox
	    comDefaults = [
		    "CheckBox.icon", com.f1sr.aswing.plaf.spring.icon.CheckBoxIcon];
	    table.putDefaults(comDefaults);

	    // *** ComboBox
	    comDefaults = [
	    	
	    	"ComboBox.background", table.get("controlLtHighlight"),//table.get("control"),
	   		"ComboBox.foreground", table.get("controlText"),
    		"ComboBox.opaque", true,
    		"ComboBox.focusable", false,
    		"ComboBox.shadow", table.getColor("controlShadow"),        
    		"ComboBox.darkShadow", table.getColor("controlDkShadow"),        
    		"ComboBox.light", table.getColor("controlHighlight"),       
   			"ComboBox.highlight", table.getColor("controlLtHighlight"),
	    	"ComboBox.border", com.f1sr.aswing.plaf.spring.border.ComboBoxBorder
	    	
	    ];
	    table.putDefaults(comDefaults);	   
	     
	    // *** List
	    comDefaults = [
		    "List.background", table.get("control"),
		    "List.foreground", table.get("controlText"),
		    "List.itemBackground", table.get("control"),
		    "List.itemForeground", table.get("controlText"),
	        "List.itemSelectedBackground", table.get("controlDkShadow"),//new ASColorUIResource(0x6CA401),
		    "List.itemSelectedForeground", table.get("control"),
		    "List.selectionBackground", table.get("controlText"),
		    "List.selectionForeground", table.get("control"),
	    	"List.border",undefined];
	    table.putDefaults(comDefaults);		    
	    
	     // *** TextField
	    comDefaults = [
	    	"TextField.background", table.get("menu"),
	    	"TextField.foreground", table.get("controlText"),
        	"TextField.shadow", table.get("controlShadow"),
        	"TextField.darkShadow", table.get("controlDkShadow"),
        	"TextField.light", table.get("inactiveCaption"),
        	"TextField.highlight", table.get("controlDkShadow"),
        	"TextField.border",com.f1sr.aswing.plaf.spring.border.TextFieldBorder
        	];
	    table.putDefaults(comDefaults);
	    
	     // *** TextArea
	    comDefaults = [
	    	"TextArea.background", table.get("menu"),
	    	"TextArea.foreground", table.get("controlText"),
        	"TextArea.shadow", table.get("controlShadow"),
        	"TextArea.darkShadow", table.get("controlDkShadow"),
        	"TextArea.light", table.get("inactiveCaption"),
        	"TextArea.highlight", table.get("controlDkShadow"),
        	"TextArea.border",com.f1sr.aswing.plaf.spring.border.TextFieldBorder
        	];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollBar
	    
	    // *** Panel
	    comDefaults = [	   
	    	"Panel.background", table.get("textHighlight")
	    	];
	    table.putDefaults(comDefaults);
	    
	   // *** JTabbedPane
	    comDefaults = [
	    	"TabbedPane.background", table.get("control"),
	    	"TabbedPane.foreground", table.get("controlText"),
	    	"TabbedPane.opaque", false,  
	    	"TabbedPane.focusable", true, 
	    	 
	    	//"TabbedPane.shadow", new ASColorUIResource(0x888888),        
        	//"TabbedPane.darkShadow", new ASColorUIResource(0x444444),        
        	//"TabbedPane.light", table.getColor("controlHighlight"),       
       		//"TabbedPane.highlight", new ASColorUIResource(0xFFFFFF),

	       	"TabbedPane.shadow", table.get("controlDkShadow"),
	        "TabbedPane.darkShadow", table.get("controlText"),
	        "TabbedPane.light", table.get("controlHighlight"),
	        "TabbedPane.highlight",table.get("textHighlight"),
        	       		
        	"TabbedPane.font", table.getFont("controlFont"),
			"TabbedPane.border", null,
			"TabbedPane.tabMargin", new InsetsUIResource(1, 1, 1, 1),
			"TabbedPane.baseLineThickness", 8,
			"TabbedPane.maxTabWidth", 1000,
			"TabbedPaneUI", com.f1sr.aswing.plaf.spring.SaladTabbedPaneUI
			];
	    table.putDefaults(comDefaults);
	    
	    // *** Window
	    comDefaults = [	   
		    "Window.background", table.get("window"),
		    "Window.foreground", table.get("windowText"),
	    	"Window.opaque", true,  
	    	"Window.focusable", true,
		    "Window.modalColor", new ASColorUIResource(0xFFFFFF,0),
		    "Window.contentPaneBorder", undefined,
		    "WindowUI",com.f1sr.aswing.plaf.spring.SaladWindowUI
	    	];
	    table.putDefaults(comDefaults);
	    	   
	    // *** Frame
	    comDefaults = [	   
	    	"Frame.foreground", table.get("window"),
	    	"Frame.backround", new ASColorUIResource(0xEAFFA2),
	    	"Frame.titleBarUI", com.f1sr.aswing.plaf.spring.frame.SaladTitleBarUI,
	    	"Frame.border", com.f1sr.aswing.plaf.spring.border.FrameBorder	   
	    ];
	    table.putDefaults(comDefaults);
	}	
	
	
	private function initSystemFontDefaults(table:UIDefaults):Void{
		var defaultSystemFonts:Array = [
				"systemFont", new ASFontUIResource("Arial", 11), 
				"menuFont", new ASFontUIResource("Arial", 11), 
				"controlFont", new ASFontUIResource("Arial", 11), 
				"windowFont", new ASFontUIResource("Arial", 11)
		];
		table.putDefaults(defaultSystemFonts);
	}	
	
}