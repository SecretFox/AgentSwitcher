/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import GUI.fox.aswing.awml.AwmlNamespace;
import GUI.fox.aswing.awml.AwmlParser;
import GUI.fox.aswing.awml.ButtonGroupManager;
import GUI.fox.aswing.Box;
import GUI.fox.aswing.ButtonGroup;
import GUI.fox.aswing.Component;
import GUI.fox.aswing.Container;
import GUI.fox.aswing.JAccordion;
import GUI.fox.aswing.JAdjuster;
import GUI.fox.aswing.JAttachPane;
import GUI.fox.aswing.JButton;
import GUI.fox.aswing.JCheckBox;
import GUI.fox.aswing.JCheckBoxMenuItem;
import GUI.fox.aswing.JComboBox;
import GUI.fox.aswing.JFrame;
import GUI.fox.aswing.JLabel;
import GUI.fox.aswing.JList;
import GUI.fox.aswing.JListTree;
import GUI.fox.aswing.JLoadPane;
import GUI.fox.aswing.JMenu;
import GUI.fox.aswing.JMenuBar;
import GUI.fox.aswing.JMenuItem;
import GUI.fox.aswing.JPanel;
import GUI.fox.aswing.JPopup;
import GUI.fox.aswing.JPopupMenu;
import GUI.fox.aswing.JProgressBar;
import GUI.fox.aswing.JRadioButton;
import GUI.fox.aswing.JRadioButtonMenuItem;
import GUI.fox.aswing.JScrollBar;
import GUI.fox.aswing.JScrollPane;
import GUI.fox.aswing.JSeparator;
import GUI.fox.aswing.JSlider;
import GUI.fox.aswing.JSpacer;
import GUI.fox.aswing.JSplitPane;
import GUI.fox.aswing.JTabbedPane;
import GUI.fox.aswing.JTable;
import GUI.fox.aswing.JTextArea;
import GUI.fox.aswing.JTextField;
import GUI.fox.aswing.JToggleButton;
import GUI.fox.aswing.JToolBar;
import GUI.fox.aswing.JTree;
import GUI.fox.aswing.JViewport;
import GUI.fox.aswing.JWindow;
import GUI.fox.aswing.MCPanel;
import GUI.fox.aswing.SoftBox;
import GUI.fox.aswing.util.HashMap;

/**
 * Privides public API allowed to access components created using AWML.
 * 
 * @author Igor Sadovskiy
 */
class GUI.fox.aswing.awml.AwmlManager {
    
	/** 
	 * New component with the existed ID will be appended. Existed component 
	 * with the same ID will stay. 
	 */
	public static var STRATEGY_APPEND:Number = AwmlParser.STRATEGY_APPEND;
	/**
	 * New component with the existed ID will replace old one. Old one will be 
	 * destroyed.
	 */
	public static var STRATEGY_REPLACE:Number = AwmlParser.STRATEGY_REPLACE;
	/**
	 * New component with the existed ID will be ignored. 
	 */
	public static var STRATEGY_IGNORE:Number = AwmlParser.STRATEGY_IGNORE; 
	/**
	 * In new component will have already existed ID Exception will be thrown. 
	 */
	public static var STRATEGY_EXCEPTION:Number = AwmlParser.STRATEGY_EXCEPTION; 
    
    
    /** Root namespace */
    private static var rootNamespace:AwmlNamespace;
    
    
    /**
     * Initializes and returns root namespace.
     * 
     * @return the root namespace 
     */
    public static function getRootNamespace():AwmlNamespace {
        if (rootNamespace == null) {
            rootNamespace = new AwmlNamespace();
        }
        return rootNamespace;   
    }

    /**
     * Searches for the namespace with the specified {@code name}. If {@code name} is
     * <code>undefined</code> returns root namespace.
     * 
     * @param name the name of the namespace to search
     * @return the found namespace ot <code>null</code>  
     */
    public static function getNamespace(name:String):AwmlNamespace {
        return (name != undefined) ? getRootNamespace().findNamespace(name) : getRootNamespace(); 
    }
    
	/**
	 * Sets new component parsing strategy.
	 * Specifies how parser should behave if new component
	 * has ID already existed in the namespace.
	 * 
	 * @param strategy the new strategy
	 * @see #STRATEGY_APPEND
	 * @see #STRATEGY_REPLACE
	 * @see #STRATEGY_IGNORE
	 * @see #STRATEGY_EXCEPTION
	 */
	public static function setComponentParsingStrategy(strategy:Number):Void {
		AwmlParser.setParsingStrategy(strategy);
	}

	/**
	 * Returns currently configured component parsing strategy.
	 * Specifies how parser should behave if new component
	 * has ID already existed in the namespace.
	 * 
	 * @return component add strategy 
	 * @see #STRATEGY_APPEND
	 * @see #STRATEGY_REPLACE
	 * @see #STRATEGY_IGNORE
	 * @see #STRATEGY_EXCEPTION
	 */
	public static function getComponentParsingStrategy(Void):Number {
		return AwmlParser.getParsingStrategy();	
	}
    
	/**
	 * Defines new property map.
	 * 
	 * @param properties the new property map
	 */
	public static function setProperties(properties:HashMap):Void {
		AwmlParser.setProperties(properties);
	}

	/**
	 * Returns currently configured property map.
	 * 
	 * @return the property map
	 */
	public static function getProperties(Void):HashMap {
		return AwmlParser.getProperties();
	}
    
    /**
     * getComponent(awmlID:String)<br>
     * getComponent(awmlID:String, namespaceName:String)<br>
     * <p>
     * Returns AWML {@link GUI.fox.aswing.Component} instance by <code>awmlID</code>
     * within the specified namespace. If <code>namespaceName</code> isn't 
     * specified, searches for the first entrty of the component with the
     * passed-in <code>awmlID</code> in the root and its children namespaces.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.Component} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.Component}
     */
    public static function getComponent(awmlID:String, namespaceName:String):Component {
    	var namespace:AwmlNamespace = getNamespace(namespaceName); 
        return (namespace != null) ? namespace.findComponent(awmlID) : null;
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.Container} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.Container} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.Container}
     */
    public static function getContainer(awmlID:String, namespaceName:String):Container {
        return Container(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JFrame} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JFrame} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JFrame}
     */
    public static function getFrame(awmlID:String, namespaceName:String):JFrame {
        return JFrame(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JWindow} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JWindow} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JWindow}
     */
    public static function getWindow(awmlID:String, namespaceName:String):JWindow {
        return JWindow(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JPopup} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JPopup} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JPopup}
     */
    public static function getPopup(awmlID:String, namespaceName:String):JPopup {
        return JPopup(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.MCPanel} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.MCPanel} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.MCPanel}
     */
    public static function getMCPanel(awmlID:String, namespaceName:String):MCPanel {
        return MCPanel(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JPopupMenu} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JPopupMenu} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JPopupMenu}
     */
    public static function getPopupMenu(awmlID:String, namespaceName:String):JPopupMenu {
        return JPopupMenu(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JTextField} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JTextField} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JTextField}
     */
    public static function getTextField(awmlID:String, namespaceName:String):JTextField {
        return JTextField(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JTextArea} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JTextArea} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JTextArea}
     */
    public static function getTextArea(awmlID:String, namespaceName:String):JTextArea {
        return JTextArea(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JSeparator} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JSeparator} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JSeparator}
     */
    public static function getSeparator(awmlID:String, namespaceName:String):JSeparator {
        return JSeparator(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JProgressBar} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JProgressBar} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JProgressBar}
     */
    public static function getProgressBar(awmlID:String, namespaceName:String):JProgressBar {
        return JProgressBar(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JLabel} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JLabel} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JLabel}
     */
    public static function getLabel(awmlID:String, namespaceName:String):JLabel {
        return JLabel(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JButton} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JButton} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JButton}
     */
    public static function getButton(awmlID:String, namespaceName:String):JButton {
        return JButton(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JToggleButton} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JToggleButton} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JToggleButton}
     */
    public static function getToggleButton(awmlID:String, namespaceName:String):JToggleButton {
        return JToggleButton(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JCheckBox} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JCheckBox} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JCheckBox}
     */
    public static function getCheckBox(awmlID:String, namespaceName:String):JCheckBox {
        return JCheckBox(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JRadioButton} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JRadioButton} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JRadioButton}
     */
    public static function getRadioButton(awmlID:String, namespaceName:String):JRadioButton {
        return JRadioButton(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JPanel} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JPanel} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JPanel}
     */
    public static function getPanel(awmlID:String, namespaceName:String):JPanel {
        return JPanel(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.Box} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.Box} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.Box}
     */
    public static function getBox(awmlID:String, namespaceName:String):Box {
        return Box(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.SoftBox} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.SoftBox} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.SoftBox}
     */
    public static function getSoftBox(awmlID:String, namespaceName:String):SoftBox {
        return SoftBox(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JToolBar} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JToolBar} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JToolBar}
     */
    public static function getToolBar(awmlID:String, namespaceName:String):JToolBar {
        return JToolBar(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JScrollBar} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JScrollBar} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JScrollBar}
     */
    public static function getScrollBar(awmlID:String, namespaceName:String):JScrollBar {
        return JScrollBar(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JSlider} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JSlider} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JSlider}
     */
    public static function getSlider(awmlID:String, namespaceName:String):JSlider {
        return JSlider(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JList} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JList} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JList}
     */
    public static function getList(awmlID:String, namespaceName:String):JList {
        return JList(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JComboBox} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JComboBox} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JComboBox}
     */
    public static function getComboBox(awmlID:String, namespaceName:String):JComboBox {
        return JComboBox(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JAccordion} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JAccordion} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JAccordion}
     */
    public static function getAccordion(awmlID:String, namespaceName:String):JAccordion {
        return JAccordion(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JTabbedPane} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JTabbedPane} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JTabbedPane}
     */
    public static function getTabbedPane(awmlID:String, namespaceName:String):JTabbedPane {
        return JTabbedPane(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JLoadPane} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JLoadPane} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JLoadPane}
     */
    public static function getLoadPane(awmlID:String, namespaceName:String):JLoadPane {
        return JLoadPane(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JAttachPane} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JAttachPane} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JAttachPane}
     */
    public static function getAttachPane(awmlID:String, namespaceName:String):JAttachPane {
        return JAttachPane(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JScrollPane} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JScrollPane} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JScrollPane}
     */
    public static function getScrollPane(awmlID:String, namespaceName:String):JScrollPane {
        return JScrollPane(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JViewport} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JViewport} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JViewport}
     */
    public static function getViewport(awmlID:String, namespaceName:String):JViewport {
        return JViewport(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JTable} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JTable} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JTable}
     */
    public static function getTable(awmlID:String, namespaceName:String):JTable {
        return JTable(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JTree} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JTree} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JTree}
     */
    public static function getTree(awmlID:String, namespaceName:String):JTree {
        return JTree(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JAdjuster} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JAdjuster} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JAdjuster}
     */
    public static function getAdjuster(awmlID:String, namespaceName:String):JAdjuster {
        return JAdjuster(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JSpacer} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JSpacer} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JSpacer}
     */
    public static function getSpacer(awmlID:String, namespaceName:String):JSpacer {
        return JSpacer(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JListTree} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JListTree} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JListTree}
     */
    public static function getListTree(awmlID:String, namespaceName:String):JListTree {
        return JListTree(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JSplitPane} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JSplitPane} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JSplitPane}
     */
    public static function getSplitPane(awmlID:String, namespaceName:String):JSplitPane {
        return JSplitPane(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JMenuBar} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JMenuBar} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JMenuBar}
     */
    public static function getMenuBar(awmlID:String, namespaceName:String):JMenuBar {
        return JMenuBar(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JMenu} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JMenu} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JMenu}
     */
    public static function getMenu(awmlID:String, namespaceName:String):JMenu {
        return JMenu(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JMenuItem} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JMenuItem} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JMenuItem}
     */
    public static function getMenuItem(awmlID:String, namespaceName:String):JMenuItem {
        return JMenuItem(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JCheckBoxMenuItem} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JCheckBoxMenuItem} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JCheckBoxMenuItem}
     */
    public static function getCheckBoxMenuItem(awmlID:String, namespaceName:String):JCheckBoxMenuItem {
        return JCheckBoxMenuItem(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.JRadioButtonMenuItem} instance by <code>awmlID</code>.
     * 
     * @param awmlID the AWML ID of the {@link GUI.fox.aswing.JRadioButtonMenuItem} to get
     * @param namespaceName (optional) the namespace to search component in
     * @return the AWML {@link GUI.fox.aswing.JRadioButtonMenuItem}
     */
    public static function getRadioButtonMenuItem(awmlID:String, namespaceName:String):JRadioButtonMenuItem {
        return JRadioButtonMenuItem(getComponent(awmlID, namespaceName));
    }

    /**
     * Returns AWML {@link GUI.fox.aswing.ButtonGroup} instance by its <code>id</code>.
     * 
     * @param id the ID of the {@link GUI.fox.aswing.ButtonGroup} to get
     * @return the {@link GUI.fox.aswing.ButtonGroup} instance or <code>null</code>
     * 
     * @see ButtonGroupManager#get
     */
    public static function getButtonGroup(id:String):ButtonGroup {
        return ButtonGroupManager.get(id);
    }
    
    
	/**
	 * addEventListener(id:String, object:Object)<br>
	 * addEventListener(id:String, class:Function)<br>
	 * <p>Registers object's instance or class as event listener within parser and
	 * associates it with the specified <code>id</code>.
	 * @param id the <code>id</code> of the instance or class to refer it from the AWML
	 * @param listener the reference to the class or object's instance
	 * @see AwmlParser#addEventListener 
	 */
	public static function addEventListener(id:String, listener:Object):Void {
		AwmlParser.addEventListener(id, listener);
	} 
	
	/**
	 * removeEventListener(id:String)<br>
	 * removeEventListener(object:Object)<br>
	 * removeEventListener(class:Function)<br>
	 * 
	 * <p>Unregister AWML event listener by specified <code>id</code> or reference to class
	 * or object's instance
	 * @param idOrListener the <code>id</code> or reference to the instance or class to remove
	 * @see AwmlParser#removeEventListener
	 */
	public static function removeEventListener(idOrListener:Object):Void {
		AwmlParser.removeEventListener(idOrListener);
	}
		
	/**
	 * Removes all registered AWML listeners.
	 * @see AwmlParser#removeAllEventListeners
	 */
	public static function removeAllEventListeners(Void):Void {
		AwmlParser.removeAllEventListeners();
	}
	    
    private function AwmlManager() {
        //  
    }
}