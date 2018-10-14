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

class com.f1sr.aswing.plaf.hightec.HightecLAF extends BasicLookAndFeel
{
	public function HightecLAF(){
		super();
	}
	
	
	private function initClassDefaults(table:UIDefaults):Void{
		super.initClassDefaults(table);
		
		var uiDefaults:Array = [
		   "ButtonUI", com.f1sr.aswing.plaf.hightec.ButtonUI,
			"ToggleButtonUI", com.f1sr.aswing.plaf.hightec.ToggleButtonUI,
			"ComboBoxUI",com.f1sr.aswing.plaf.hightec.ComboBoxUI,
			
			"TextFieldUI",com.f1sr.aswing.plaf.hightec.TextFieldUI,
        	"TextAreaUI",com.f1sr.aswing.plaf.hightec.TextAreaUI,
        	"ScrollBarUI",com.f1sr.aswing.plaf.hightec.ScrollBarUI,
        	"TabbedPaneUI", com.f1sr.aswing.plaf.hightec.TabbedPaneUI,
        	//"WindowUI",com.f1sr.aswing.plaf.hightec.WindowUI,	
			"FrameUI",com.f1sr.aswing.plaf.hightec.FrameUI  
		];
		table.putDefaults(uiDefaults);
	}
	
	
	private function initSystemColorDefaults(table:UIDefaults):Void{
			var defaultSystemColors:Array = [
				  "activeCaption", 0x00BBFF, /* Color for captions (title bars) when they are active. */
			      "activeCaptionText", 0x575B61, /* Text color for text in captions (title bars). */
			    "activeCaptionBorder", 0xAEB2B6, /* Border color for caption (title bar) window borders. */
			        "inactiveCaption", 0xE8E9EA, /* Color for captions (title bars) when not active. */
			    "inactiveCaptionText", 0xC0C0C0, /* Text color for text in inactive captions (title bars). */
			  "inactiveCaptionBorder", 0xE8E9EA, /* Border color for inactive caption (title bar) window borders. */
				        
				         "window", 0x575B61, /* Default color for the interior of windows */
				   "windowBorder", 0x0000FF, /* ??? */
				     "windowText", 0x575B61, /* ??? */
			         "modalColor", 0xFFFFFF,
			  
					   "menu", 0xE8E9EA, /* Background color for menus */
				       "menuText", 0x575B61, /* Text color for menus  */
					   
					   "text", 0xE8E9EA, /* Text background color */
				       "textText", 0x575B61, /* Text foreground color */
				  "textHighlight", 0xE8E9EA, /* Text background color when selected */
			      "textHighlightText", 0xFFFFFF, /* Text color when selected */
			       "textInactiveText", 0xCBCED0, /* Text color when disabled */
				        
				        "control", 0xCBCED0,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				    "controlText", 0x575B61, /* Default color for text in controls */
			       "controlHighlight", 0xE8E9EA, /* Specular highlight (opposite of the shadow) */
			     "controlLtHighlight", 0xFFFFFF, /* Highlight color for controls */
				  "controlShadow", 0x82888D,//0xAEB2B6, /* Shadow color for controls */
			        "controlDkShadow", 0x575B61, /* Dark shadow color for controls */
				      "scrollbar", 0xCBCED0 /* Scrollbar background (usually the "track") */
			];
					
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
					
	}
	
	private function initComponentDefaults(table:UIDefaults):Void{
		super.initComponentDefaults(table);
		
	    // *** Separator
	    var comDefaults:Array = [
		    "Separator.background", table.get("controlShadow"),
		    "Separator.foreground", table.get("controlLtHighlight"),
	    	"Separator.opaque", false,
	    	"Separator.focusable", false
	    ];
	    table.putDefaults(comDefaults);
		
	   // *** JButton
	   comDefaults = [
	   		
	    	"Button.background", table.get("control"),
		    "Button.border", com.f1sr.aswing.plaf.hightec.border.ButtonBorder
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ToggleButton
	    comDefaults = [
		    "ToggleButton.border", com.f1sr.aswing.plaf.hightec.border.ButtonBorder
		    
		    ];
	    table.putDefaults(comDefaults);
	    
	    // *** RadioButton
	    comDefaults = [
		    "RadioButton.icon", com.f1sr.aswing.plaf.hightec.icon.RadioButtonIcon];
	    table.putDefaults(comDefaults);	    
	    	    
	    // *** CheckBox
	    comDefaults = [
		    "CheckBox.icon", com.f1sr.aswing.plaf.hightec.icon.CheckBoxIcon];
	    table.putDefaults(comDefaults);

	    // *** ComboBox
	    comDefaults = [
	    	
	    	"ComboBox.background", undefined,//table.get("control"),
	   		"ComboBox.foreground", undefined,//table.get("controlText"),
    		"ComboBox.opaque", true,
    		"ComboBox.focusable", false,
    		"ComboBox.shadow", table.getColor("controlShadow"),        
    		"ComboBox.darkShadow", table.getColor("controlDkShadow"),        
    		"ComboBox.light", table.getColor("controlHighlight"),       
   			"ComboBox.highlight", table.getColor("controlLtHighlight"),
	    	"ComboBox.border", com.f1sr.aswing.plaf.hightec.border.ComboBoxBorder
	    	
	    ];
	    table.putDefaults(comDefaults);

	    
	    // *** List
	    comDefaults = [
		    "List.background", table.get("text"),
		    "List.foreground", table.get("controlText"),
		    "List.itemBackground", table.get("text"),
		    "List.itemForeground", table.get("controlText"),
	        "List.itemSelectedBackground", table.get("controlShadow"),//new ASColorUIResource(0x6CA401),
		    "List.itemSelectedForeground", table.get("text"),
		    "List.selectionBackground", table.get("controlShadow"),
		    "List.selectionForeground", table.get("control"),		    
	    	"List.border",undefined
	    	
	    	];
	    table.putDefaults(comDefaults);		    
	    
	     // *** TextField
	    comDefaults = [
	    	"TextField.background", table.get("text"),
	    	"TextField.foreground", table.get("controlText"),
        	"TextField.shadow", table.get("controlShadow"),
        	"TextField.darkShadow", table.get("controlDkShadow"),
        	"TextField.light", table.get("textHighlight"),
        	"TextField.highlight", table.get("textHighlightText"),
        	"TextField.border",com.f1sr.aswing.plaf.hightec.border.TextFieldBorder
        	
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
        	"TextArea.border",com.f1sr.aswing.plaf.hightec.border.TextFieldBorder

        	];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollBar
	    comDefaults = [
	    	"ScrollBar.background", table.get("controlHighlight"),
	    	"ScrollBar.foreground", table.get("controlText"),
    		"ScrollBar.opaque", true,  
    		"ScrollBar.focusable", true,  
	   		"ScrollBar.shadow", table.getColor("controlShadow"),
        	"ScrollBar.darkShadow", table.getColor("controlDkShadow"),
        	"ScrollBar.light", table.getColor("controlHighlight"),
        	"ScrollBar.highlight", table.getColor("controlLtHighlight"),
        	"ScrollBar.font", table.getFont("controlFont"),
	    	"ScrollBar.border", undefined,
		    "ScrollBar.thumb", table.get("controlHighlight"),
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
	    	"Panel.background", undefined //table.get("textHighlight")
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
		    "Window.background", table.get("control"),
		    "Window.foreground", table.get("controlText"),
	    	"Window.opaque", true,  
	    	"Window.focusable", true,
	    	"Window.modalColor", new ASColorUIResource(0xFFFFFF,0),
		    "Window.contentPaneBorder", undefined
	    ];
	    table.putDefaults(comDefaults);
	    	   
	    // *** Frame
	    comDefaults = [	   
	    	"Frame.backround", table.get("control"),
	    	"Frame.foreground", table.get("controlText"),
	    	"Frame.titleBarUI", com.f1sr.aswing.plaf.hightec.frame.HightecTitleBarUI,
	    	"Frame.border", com.f1sr.aswing.plaf.hightec.border.FrameBorder
	    		   
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