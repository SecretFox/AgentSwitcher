/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlConstants;
import GUI.fox.aswing.awml.border.BevelBorderParser;
import GUI.fox.aswing.awml.border.EmptyBorderParser;
import GUI.fox.aswing.awml.border.LineBorderParser;
import GUI.fox.aswing.awml.border.NoBorderParser;
import GUI.fox.aswing.awml.border.SideLineBorderParser;
import GUI.fox.aswing.awml.border.SimpleTitledBorderParser;
import GUI.fox.aswing.awml.border.TitledBorderParser;
import GUI.fox.aswing.awml.common.BoundsParser;
import GUI.fox.aswing.awml.common.ColorParser;
import GUI.fox.aswing.awml.common.FontParser;
import GUI.fox.aswing.awml.common.InsetsParser;
import GUI.fox.aswing.awml.common.TextFormatParser;
import GUI.fox.aswing.awml.component.AccordionParser;
import GUI.fox.aswing.awml.component.AdjusterParser;
import GUI.fox.aswing.awml.component.AttachPaneParser;
import GUI.fox.aswing.awml.component.BoxParser;
import GUI.fox.aswing.awml.component.ButtonParser;
import GUI.fox.aswing.awml.component.CheckBoxMenuItemParser;
import GUI.fox.aswing.awml.component.CheckBoxParser;
import GUI.fox.aswing.awml.component.ColorChooserParser;
import GUI.fox.aswing.awml.component.ColorMixerParser;
import GUI.fox.aswing.awml.component.ColorSwatchesParser;
import GUI.fox.aswing.awml.component.ComboBoxParser;
import GUI.fox.aswing.awml.component.FrameParser;
import GUI.fox.aswing.awml.component.LabelParser;
import GUI.fox.aswing.awml.component.list.ListItemParser;
import GUI.fox.aswing.awml.component.list.ListItemsParser;
import GUI.fox.aswing.awml.component.ListParser;
import GUI.fox.aswing.awml.component.listtree.ListTreeItemParser;
import GUI.fox.aswing.awml.component.listtree.ListTreeItemsParser;
import GUI.fox.aswing.awml.component.ListTreeParser;
import GUI.fox.aswing.awml.component.LoadPaneParser;
import GUI.fox.aswing.awml.component.MCPanelParser;
import GUI.fox.aswing.awml.component.MenuBarParser;
import GUI.fox.aswing.awml.component.MenuItemParser;
import GUI.fox.aswing.awml.component.MenuParser;
import GUI.fox.aswing.awml.component.PanelParser;
import GUI.fox.aswing.awml.component.PopupMenuParser;
import GUI.fox.aswing.awml.component.PopupParser;
import GUI.fox.aswing.awml.component.ProgressBarParser;
import GUI.fox.aswing.awml.component.RadioButtonMenuItemParser;
import GUI.fox.aswing.awml.component.RadioButtonParser;
import GUI.fox.aswing.awml.component.ScrollBarParser;
import GUI.fox.aswing.awml.component.ScrollPaneParser;
import GUI.fox.aswing.awml.component.SeparatorParser;
import GUI.fox.aswing.awml.component.SliderParser;
import GUI.fox.aswing.awml.component.SoftBoxParser;
import GUI.fox.aswing.awml.component.SpacerParser;
import GUI.fox.aswing.awml.component.split.SplitComponentParser;
import GUI.fox.aswing.awml.component.SplitPaneParser;
import GUI.fox.aswing.awml.component.tab.TabParser;
import GUI.fox.aswing.awml.component.TabbedPaneParser;
import GUI.fox.aswing.awml.component.table.TableCellParser;
import GUI.fox.aswing.awml.component.table.TableColumnParser;
import GUI.fox.aswing.awml.component.table.TableColumnsParser;
import GUI.fox.aswing.awml.component.table.TableRowParser;
import GUI.fox.aswing.awml.component.table.TableRowsParser;
import GUI.fox.aswing.awml.component.TableParser;
import GUI.fox.aswing.awml.component.text.TextCSSParser;
import GUI.fox.aswing.awml.component.text.TextParser;
import GUI.fox.aswing.awml.component.TextAreaParser;
import GUI.fox.aswing.awml.component.TextFieldParser;
import GUI.fox.aswing.awml.component.ToggleButtonParser;
import GUI.fox.aswing.awml.component.ToolBarParser;
import GUI.fox.aswing.awml.component.tree.TreeNodeParser;
import GUI.fox.aswing.awml.component.tree.TreeRootParser;
import GUI.fox.aswing.awml.component.TreeParser;
import GUI.fox.aswing.awml.component.ViewportParser;
import GUI.fox.aswing.awml.component.WindowParser;
import GUI.fox.aswing.awml.icon.AttachIconParser;
import GUI.fox.aswing.awml.icon.IconWrapperParser;
import GUI.fox.aswing.awml.icon.LoadIconParser;
import GUI.fox.aswing.awml.icon.OffsetIconParser;
import GUI.fox.aswing.awml.layout.AlignLayoutParser;
import GUI.fox.aswing.awml.layout.BorderLayoutParser;
import GUI.fox.aswing.awml.layout.BoxLayoutParser;
import GUI.fox.aswing.awml.layout.CenterLayoutParser;
import GUI.fox.aswing.awml.layout.EmptyLayoutParser;
import GUI.fox.aswing.awml.layout.FlowLayoutParser;
import GUI.fox.aswing.awml.layout.GridLayoutParser;
import GUI.fox.aswing.awml.layout.SoftBoxLayoutParser;
import GUI.fox.aswing.awml.reflection.ArgumentsParser;
import GUI.fox.aswing.awml.reflection.ArrayParser;
import GUI.fox.aswing.awml.reflection.ComponentParser;
import GUI.fox.aswing.awml.reflection.EventParser;
import GUI.fox.aswing.awml.reflection.FormParser;
import GUI.fox.aswing.awml.reflection.InstanceParser;
import GUI.fox.aswing.awml.reflection.MethodParser;
import GUI.fox.aswing.awml.reflection.PropertyParser;
import GUI.fox.aswing.awml.reflection.ValueParser;
import GUI.fox.aswing.util.HashMap;

/**
 * Configures dependencies between AWML elements, objects and parsers. Provides 
 * routines to obtain required parsers. 
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.ParserFactory {
    
    /** Defines component parser type. */
    public static var COMPONENT:Number = AwmlConstants.TYPE_COMPONENT;

    /** Defines component wrapper parser type. */
    public static var COMPONENT_WRAPPER:Number = AwmlConstants.TYPE_COMPONENT_WRAPPER;
    
    /** Defines border parser type. */
    public static var BORDER:Number = AwmlConstants.TYPE_BORDER;
    
    /** Defines layout parser type. */
    public static var LAYOUT:Number = AwmlConstants.TYPE_LAYOUT;

    /** Defines menu item parser type. */
    public static var MENU_ITEM:Number = AwmlConstants.TYPE_MENU_ITEM;
    
    /** Defines icon parser type. */
    public static var ICON:Number = AwmlConstants.TYPE_ICON;
    
    /** Defines icon wrapper parser type. */
    public static var ICON_WRAPPER:Number = AwmlConstants.TYPE_ICON_WRAPPER;

    /** Defines reflection property value parser type. */
    public static var PROPERTY:Number = AwmlConstants.TYPE_PROPERTY;
    
    /** Defines reflection property value parser type. */
    public static var ARGUMENT:Number = AwmlConstants.TYPE_ARGUMENT;


    /** Singleton instance. */
    private static var instance:ParserFactory;
       
        
    /**
     * Creates singleton instance.
     * 
     * @return singleton instance.
     */
    private static function getInstance(Void):ParserFactory { 
        if (instance == null) {
            instance = new ParserFactory(); 
        }
        return instance;    
    }
    
    /**
     * Associates parser class with AWML node name.
     * 
     * @param parserName the AWML node name.
     * @param parserClass the parser class responsible for AWML node parsing. 
     * @param parserType the numeric representation of the parser's type. 
     * Parser's type can be multiple. Multiple types assembles from the
     * individual types using bitwise OR operator (<code>|</code>).
     * @see #COMPONENT 
     * @see #LAYOUT
     * @see #BORDER
     * @see #ICON
     * @see #ICON_WRAPPER
     */
    public static function put(parserName:String, parserClass:Function, parserType:Number):Void {
        if (parserClass == null || parserName == null || parserName == "") return;
        getInstance().addParser(parserName, parserClass, parserType);
    }

    /**
     * Gets parser instance by AWML node name.
     * 
     * @param parserName the AWML node name.
     * @return parser instance.
     */
    public static function get(parserName:String) {
        return getInstance().getParser(parserName);
    }
    
    /**
     * Checks if parser has specified type.
     * @param parserName the name of the parser
     * @param parserType the type of the parser to check 
     *  
     * @see #COMPONENT 
     * @see #LAYOUT
     * @see #BORDER
     * @see #ICON
     * @see #ICON_WRAPPER
     */
    public static function isTypeOf(parserName:String, parserType:Number):Boolean {
    	return Boolean(getInstance().parserTypes.get(parserName) & parserType);
    }  		


    /** Holds parser classes associated with parser names. */
    private var parserClasses:HashMap;
    
    /** Holds parser types associated with parser names. */
    private var parserTypes:HashMap;

    /** Holds parser instances associated with parser classes. */
    private var parserInstances:HashMap;


    /**
     * Private Constructor.
     */
    private function ParserFactory(Void) {
        parserClasses = new HashMap();
        parserTypes = new HashMap();
        parserInstances = new HashMap();
        
        // init parsers 
        addParser(AwmlConstants.NODE_FRAME, FrameParser, COMPONENT);
        addParser(AwmlConstants.NODE_WINDOW, WindowParser, COMPONENT);
        addParser(AwmlConstants.NODE_POPUP, PopupParser, COMPONENT);
        addParser(AwmlConstants.NODE_MC_PANEL, MCPanelParser, COMPONENT);
        addParser(AwmlConstants.NODE_POPUP_MENU, PopupMenuParser, COMPONENT);
        
        addParser(AwmlConstants.NODE_TEXT_AREA, TextAreaParser, COMPONENT);
        addParser(AwmlConstants.NODE_TEXT_FIELD, TextFieldParser, COMPONENT);
        addParser(AwmlConstants.NODE_SEPARATOR, SeparatorParser, COMPONENT | MENU_ITEM);
        addParser(AwmlConstants.NODE_PROGRESS_BAR, ProgressBarParser, COMPONENT);
        addParser(AwmlConstants.NODE_LABEL, LabelParser, COMPONENT);
        addParser(AwmlConstants.NODE_BUTTON, ButtonParser, COMPONENT);
        addParser(AwmlConstants.NODE_TOGGLE_BUTTON, ToggleButtonParser, COMPONENT);
        addParser(AwmlConstants.NODE_CHECK_BOX, CheckBoxParser, COMPONENT);
        addParser(AwmlConstants.NODE_RADIO_BUTTON, RadioButtonParser, COMPONENT);
        addParser(AwmlConstants.NODE_SCROLL_BAR, ScrollBarParser, COMPONENT);
        addParser(AwmlConstants.NODE_SLIDER, SliderParser, COMPONENT);
        addParser(AwmlConstants.NODE_LIST, ListParser, COMPONENT);
        addParser(AwmlConstants.NODE_COMBO_BOX, ComboBoxParser, COMPONENT);
        addParser(AwmlConstants.NODE_VIEW_PORT, ViewportParser, COMPONENT);
        addParser(AwmlConstants.NODE_SCROLL_PANE, ScrollPaneParser, COMPONENT);
        addParser(AwmlConstants.NODE_TABLE, TableParser, COMPONENT);
        addParser(AwmlConstants.NODE_TREE, TreeParser, COMPONENT);
        addParser(AwmlConstants.NODE_LIST_TREE, ListTreeParser, COMPONENT);
        addParser(AwmlConstants.NODE_ADJUSTER, AdjusterParser, COMPONENT);
        addParser(AwmlConstants.NODE_SPACER, SpacerParser, COMPONENT);
        addParser(AwmlConstants.NODE_SPLIT_PANE, SplitPaneParser, COMPONENT);
        addParser(AwmlConstants.NODE_MENU_BAR, MenuBarParser, COMPONENT);
        
        addParser(AwmlConstants.NODE_PANEL, PanelParser, COMPONENT);
        addParser(AwmlConstants.NODE_BOX, BoxParser, COMPONENT);
        addParser(AwmlConstants.NODE_SOFT_BOX, SoftBoxParser, COMPONENT);
        addParser(AwmlConstants.NODE_TOOL_BAR, ToolBarParser, COMPONENT);
        addParser(AwmlConstants.NODE_ATTACH_PANE, AttachPaneParser, COMPONENT);
        addParser(AwmlConstants.NODE_LOAD_PANE, LoadPaneParser, COMPONENT);
        
        addParser(AwmlConstants.NODE_ACCORDION, AccordionParser, COMPONENT);
        addParser(AwmlConstants.NODE_TABBED_PANE, TabbedPaneParser, COMPONENT);
        
        addParser(AwmlConstants.NODE_COLOR_SWATCHES, ColorSwatchesParser, COMPONENT);
        addParser(AwmlConstants.NODE_COLOR_MIXER, ColorMixerParser, COMPONENT);
        addParser(AwmlConstants.NODE_COLOR_CHOOSER, ColorChooserParser, COMPONENT);
        
        addParser(AwmlConstants.NODE_MENU, MenuParser, MENU_ITEM);
        addParser(AwmlConstants.NODE_MENU_ITEM, MenuItemParser, MENU_ITEM);
        addParser(AwmlConstants.NODE_CHECK_BOX_MENU_ITEM, CheckBoxMenuItemParser, MENU_ITEM);
        addParser(AwmlConstants.NODE_RADIO_BUTTON_MENU_ITEM, RadioButtonMenuItemParser, MENU_ITEM);
        
        addParser(AwmlConstants.NODE_EMPTY_LAYOUT, EmptyLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_CENTER_LAYOUT, CenterLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_ALIGN_LAYOUT, AlignLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_FLOW_LAYOUT, FlowLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_BOX_LAYOUT, BoxLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_SOFT_BOX_LAYOUT, SoftBoxLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_GRID_LAYOUT, GridLayoutParser, LAYOUT);
        addParser(AwmlConstants.NODE_BORDER_LAYOUT, BorderLayoutParser, LAYOUT);
        
        addParser(AwmlConstants.NODE_BEVEL_BORDER, BevelBorderParser, BORDER);
        addParser(AwmlConstants.NODE_EMPTY_BORDER, EmptyBorderParser, BORDER);
        addParser(AwmlConstants.NODE_LINE_BORDER, LineBorderParser, BORDER);
        addParser(AwmlConstants.NODE_SIDE_LINE_BORDER, SideLineBorderParser, BORDER);
        addParser(AwmlConstants.NODE_TITLED_BORDER, TitledBorderParser, BORDER);
        addParser(AwmlConstants.NODE_SIMPLE_TITLED_BORDER, SimpleTitledBorderParser, BORDER);
        addParser(AwmlConstants.NODE_NO_BORDER, NoBorderParser, BORDER);
        
        addParser(AwmlConstants.NODE_MARGINS, InsetsParser);
        addParser(AwmlConstants.NODE_INSETS, InsetsParser);
        addParser(AwmlConstants.NODE_MAXIMIZED_BOUNDS, BoundsParser);
        addParser(AwmlConstants.NODE_CLIP_BOUNDS, BoundsParser);
        addParser(AwmlConstants.NODE_FONT, FontParser);
        addParser(AwmlConstants.NODE_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_BACKGROUND, ColorParser);
        addParser(AwmlConstants.NODE_FOREGROUND, ColorParser);
        addParser(AwmlConstants.NODE_HIGHLIGHT_INNER_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_HIGHLIGHT_OUTER_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_SHADOW_INNER_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_SHADOW_OUTER_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_LINE_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_LINE_LIGHT_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_TEXT_FORMAT, TextFormatParser);
        addParser(AwmlConstants.NODE_SELECTION_BACKGROUND, ColorParser);
        addParser(AwmlConstants.NODE_SELECTION_FOREGROUND, ColorParser);
        addParser(AwmlConstants.NODE_GRID_COLOR, ColorParser);
        addParser(AwmlConstants.NODE_SELECTED_COLOR, ColorParser);
        
        addParser(AwmlConstants.NODE_LIST_ITEMS, ListItemsParser);
        addParser(AwmlConstants.NODE_LIST_ITEM, ListItemParser);

        addParser(AwmlConstants.NODE_LIST_TREE_ITEMS, ListTreeItemsParser);
        addParser(AwmlConstants.NODE_LIST_TREE_ITEM, ListTreeItemParser);

        addParser(AwmlConstants.NODE_TREE_ROOT, TreeRootParser);
        addParser(AwmlConstants.NODE_TREE_NODE, TreeNodeParser);

        addParser(AwmlConstants.NODE_TABLE_COLUMNS, TableColumnsParser);
        addParser(AwmlConstants.NODE_TABLE_COLUMN, TableColumnParser);
        addParser(AwmlConstants.NODE_TABLE_ROWS, TableRowsParser);
        addParser(AwmlConstants.NODE_TABLE_ROW, TableRowParser);
        addParser(AwmlConstants.NODE_TABLE_CELL, TableCellParser);
        
        addParser(AwmlConstants.NODE_TAB, TabParser);
        
        addParser(AwmlConstants.NODE_TOP_COMPONENT, SplitComponentParser, COMPONENT_WRAPPER);
        addParser(AwmlConstants.NODE_BOTTOM_COMPONENT, SplitComponentParser, COMPONENT_WRAPPER);
        addParser(AwmlConstants.NODE_LEFT_COMPONENT, SplitComponentParser, COMPONENT_WRAPPER);
        addParser(AwmlConstants.NODE_RIGHT_COMPONENT, SplitComponentParser, COMPONENT_WRAPPER);
        
        addParser(AwmlConstants.NODE_TEXT, TextParser);
        addParser(AwmlConstants.NODE_TEXT_CSS, TextCSSParser);
        
        addParser(AwmlConstants.NODE_ATTACH_ICON, AttachIconParser, ICON);
        addParser(AwmlConstants.NODE_LOAD_ICON, LoadIconParser, ICON);
        addParser(AwmlConstants.NODE_OFFSET_ICON, OffsetIconParser, ICON);
        
        addParser(AwmlConstants.NODE_ICON, IconWrapperParser, ICON_WRAPPER);
        addParser(AwmlConstants.NODE_SELECTED_ICON, IconWrapperParser, ICON_WRAPPER);
        addParser(AwmlConstants.NODE_PRESSED_ICON, IconWrapperParser, ICON_WRAPPER);
        addParser(AwmlConstants.NODE_DISABLED_ICON, IconWrapperParser, ICON_WRAPPER);
        addParser(AwmlConstants.NODE_DISABLED_SELECTED_ICON, IconWrapperParser, ICON_WRAPPER);
        addParser(AwmlConstants.NODE_ROLL_OVER_ICON, IconWrapperParser, ICON_WRAPPER);
        addParser(AwmlConstants.NODE_ROLL_OVER_SELECTED_ICON, IconWrapperParser, ICON_WRAPPER);

		// for JScrollPane        
        addParser(AwmlConstants.NODE_SCROLL_VIEW_PORT, ViewportParser);
        
        addParser(AwmlConstants.NODE_FORM, FormParser, COMPONENT);
        addParser(AwmlConstants.NODE_COMPONENT, ComponentParser, COMPONENT | PROPERTY | ARGUMENT);
        addParser(AwmlConstants.NODE_PROPERTY, PropertyParser);
        addParser(AwmlConstants.NODE_METHOD, MethodParser);
        addParser(AwmlConstants.NODE_EVENT, EventParser);
        addParser(AwmlConstants.NODE_CONSTRUCTOR, ArgumentsParser);
        addParser(AwmlConstants.NODE_ARGUMENTS, ArgumentsParser);
        addParser(AwmlConstants.NODE_VALUE, ValueParser, PROPERTY | ARGUMENT);
        addParser(AwmlConstants.NODE_INSTANCE, InstanceParser, PROPERTY | ARGUMENT);
        addParser(AwmlConstants.NODE_ARRAY, ArrayParser, PROPERTY | ARGUMENT);
    }

    private function addParser(parserName:String, parserClass:Function, parserType:Number):Void {
        parserClasses.put(parserName, parserClass);
        parserTypes.put(parserName, parserType);
    }

    private function getParser(parserName:String) {
    	var parserClass:Function = parserClasses.get(parserName); 
        if (parserClass == null) return null;
        
        var parserInstance = parserInstances.get(parserClass);
        if (parserInstance == null) {
            parserInstance = new parserClass();
            parserInstances.put(parserClass, parserInstance);
        }   
        
        return parserInstance;
    }

}
