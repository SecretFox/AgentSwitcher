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

class com.f1sr.aswing.plaf.office2003.Office2003LAF extends BasicLookAndFeel
{
	public function Office2003LAF(){
		super();
	}
	
	
	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		
		var uiDefaults:Array = [
		   "ButtonUI", com.f1sr.aswing.plaf.office2003.ButtonUI,
			"ToggleButtonUI", com.f1sr.aswing.plaf.office2003.ToggleButtonUI,
			"ComboBoxUI",com.f1sr.aswing.plaf.office2003.ComboBoxUI,
			
			"TextFieldUI",com.f1sr.aswing.plaf.office2003.TextFieldUI,
        	"TextAreaUI",com.f1sr.aswing.plaf.office2003.TextAreaUI,
        	"ScrollBarUI",com.f1sr.aswing.plaf.office2003.ScrollBarUI,
        	"TabbedPaneUI", com.f1sr.aswing.plaf.office2003.TabbedPaneUI,
        	"WindowUI",com.f1sr.aswing.plaf.office2003.WindowUI,	
			//"PanelUI",com.f1sr.aswing.plaf.office2003.PanelUI,
			"FrameUI",com.f1sr.aswing.plaf.office2003.FrameUI,
			"ScrollBarButtonUI",com.f1sr.aswing.plaf.office2003.button.ScrollBarButtonUI
			
			 
			 
		];
		table.putDefaults(uiDefaults);
	}
	
	
	private function initSystemColorDefaults(table:UIDefaults):Void{
			var defaultSystemColors:Array = [
				  	"activeCaption", 0x026AFE, /* Color for captions (title bars) when they are active. */
			      "activeCaptionText", 0xFFFFFF, /* Text color for text in captions (title bars). */
			    "activeCaptionBorder", 0x026AFE, /* Border color for caption (title bar) window borders. */
			        "inactiveCaption", 0x7999DE, /* Color for captions (title bars) when not active. */
			    "inactiveCaptionText", 0xDCEBFE, /* Text color for text in inactive captions (title bars). */
			  "inactiveCaptionBorder", 0x7999DE, /* Border color for inactive caption (title bar) window borders. */
				        
				         "window", 0x84ACDF,//0xBCD3F2,//0x84ACDF,//XP = 0xF1F1EB, /* Default color for the interior of windows */
				   "windowBorder", 0x002D86, /* ??? */
				     "windowText", 0xFFFFFF, /* ??? */
			         "modalColor", 0xFFFFFF,
			  
					   "menu", 0xE8E9EA, /* Background color for menus */
				       "menuText", 0xFFFFFF, /* Text color for menus  */
					   
					   "text", 0xE8E9EA, /* Text background color */
				       "textText", 0x575B61, /* Text foreground color */
				  "textHighlight", 0xE8E9EA, /* Text background color when selected */
			      "textHighlightText", 0xFFFFFF, /* Text color when selected */
			       "textInactiveText", 0xCBCED0, /* Text color when disabled */
				        
				        "control", 0x84ACDF,//0x9EBEF5,//0xBCD3F2,//0x84ACDF,//XP = 0xF1F1EB  /* Default color for controls (buttons, sliders, etc) */
				  "controlBorder", 0x3A62A0,//for XP = 0x003C74,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				  "controlTextFieldBorder",0x7F9DB9, // Border for input text fields combos' text area etc
				    "controlText", 0x3A62A0, /* Default color for text in controls */
			       "controlHighlight", 0xDDECFE, /* Specular highlight (opposite of the shadow) */
			     "controlLtHighlight", 0xFFFFFF,// for XP = 0xFFFFFF, /* Highlight color for controls */
				  "controlShadow", 0x84ACDF,//0xAEB2B6, /* Shadow color for controls */
			        "controlDkShadow", 0x001DA0, /* Dark shadow color for controls */
				      "scrollbar", 0xF1F1EB /* Scrollbar background (usually the "track") */
			];
					
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
					
	}
	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
		
	    // *** Separator
	    var comDefaults:Array = [
		    "Separator.background", table.get("controlLtHighlight"),
		    "Separator.foreground", table.get("controlShadow"),
	    	"Separator.opaque", false,
	    	"Separator.focusable", false
	    ];
	    table.putDefaults(comDefaults);
		
	   // *** JButton
	   comDefaults = [
	   		
	   		"Button.borderColor", table.get("controlBorder"),
	    	"Button.background", table.get("control"),
		    "Button.border", com.f1sr.aswing.plaf.office2003.border.ButtonBorder
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ToggleButton
	    comDefaults = [
		    "ToggleButton.border", com.f1sr.aswing.plaf.office2003.border.ButtonBorder
		    
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** RadioButton
	    comDefaults = [
		    "RadioButton.icon", com.f1sr.aswing.plaf.office2003.icon.RadioButtonIcon];
	    table.putDefaults(comDefaults);	    
	    	    
	    // *** CheckBox
	    comDefaults = [
		    "CheckBox.icon", com.f1sr.aswing.plaf.office2003.icon.CheckBoxIcon];
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
	    	"ComboBox.border", com.f1sr.aswing.plaf.office2003.border.ComboBoxBorder
	    	
	    ];
	    table.putDefaults(comDefaults);

	    
	    // *** List
	    comDefaults = [
		    "List.background", table.get("controlLtHighlight"), //table.get("text"),
		    "List.foreground", table.get("controlText"), //table.get("controlText"),
		    "List.itemBackground",  table.get("controlLtHighlight"),
		    "List.itemForeground", table.get("controlText"),
	        "List.itemSelectedBackground", table.get("controlText"),//new ASColorUIResource(0x6CA401),
		    "List.itemSelectedForeground", table.get("controlLtHighlight"),
		    "List.selectionBackground", table.get("controlText"),
		    "List.selectionForeground", table.get("textHighlightText"),		    
	    	"List.border",undefined
	    	
	    	];
	    table.putDefaults(comDefaults);		    
	    
	     // *** TextField
	    comDefaults = [
	    	"TextField.background", table.get("controlLtHighlight"),
	    	"TextField.foreground", table.get("controlText"),
        	"TextField.shadow", table.get("controlShadow"),
        	"TextField.darkShadow", table.get("controlDkShadow"),
        	"TextField.light", table.get("textHighlight"),
        	"TextField.highlight", table.get("textHighlightText"),
        	"TextField.border",com.f1sr.aswing.plaf.office2003.border.TextFieldBorder
        	
        	];
	    table.putDefaults(comDefaults);
	    
	     // *** TextArea
	    comDefaults = [
	    	"TextArea.background", table.get("controlLtHighlight"),
	    	"TextArea.foreground", table.get("controlText"),
        	"TextArea.shadow", table.get("controlShadow"),
        	"TextArea.darkShadow", table.get("controlDkShadow"),
        	"TextArea.light", table.get("inactiveCaption"),
        	"TextArea.highlight", table.get("controlDkShadow"),
        	"TextArea.border",com.f1sr.aswing.plaf.office2003.border.TextFieldBorder

        	];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollBar
	    comDefaults = [
	    	"ScrollBar.background", table.get("controlLtHighlight"),
	    	"ScrollBar.foreground", table.get("controlText"),
    		"ScrollBar.opaque", true,  
    		"ScrollBar.focusable", true,  
	   		"ScrollBar.shadow", table.getColor("controlShadow"),
        	"ScrollBar.darkShadow", table.getColor("controlDkShadow"),
        	"ScrollBar.light", table.getColor("controlHighlight"),
        	"ScrollBar.highlight", table.getColor("controlLtHighlight"),
        	"ScrollBar.font", table.getFont("controlFont"),
	    	"ScrollBar.border", undefined,
		    "ScrollBar.thumb", table.get("control"),
		    "ScrollBar.thumbShadow", table.get("controlShadow"),
		    "ScrollBar.thumbDarkShadow", table.get("controlDkShadow"),
		    "ScrollBar.thumbHighlight", table.get("controlLtHighlight")
		     
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollPane
	    comDefaults = [
        	"ScrollPane.darkShadow", table.getColor("controlDkShadow"),
    		"ScrollPane.opaque", false,  
    		"ScrollPane.focusable", true  
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** Panel
	    comDefaults = [	   
	    	"Panel.background", table.get("controlHighlight"),// table.get("control"),
	    	"Panel.foreground", table.get("controlText"),
	    	"Panel.light", table.get("controlHighlight"),
	    	"Panel.highlight",table.get("controlLtHighlight"),
	    	"Panel.shadow",table.get("controlShadow"),
	    	"Panel.border", undefined//com.f1sr.aswing.plaf.office2003.border.PanelBorder
	    	];
	    table.putDefaults(comDefaults);
	    
	   // *** JTabbedPane
	    comDefaults = [
	    	"TabbedPane.background", table.get("control"),
	    	"TabbedPane.foreground", table.get("controlText"),
	    	"TabbedPane.opaque", false,  
	    	"TabbedPane.focusable", true, 

	       	"TabbedPane.shadow", table.get("controlShadow"),
	        "TabbedPane.darkShadow", table.get("controlText"),
	        "TabbedPane.light", table.get("controlHighlight"),
	        "TabbedPane.highlight",table.get("controlLtHighlight"),
        	       		
        	"TabbedPane.font", table.getFont("controlFont"),
			"TabbedPane.tabMargin", new InsetsUIResource(1, 1, 1, 1),
			"TabbedPane.baseLineThickness", 8,
			"TabbedPane.maxTabWidth", 1000,
			"TabbedPane.border", null
			
			];
	    table.putDefaults(comDefaults);
	    
	    // *** Window
	    comDefaults = [	   
		    "Window.background", table.get("window"),
		    "Window.foreground",table.get("windowText"),
	    	"Window.opaque", true,  
	    	"Window.focusable", true,
	    	"Window.modalColor", new ASColorUIResource(0xFFFFFF,0),
		    "Window.contentPaneBorder", undefined
	    ];
	    table.putDefaults(comDefaults);
	    	   
	    // *** Frame
	    comDefaults = [	   
	    	"Frame.backround", table.get("control"),
	    	"Frame.foreground", table.get("windowText"),
	    	"Frame.titleBarUI", com.f1sr.aswing.plaf.office2003.frame.Office2003TitleBarUI,
	    	"Frame.border", com.f1sr.aswing.plaf.office2003.border.FrameBorder
	    		   
	    ];
	    table.putDefaults(comDefaults);
	    
  
	}	
	
	
	private function initSystemFontDefaults(table:UIDefaults):Void{
		var defaultSystemFonts:Array = [
				"systemFont", new ASFontUIResource("Arial", 11), 
				"menuFont", new ASFontUIResource("Arial", 11), 
				"controlFont", new ASFontUIResource("Arial", 12), 
				"windowFont", new ASFontUIResource("Arial", 12)
		];
		table.putDefaults(defaultSystemFonts);
	}
	
}